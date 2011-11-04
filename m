From: Hong-Ming Su <halleyinvent@gmail.com>
Subject: Re: How to make "git push/pull" work in non-clone repo?
Date: Fri, 4 Nov 2011 11:33:04 +0800
Message-ID: <CANiMyiEmDhErgT4PKpbzrCB1=a1kmdta0uDKV+tFAtOQc4tkKA@mail.gmail.com>
References: <CANiMyiFfiLnK8-q7vTZ9VAtkW8ip2NQfpR4iaU2oSnnonVDuUA@mail.gmail.com>
	<F802D297-95A0-4B1E-894D-9681E0EEF3AD@jetbrains.com>
	<CANiMyiF=C_uBXf3kV8ix=CY9Mi=cxHU-J3dn5UyJ87gu3Sm0dg@mail.gmail.com>
	<m2fwi5nnt8.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>,
	git <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Nov 04 04:33:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMAWt-0006aR-3i
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 04:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093Ab1KDDdI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Nov 2011 23:33:08 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:57105 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923Ab1KDDdG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Nov 2011 23:33:06 -0400
Received: by eye27 with SMTP id 27so1705229eye.19
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 20:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=00xzFyBAM3xceRd9QELGUHWJsVJAJ3+kySOyB5BLD5s=;
        b=cdSb30PUCV40zAWL9Fu65m4huiJLGq1cYCwB4B/NLUwMe/Lrs8FlWbt8hNLIvnBV0y
         jFduiTLy3cYgxZaF6p6Q52lonolRg1ME+jG/aOZdTZYrMV/hETQA5pct0ytgvChQVq2v
         +YZk7Vmdg8KF7dklnR4yByunaseOh7odhCvH0=
Received: by 10.14.16.97 with SMTP id g73mr1202615eeg.73.1320377584968; Thu,
 03 Nov 2011 20:33:04 -0700 (PDT)
Received: by 10.14.127.4 with HTTP; Thu, 3 Nov 2011 20:33:04 -0700 (PDT)
In-Reply-To: <m2fwi5nnt8.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184757>

git push -u can set upstream too.
Thanks all!

On Fri, Nov 4, 2011 at 1:00 AM, Andreas Schwab <schwab@linux-m68k.org> =
wrote:
> Hong-Ming Su <halleyinvent@gmail.com> writes:
>
>> /d/workspace/git/work1 (master)
>> $ git remote add origin ../depot
>
> $ git branch --set-upstream master origin/master
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756 =A001D3 44D5 214B 82=
76 4ED5
> "And now for something completely different."
>
