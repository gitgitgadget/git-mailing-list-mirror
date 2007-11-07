From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Wed, 07 Nov 2007 15:45:02 +0100
Message-ID: <vpq7ikudsi9.fsf@bauges.imag.fr>
References: <11944127311587-git-send-email-shawn.bohrer@gmail.com>
	<Pine.LNX.4.64.0711071110040.4362@racer.site>
	<18225.48553.44088.269677@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Shawn Bohrer <shawn.bohrer@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 15:46:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpmAf-0003Ox-BU
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 15:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbXKGOqF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 09:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753376AbXKGOqE
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 09:46:04 -0500
Received: from imag.imag.fr ([129.88.30.1]:61461 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753379AbXKGOqD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 09:46:03 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id lA7Ej3Zn026214
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 7 Nov 2007 15:45:03 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Ipm9O-0004AL-VP; Wed, 07 Nov 2007 15:45:03 +0100
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Ipm9O-0008P6-Sl; Wed, 07 Nov 2007 15:45:02 +0100
In-Reply-To: <18225.48553.44088.269677@lisa.zopyra.com> (Bill Lear's message of "Wed\, 7 Nov 2007 07\:29\:13 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Wed, 07 Nov 2007 15:45:05 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63810>

Bill Lear <rael@zopyra.com> writes:

> I've always found this a thoughtful practice.  It helps ensure nobody writes:
>
>        if (bla)
>            just_one_line();
>            /* perhaps a comment, other stuff ... */
>            just_another_line();

It also simplify patches for cases like

 	if (bla) {
 		just_one_line();
+		another_added_line();
 	}

instead of

- 	if (bla)
+ 	if (bla) {
 		just_one_line();
+		another_added_line();
+	}

But it seems people here prefer not putting the braces in this case.

-- 
Matthieu
