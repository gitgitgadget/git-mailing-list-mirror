From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [RFC PATCH 3/3] git-grep: Learn PCRE
Date: Tue, 3 May 2011 19:15:00 -0400
Message-ID: <BANLkTimcj7do9=+PZ0=5+gBth59Ti5UxZA@mail.gmail.com>
References: <1304458557-25629-1-git-send-email-michal.kiedrowicz@gmail.com> <1304458557-25629-3-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?ISO-8859-2?Q?Micha=B3_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 04 01:15:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHOoo-0006IV-2F
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 01:15:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807Ab1ECXPX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 May 2011 19:15:23 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46144 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754339Ab1ECXPU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2011 19:15:20 -0400
Received: by ywj3 with SMTP id 3so228380ywj.19
        for <git@vger.kernel.org>; Tue, 03 May 2011 16:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=WOYI3RLKKHgZZhSOJbmuZVxfHxk+hRQV3gA1aJBh4pI=;
        b=cVajuXm9V5DbbvyNoZ8xy98pOPPAQLq7vHblVsctCQ51y8ox36iNa54mltR3Y0Pqof
         608gGWAPDkzdBmH3kBNWefJ0s8A6GH98vQG0ebnkVgPAXW0UzNh2iu7P8mevy7Eb24CL
         ObwHGSCMnsoaPfl69/Upu4/5QqiQ2b9/I5EwE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=IvFcZ9Xh5etrnJwcwTy9TfXzvhkZFg1pg7PMolEYMAzygyTdSX9hvRhJyCBgGIGq0J
         p64B9Lsvup+Ab9h0MAOGG3wZnNE0PPjvynwTr/v3MGQ4h8FkK3pc5JTHeZhchAhE/oSw
         sQWyQjGfiw6Q85zJazMgjW5cJDPdsjM8Y7UBo=
Received: by 10.91.4.19 with SMTP id g19mr485896agi.193.1304464520113; Tue, 03
 May 2011 16:15:20 -0700 (PDT)
Received: by 10.90.89.19 with HTTP; Tue, 3 May 2011 16:15:00 -0700 (PDT)
In-Reply-To: <1304458557-25629-3-git-send-email-michal.kiedrowicz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172701>

2011/5/3 Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>:
> This is quite minimal (I hope) patch that teaches git-grep the
> --perl-regexp/-P options in order to allow specifying PCRE regexes on
> the command line.

Oh joy!



m
--=20
=C2=A0martin.langhoff@gmail.com
=C2=A0martin@laptop.org -- Software Architect - OLPC
=C2=A0- ask interesting questions
=C2=A0- don't get distracted with shiny stuff=C2=A0 - working code firs=
t
=C2=A0- http://wiki.laptop.org/go/User:Martinlanghoff
