From: Oliver Runge <oliver.runge@gmail.com>
Subject: Re: rev-list pretty format behavior
Date: Wed, 8 Apr 2015 19:12:05 +0200
Message-ID: <CAHaCNWKYY_5JvuAk76wnrTTBaBQM2Fv8hz37tEYC5Jzm1tY-RQ@mail.gmail.com>
References: <CAHaCNWJZQRVxp3ponvh3pPEk=sOHGYypyhi1Dc8HX5gkKEBGrQ@mail.gmail.com>
	<xmqqlhi6cma5.fsf@gitster.dls.corp.google.com>
	<CAHaCNWJ+S7Qa0=x2Xo2+HMQa0jz_tT8G+Wp1ugB4UHwBfOZRTg@mail.gmail.com>
	<5523E175.2060607@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Apr 08 19:12:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YftWO-0003iw-FF
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 19:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754148AbbDHRMI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 13:12:08 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33956 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbbDHRMG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 13:12:06 -0400
Received: by qkgx75 with SMTP id x75so90501612qkg.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2015 10:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=AJXliRQ7M9i8Bg00qmjpc2W3+3RG8ofw13qbkflAjiU=;
        b=hjCxD4KM40RJrHy1eOG7Iuec2O+FzK9ECv6otDfMp4fSurL+Zm9IfYO+NK9qK4mnqP
         YgPG7XrdRWewAkJPgqXd3rX+lSQ5/enGp1MsQHR1zGWqT9C07xcgbtdXhqJnZ7YEk4aA
         GhapjgoMX6AEnQNBOkh7LW1BYUzO2e1yiBMbbgehknQ5MCNIKaQmP1eN5ihoCkZbay+X
         Sp22MjHtuQR/JTgqcsG0jwwA9RjM4RVxwfZO3vYZews+0ELVgnSMKiZjXltDz/Yx8pww
         CtKw95u30U0MkftSFTiF5QDVOiUDE+LPmwutcKh6KscC/HyUmIAH2tGDBHBaZvOGAjF7
         ROCw==
X-Received: by 10.55.31.218 with SMTP id n87mr48818781qkh.99.1428513125763;
 Wed, 08 Apr 2015 10:12:05 -0700 (PDT)
Received: by 10.140.42.47 with HTTP; Wed, 8 Apr 2015 10:12:05 -0700 (PDT)
In-Reply-To: <5523E175.2060607@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266966>

Heyup, Dr. Gruber.

On 7 April 2015 at 15:53, Michael J Gruber <git@drmicha.warpmail.net> wrote:
> I'm wondering what the difference is - or should be - between "git log"
> and "git rev-list" with (completely) user specified output. That
> question goes both ways:
>
> - Why do we need "rev-list" to have completely flexible output when we
> have "log" with such flexibility?
>
> - Why do we even have pretty formats for "rev-list"?
>
> I'm thinking of rev-list as a raw (plumbing) revision lister much like
> cat-file is the inspection tool for the objects, and log as the human
> facing output with appropriate defaults (resp. show).
>
> Note that "rev-list -v" isn't even documented afaics.

I can't answer your questions, because I don't have a very deep
understanding of either command, but according to the "log" docu,
formating really belongs to "rev-list" and "log" only adds the diff-*
features:
------------------------------------------
The command takes options applicable to the git rev-list command
to control what is shown and how, and options applicable to the
git diff-* commands to control how the changes each commit
introduces are shown.
------------------------------------------

I also feel that perhaps "pretty" is a bit of a misnomer and naturally
is associated with "human readable", but the formating is vital for
any raw output that scripts can process.

Oliver
