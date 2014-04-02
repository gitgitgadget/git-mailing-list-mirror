From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Bug in git-diff output
Date: Wed, 02 Apr 2014 14:09:51 +0200
Message-ID: <vpqmwg4c4q8.fsf@anie.imag.fr>
References: <CALgQ2n-vPK6_0LnWA_AAD2GLvepjLN4A3UZFCAWzEp9r_=XOVg@mail.gmail.com>
	<CALgQ2n9VXVpqXe1NQO4+b-Ngmbhxnza52GJqr81t_ubLfjY75g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "rocketscienc01100101 ." <rocketscienc01100101@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:48:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeNf-0000xS-Cx
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758397AbaDBMJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 08:09:56 -0400
Received: from mx1.imag.fr ([129.88.30.5]:51718 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758207AbaDBMJz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 08:09:55 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s32C9oaF008054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 2 Apr 2014 14:09:50 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s32C9pGE007994;
	Wed, 2 Apr 2014 14:09:51 +0200
In-Reply-To: <CALgQ2n9VXVpqXe1NQO4+b-Ngmbhxnza52GJqr81t_ubLfjY75g@mail.gmail.com>
	(rocketscienc's message of "Wed, 2 Apr 2014 13:05:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 02 Apr 2014 14:09:50 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s32C9oaF008054
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1397045391.31765@orLIIDaMkYX4FddEYbvPKA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245722>

"rocketscienc01100101 ." <rocketscienc01100101@gmail.com> writes:

> http://i.imgur.com/BoJSjm9.png
>
> Here's a screenshot that shows the problem.

(better cut-and-paste the text than sending a PNG image)

> There's always a misplaced line in the output (most of the time
> a[href^=tel] { }), no matter where in the file the changes are.

The part after the @@ are ignored by patch tools. They are here just for
convenience. They are a guess of what the patch hunk belongs to. For
C/Java/Ada/... programs, it's the function name. Git does not know about
CSS syntax, so it guesses wrong (last line starting with a letter I
guess, not sure exactly what happens when Git doesn't know the syntax).

But don't worry, these are juste hints for human, they are harmless.

> Sometimes it's even in the wrong position, above the @@ numbers.

That is strange. Do you have a way to reproduce this?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
