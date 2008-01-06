From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] rebase interactive: Add hint how to continue after 'Unknown command' error
Date: Sun, 6 Jan 2008 18:33:32 +0100
Message-ID: <5F80ADF7-A68A-4DF3-8453-92B76BC927EF@wincent.com>
References: <1199634385511-git-send-email-prohaska@zib.de>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jan 06 18:34:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBZNq-0005wF-Js
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 18:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698AbYAFRdf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jan 2008 12:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755004AbYAFRdf
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 12:33:35 -0500
Received: from wincent.com ([72.3.236.74]:58723 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754239AbYAFRde convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jan 2008 12:33:34 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m06HXXro031706;
	Sun, 6 Jan 2008 11:33:33 -0600
In-Reply-To: <1199634385511-git-send-email-prohaska@zib.de>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69736>

El 6/1/2008, a las 16:46, Steffen Prohaska escribi=F3:

> @@ -310,7 +310,7 @@ do_next () {
> 		;;
> 	*)
> 		warn "Unknown command: $command $sha1 $rest"
> -		die_with_patch $sha1 "Please fix this in the file $TODO."
> +		die_with_patch $sha1 "Please fix this in the file $TODO. And run =20
> 'git rebase --continue'."

Grammar nit: sentences can't start with "And", so that should really be=
:

"Please fix this in the file $TODO and run 'git rebase --continue'."

Cheers,
Wincent
