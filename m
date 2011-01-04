From: Alexander Gladysh <agladysh@gmail.com>
Subject: Re: False positives in git diff-index
Date: Tue, 4 Jan 2011 15:01:56 +0300
Message-ID: <AANLkTinfbyve-k8xBzDb1sTcXhJGvL_B+auuA8BQSUy2@mail.gmail.com>
References: <AANLkTimLW+J_rmRsqUQJO-9Gzn7aK0ZHkd1-s=Wg4Vbi@mail.gmail.com>
 <AANLkTinDSCPz-oukxzn24hj94d9WpzZ8_64TBHeNTmoG@mail.gmail.com> <AANLkTi=Po7zA1YG-VdN6cZEV+ZF3GYNM9W9CLVXFaE5Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Zenaan Harkness <zen@freedbms.net>
X-From: git-owner@vger.kernel.org Tue Jan 04 13:02:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pa5ao-00034d-Pu
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 13:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063Ab1ADMCS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jan 2011 07:02:18 -0500
Received: from mail-qy0-f194.google.com ([209.85.216.194]:60223 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750906Ab1ADMCR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jan 2011 07:02:17 -0500
Received: by qyk4 with SMTP id 4so4348661qyk.1
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 04:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=7F8Tb4xAze1ur5Xs66qCveyW1MASdq1dDwyjcWPVZ24=;
        b=Fl9WfN2a50jI1ZtUsiaWkjpR0YAkrDRjj3dDSev+sVN7GxN1UN57QufsF6+gXkhvkF
         eSzYWrhVd51m+ZKrhwn9eusGETkwmrzuYlBI/kX/WPbCHHB1N9jZwC1mdLmywSW1E1ih
         leluysWCtziFNHd5VOhHRIG9HmTQer49xabnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RhR3CceWk+ZBV4M+6EfILgYanPJDxG91ACcmBq1kADNY7fSO9mmHZbdN8PtZdnPszb
         ZcO793HIfgWfO5t9pFrpkYocf3bGiZH+tcU88cy/xFAtMK7Is+VOjOMrxtRM8y1E86Vj
         ovjjeykjwYF8fcnicjFKj/vJTM4H2rCK/U0d0=
Received: by 10.229.79.12 with SMTP id n12mr18725362qck.129.1294142536730;
 Tue, 04 Jan 2011 04:02:16 -0800 (PST)
Received: by 10.229.48.5 with HTTP; Tue, 4 Jan 2011 04:01:56 -0800 (PST)
In-Reply-To: <AANLkTi=Po7zA1YG-VdN6cZEV+ZF3GYNM9W9CLVXFaE5Z@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164485>

On Tue, Jan 4, 2011 at 14:47, Zenaan Harkness <zen@freedbms.net> wrote:
> On Tue, Jan 4, 2011 at 20:45, Alexander Gladysh <agladysh@gmail.com> =
wrote:
>> Nobody is interested?

> Your problem set appears that you have a rather gnarly corner case
> issue, arising from your custom build processes. Although git really
> is amazing, I believe you may well be pushing git to its technologica=
l
> limits.

Committing few megabytes of data several times per second is
technological limits? I do not believe so.

> So your problem could be quite hard to debug, whilst being distinctly
> difficult to ascertain the root causes.

> It also appears that your custom complicated build process is likely
> protecting, or at least integral to, your high value corporate proces=
s
> assets.

> So _in this case_ you would be remiss to not find a suitable
> consultant to provide professional and discreet assistance - perhaps
> GitHub.com, as GitHub=E2=80=99s Tender provides both public and _priv=
ate_
> support issue posting, and customized and private training if you and=
/
> or your colleagues require; you might contact GitHub direct (
> https://github.com/contact ) as their Support page does not link
> directly to support contract information; oh, and GitHub supports a
> lot of community projects too: their support for our community ought
> be supported.

> <disclaimer> I am _not_ affiliated with GitHub, I do work full time
> with a human rights association in Australia.

Thank you for your opinion.

I view this particular situation as follows:

1. I found a reproducible case for a hard to catch bug in Git. (This
is a bug in Git, not in my build process.) This bug in its
intermittent form annoyed me for quite some time =E2=80=94 several mont=
hs at
least =E2=80=94 and is likely to annoy other users. (I'm not *that* uni=
que!)

2. I can live happily with sleep(0.2) in my deployment code (while
this is not very satisfying, it is acceptable =E2=80=94 certainly cheap=
er than
a paid consultant).

3. I'm willing to help Git developers with catching this bug for
mutual benefit =E2=80=94 I will get rid of annoying issue and make my
deployment code more robust. Git will, well, be a bit more robust as
well.

4. The sole reason I'm pinging back on this bug report is that I'm
afraid to accidentally lose the data snapshot (or something in
environment) that makes the issue reproducible.

5. If no one is interested, well, that's opensource :-) No hard feeling=
s.

Alexander.
