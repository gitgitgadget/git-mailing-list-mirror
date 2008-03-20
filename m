From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] help: use man viewer path from "man.<tool>.path"
 config var
Date: Thu, 20 Mar 2008 09:51:33 -0700
Message-ID: <7vtzj1wd7u.fsf@gitster.siamese.dyndns.org>
References: <20080318062236.7b5e515f.chriscool@tuxfamily.org>
 <7vabkv7t4c.fsf@gitster.siamese.dyndns.org>
 <200803200849.14664.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pascal Obry <pascal@obry.net>, Xavier Maillard <xma@gnu.org>,
	=?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 17:52:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcO0F-0003w8-Py
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 17:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754730AbYCTQvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 12:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754452AbYCTQvv
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 12:51:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbYCTQvu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 12:51:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1F555223B;
	Thu, 20 Mar 2008 12:51:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id E22402233; Thu, 20 Mar 2008 12:51:36 -0400 (EDT)
In-Reply-To: <200803200849.14664.chriscool@tuxfamily.org> (Christian Couder's
 message of "Thu, 20 Mar 2008 08:49:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77671>

Christian Couder <chriscool@tuxfamily.org> writes:

> Yes, but if the user just wants to use a konq that is not in the path, then 
> the konq specified with "man.konqueror.path" should behave the same as when 
> using the konq in the path. That means that we should also try to open a 
> new tab on an existing konq, and this will not be the case if we 
> use "/path/konqueror URL" instead of "/path/kfmclient newTab URL".

If that inconsistency bothers you, you probably should rename the built-in
konqueror support to "kfmclient", which is more honest approach, I would
think.
