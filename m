From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not
 been set
Date: Wed, 23 Jul 2008 12:23:00 -0700
Message-ID: <7vhcagcsmj.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807222255450.8986@racer>
 <7vy73tihl6.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807230203350.8986@racer>
 <7vej5kfs0w.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807231817460.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:24:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLjwU-0007dw-Hk
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 21:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbYGWTXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 15:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752675AbYGWTXI
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 15:23:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36462 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbYGWTXG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 15:23:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 89F9537A67;
	Wed, 23 Jul 2008 15:23:05 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DC65337A66; Wed, 23 Jul 2008 15:23:02 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807231817460.8986@racer> (Johannes
 Schindelin's message of "Wed, 23 Jul 2008 18:22:51 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C66CB7F0-58EC-11DD-A5F6-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89750>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 23 Jul 2008, Junio C Hamano wrote:
> ...
>> If you are on a sane system, you do not even want to pay the price of 
>> conversion.  Only people on systems with CRLF line endings should pay 
>> the price (because your aim is to convert on such systems).  Are we 
>> throwing that out of the window when the project decides to use 
>> gitattributes?
>
> Well, if you do not want that, why do you set crlf in the gitattributes to 
> begin with?

It is not _me_ but the project upstream that needs to interact also with
Windows people who manages gitattributes.  And me personally knows my
editors are not helpful to add CR at the end of lines, so I do not need
the conversion.

That was the situation I had in mind.
