From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add MIME information to outgoing email
Date: Thu, 13 Mar 2008 11:48:23 -0700
Message-ID: <7vhcfaxxxk.fsf@gitster.siamese.dyndns.org>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 19:49:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZsUN-00088I-Lu
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 19:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752267AbYCMSsg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 14:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752189AbYCMSsg
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 14:48:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61875 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbYCMSsf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 14:48:35 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 92FCE18A6;
	Thu, 13 Mar 2008 14:48:34 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 04DB518A3; Thu, 13 Mar 2008 14:48:30 -0400 (EDT)
In-Reply-To: <1205426419-4594-1-git-send-email-sam@rfc1149.net> (Samuel
 Tardieu's message of "Thu, 13 Mar 2008 17:40:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77126>

Samuel Tardieu <sam@rfc1149.net> writes:

> Add MIME-Version/Content-Type/Content-Transfer-Encoding headers in
> messages generated with git-format-patch. Without it, messages generated
> without using --attach or --inline didn't have any content type information.

Isn't that job for send-email (or user's MUA)?  I really do not think we
want to clutter format-patch output any more than necessary.
