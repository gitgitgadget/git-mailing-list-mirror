From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 18:26:57 -0500
Message-ID: <k2tb4087cc51004231626jb9420742z33e8e95be608ac78@mail.gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain> 
	<20100422155806.GC4801@progeny.tock> <4BD1EE10.4010009@gmx.de> 
	<k2ub4087cc51004231234z29228ac8ia0f62a4e16cedae4@mail.gmail.com> 
	<4BD21CAB.8060903@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Sat Apr 24 01:27:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5SHM-0001FF-K8
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 01:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909Ab0DWX1T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Apr 2010 19:27:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:38475 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab0DWX1S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Apr 2010 19:27:18 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1006113fga.1
        for <git@vger.kernel.org>; Fri, 23 Apr 2010 16:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0/cy8hPblDxKOdbDm4yHgFm9M5KDCwIobbVqAu51GqI=;
        b=Kf5Zlgo0xNRayCTw9OEhR1vdT6C+gC/Y72AF3Za2g0HDoyDDDYCEhzcTm1NsVhfJEe
         vBeax7OqYuUmG+W3phBCfRYYcJ3MwdBMAE+uNagYWmxuvDS2kdsupLeFMRceqzxMGNe9
         1R4iqvPGTOfTyYRU0lHiWsntaMK+3hz4swyeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=MlVJCORxFLOSnpvd6Ycqt0VkhpkW1Os+3tULAh8gbT2OAkjV7xuH2PSUsr9kddXdWt
         OPxmgu2wyKIhdBGQwyU6xMKUL0xMTaF4hoh26chd4FWsLT9mKeAFpScvjw7ND6Vp1YNx
         1xrCvB0qiHgJxI+QyngN6xG50sGxjw6XZf6Vc=
Received: by 10.239.185.137 with SMTP id c9mr69722hbh.69.1272065237128; Fri, 
	23 Apr 2010 16:27:17 -0700 (PDT)
Received: by 10.239.189.143 with HTTP; Fri, 23 Apr 2010 16:26:57 -0700 (PDT)
In-Reply-To: <4BD21CAB.8060903@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145649>

On Fri, Apr 23, 2010 at 17:18, Matthias Andree <matthias.andree@gmx.de>=
 wrote:
> Am 23.04.2010 21:34, schrieb Michael Witten:
>> On Fri, Apr 23, 2010 at 13:59, Matthias Andree <matthias.andree@gmx.=
de> wrote:
>>> I'd also concur that "default to commit -a" would be a most undesir=
eable
>>
>> The proposal was not "default to commit -a" but rather "default to
>> commit -a when the index has not been explicitly updated with
>> something like git add".
>
> Which is the same:
>
> default (n) (5b) "a selection automatically used by a computer progra=
m
> in the absence of a choice made by the user" (Merriam-Webster)
>
> No previous "git add" =3D> default "git commit -a". =C2=A0Exactly wha=
t I don't
> want. =C2=A0It makes the software appear at nondeterministic as you a=
dd to
> the "if"s and "but"s, and it breaks established practice.

It wasn't at all clear that's what you meant.

> It is not desirable to break established workflows for the sake of
> newcomers' convenience.

It's not entirely clear (to me) that Goswin's proposal really breaks
established workflow.
