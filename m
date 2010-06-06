From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
Date: Sun, 6 Jun 2010 14:26:08 -0700
Message-ID: <AANLkTilvHl-8eA6CbEDs4ty3h0h670L_enGsXunHxaPE@mail.gmail.com>
References: <20100605110930.GA10526@localhost> <AANLkTilbg2nGr_sVmJLboMgXbas_qsB4V6gYxDxcDgKy@mail.gmail.com> 
	<20100605135811.GA14862@localhost> <AANLkTikE5BPD_DDqwEvPGxsMAIQCulpVwRKaCSnULcoP@mail.gmail.com> 
	<20100606161805.GA6239@coredump.intra.peff.net> <20100606165554.GB10104@localhost> 
	<AANLkTinTI3XaE6P_WZ_k56fgI4LNOLSalv_1GlVZNO7n@mail.gmail.com> 
	<20100606173233.GA11041@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Sverre Rabbelier <srabbelier@gmail.com>,
	git@vger.kernel.org, Peter Rabbitson <ribasushi@cpan.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Jun 06 23:26:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLNMZ-0001QG-1k
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 23:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728Ab0FFV0a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jun 2010 17:26:30 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51179 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab0FFV03 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jun 2010 17:26:29 -0400
Received: by vws5 with SMTP id 5so2465702vws.19
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 14:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=d6otlRCZqWIAyDlddgx1t2o7HMLWVyCVeoX8uodwOeo=;
        b=K/CgreS55jnaRz4p9Di0cmBpC4Z/RoId+m/t4dX5Bp2Xr3agpX1msSZ6ikQVTiC0I5
         /ewHPuxffJiXCLzKM9Xl8cHAtx+8T0c9fZLv/P/A7ki3ALCw4LCROPuV8IuvmGxMtI7i
         wXAOcoWgPCGAJpFwefsNVcAYpxWLrmIDUFZtU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Q4V7XtOxLtL47MmebridORLsozOwC+I2yNgA2hLXhtPozApS5PzAsGaM1q/3v5szwP
         P3yVAYEN9uqfVz0OlX5i6uYBN93yXARG6otAe+n/q3nAeALQTe7rWpnWezetIwgBO8Tb
         5QQILdXu3mbK+hItkAQiC+TNdlJTMNlgASC1U=
Received: by 10.229.215.213 with SMTP id hf21mr1661339qcb.255.1275859588280; 
	Sun, 06 Jun 2010 14:26:28 -0700 (PDT)
Received: by 10.229.24.3 with HTTP; Sun, 6 Jun 2010 14:26:08 -0700 (PDT)
In-Reply-To: <20100606173233.GA11041@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148545>

On Sun, Jun 6, 2010 at 10:32, Clemens Buchacher <drizzd@aon.at> wrote:
> On Sun, Jun 06, 2010 at 09:59:08AM -0700, Jacob Helwig wrote:
>> On Sun, Jun 6, 2010 at 09:55, Clemens Buchacher <drizzd@aon.at> wrot=
e:
>> >
>> > I argue that people are more likely to be surprised and confused b=
y
>> > this feature rather than being accustomed to it already. I am also
>> > waiting to hear from someone who actively uses this feature.
>> >
>>
>> I am someone that "actively" uses this feature. =C2=A0I will often h=
ave
>> repositories that I use on multiple machines, and will forget which
>> remote branches I have local tracking branches for, on which machine=
s.
>> =C2=A0I'll end up just doing `git checkout $random-branch`, thinking=
 I'm on
>> one of the machines where I've already setup the local branch, and
>> find it quite handy that Git _does_ DWIM.
>
> I see. But would it be so terrible to have to type "git checkout -t
> origin/branch" instead?
>

Given that `git checkout branch` already exists & works: Yes.

You're talking about removing a feature, so (as already pointed out)
there's a fairly high burden of proof to show that it's actually a
mis-feature, that is so dangerous/confusing that it _needs_ to be
removed.

> Also, isn't this more like "foretell what I really want" rather
> than "do what it means"? Who would guess that "git checkout
> $branch" means "create $branch tracking <random-remote>/$branch"?
>

This is very much "fortell what I really want", which is exactly what
DWIM (Do What I Mean) means (as Sverre already pointed out).  I'm not
guessing that `git checkout $branch` means `git branch -t $branch
origin/$branch && git checkout $branch`; I'm assuming that `git branch
-t $branch origin/$branch` was already done at some point in the past,
and Git is adding that bit in for me, which is what _I_ really meant
to do.

> And this is exactly _why_ it can be marginally useful if the
> foretelling is correct, but all the more confusing if it's not.
>

Other than "unexpected success", how is the DWIM behavior confusing,
given that it says exactly what it's doing when the DWIM behavior is
invoked?  I'm still not clear what the confusion you're referring to
is on this one.
