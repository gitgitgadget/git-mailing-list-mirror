From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: How to find all the commits that comprise a branch?
Date: Thu, 31 May 2012 14:56:31 +0200
Message-ID: <CAMP44s3Fn3nai3TqCpYRxyV=3=d3vm5aPd-VgZWpVXb4qC8W8Q@mail.gmail.com>
References: <CAMP44s2kEMK8ik2NTiP4uiN4FPWFNYNJfY5qh5QE_hRH2AiNYA@mail.gmail.com>
	<CAMK1S_i5-ALrMA+iJ1Q4R5FuVbjVdFLfxKoEF4BVHERHSzmjeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 14:56:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa4ve-0004ey-0K
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 14:56:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756895Ab2EaM4d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 May 2012 08:56:33 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:64047 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283Ab2EaM4c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 May 2012 08:56:32 -0400
Received: by lbbgm6 with SMTP id gm6so799647lbb.19
        for <git@vger.kernel.org>; Thu, 31 May 2012 05:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=r7yQ2O41epbXhHTbtJoHx6h4h91hW/0ag+GuPLxK0sM=;
        b=T4/l3HsdSMsLo0Mo8f87DmoRT3OHezfEN7dGWy08CCCFzja8E0CocXC4BWe8GCkQ+l
         PxOAgC/n3yLVz6quuZtOWOSnNShrxYyIBcXkBPN0GhALvZhEdvf0b1ksgjC0D5kBIfFL
         8vXDYSMW6r36t4i2pj80rIIvEHgDMeOrpJQ5QUR1A6YvmzXR0ccWjwnOUqm0TC2Cam7D
         W+BZpGHeocmml1FPWEgmzOD45wd4kMjzWnfO9w3wRuX+O45SZ55qE2GrrliJSV5sgLOL
         oZes9b7uDfsgHsTSKMeNdVtmmSdrtHQCiw11FqlTkx0A62j/7I74zUrC+v4n11oG+Kzr
         6skg==
Received: by 10.112.83.228 with SMTP id t4mr8810170lby.74.1338468991265; Thu,
 31 May 2012 05:56:31 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Thu, 31 May 2012 05:56:31 -0700 (PDT)
In-Reply-To: <CAMK1S_i5-ALrMA+iJ1Q4R5FuVbjVdFLfxKoEF4BVHERHSzmjeg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198887>

On Thu, May 31, 2012 at 5:22 AM, Sitaram Chamarty <sitaramc@gmail.com> =
wrote:
> On Wed, May 30, 2012 at 11:09 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Hi,
>>
>> Basically what I want to do is:
>>
>> =C2=A0% git log branch ^<any-other-branch>
>>
>> IOW; all the commits were 'git branch --contains' would show 'branch=
'
>> and nothing else.
>
> I have a script called "otb" (only this branch, I guess; I tend to us=
e
> crappily short names for stuff I don't make public!) that looks like
> this:
>
> #!/bin/bash
>
> m=3D$(git rev-parse HEAD)
> n=3D$(git rev-parse --branches | grep -v $m)
> git log --oneline $m --not $n
>
> I think that fits your description, but it's not *one* command.

Yeap, I was thinking on doing something along those lines... but hoped
there was a single command for it.

Cheers.

--=20
=46elipe Contreras
