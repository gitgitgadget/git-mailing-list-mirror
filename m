From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH next] test-lib: set $DIFF to diff if it is unset
Date: Thu, 10 Jun 2010 09:46:06 +0000
Message-ID: <AANLkTikCQ_up4UY445RE-wU_jeP9g63sPlix0wm6KJNo@mail.gmail.com>
References: <06ffbe0ca6aac061336f6f595e89f75c09ab88ac.1276162629.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 10 11:46:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMeL1-00054p-94
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 11:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758693Ab0FJJqJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 05:46:09 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57610 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756486Ab0FJJqH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 05:46:07 -0400
Received: by iwn37 with SMTP id 37so6846671iwn.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 02:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/6sNOH+cB/6ort8lV7evGxTLSdISQEOpmCs228WvIK8=;
        b=ox6dfeuZO6mX8FpQBCqvGYLV3usPDMJoX5hqDqHI1YStCvXNqxruUgLiW7URhzuL8N
         l62yKG3+dQ4nvVe3ptIXjHJp7b5uD0mFrN4Api8OCTOuzgkoWJGWEadoNcOPPevcudr1
         dBYVYKmmK3r6Fs5x/hjvAkYx51IbRVQy3ubk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Czuj4b5BXu9DSLIIdBZqY7Ow8910WLtmk5gUhuiSOxAGPgJh73Xp2IvY3DEz0fH3it
         O46TN/cQm3ek17AjfYI49CQM9CchYfJHVoXdES85EqbMquMmr7VctoDB3SBJxBGpqHZP
         AQtEH1V0v7KvBXuA9u/GpKqT85TJERyKcNe5Q=
Received: by 10.231.188.150 with SMTP id da22mr9086743ibb.191.1276163166577; 
	Thu, 10 Jun 2010 02:46:06 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Thu, 10 Jun 2010 02:46:06 -0700 (PDT)
In-Reply-To: <06ffbe0ca6aac061336f6f595e89f75c09ab88ac.1276162629.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148850>

On Thu, Jun 10, 2010 at 09:39, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> Since 7b3bdbb (fixup: do not unconditionally disable "diff -u",
> 2010-05-31), test-lib.sh depends on having $DIFF set in the
> environment for the construction of $GIT_TEST_CMP. =C2=A0While this w=
orks
> when called from the main Makefile, it fails if the tests are called
> on their own and the user does not have $DIFF set.
>
> Set it to 'diff' if it is unset, like the Makefile does.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
>
> I have an uneasy feeling that I must be missing something, seeing as
> this went unnoticed for 10 days...

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>

I spotted it too when preparing the TAP series, I just didn't submit a
fix for it.
