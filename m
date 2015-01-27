From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH] INSTALL: minor typo fix
Date: Wed, 28 Jan 2015 06:15:40 +1300
Message-ID: <CAFOYHZAWT+7tKYArtRK7hp5NTvLYQGv__9E+4-7zuVGnzQ7BzQ@mail.gmail.com>
References: <1422375312-3798-1-git-send-email-kuleshovmail@gmail.com>
	<CAFOYHZBiMvU5=EpX7qn0wwrUwfZ2xzATKqRo4zPH+xmro7wVbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, GIT <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 18:15:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YG9jt-0005NV-GN
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 18:15:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553AbbA0RPl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 12:15:41 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:56411 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbbA0RPk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 12:15:40 -0500
Received: by mail-pd0-f172.google.com with SMTP id v10so20031277pde.3
        for <git@vger.kernel.org>; Tue, 27 Jan 2015 09:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xHzn7aXtsKVQmRORFYcDQqwhI8QfVCW9b04DKjJJIEM=;
        b=o9QlqhjhlY0c+xZ8Hdki9hD/RP1RgJio38MJYkOnka9/mbWi79vubM8MpLrMbbaYHr
         9R+icXgsyK+tvkNTfY6SNq05g4Cj1YquyrEyIuE9OVRELt4pYpgazlwSigla2Ph/m2Xg
         GvZEhOtpdtq51b3PsVtJmnRDicvluJHW4F21Juaxb5F4+PduSXKc7g3ETQzHry3kpdU6
         qPi4G3v41YGb/rgq/TrOAgoC+k2f44oGMygLpUGSSjs1XOEFypihmn1Gmgam8AOWXrV1
         ISQ8vwo2Tqzyholvk+UG5TSL4zPo36SjFagaRL4+ov/P3G1y3KALwMPu73/MRDK1pxP1
         kF6Q==
X-Received: by 10.70.49.99 with SMTP id t3mr3605632pdn.105.1422378940369; Tue,
 27 Jan 2015 09:15:40 -0800 (PST)
Received: by 10.70.109.199 with HTTP; Tue, 27 Jan 2015 09:15:40 -0800 (PST)
In-Reply-To: <CAFOYHZBiMvU5=EpX7qn0wwrUwfZ2xzATKqRo4zPH+xmro7wVbA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263078>

On Wed, Jan 28, 2015 at 6:09 AM, Chris Packham <judge.packham@gmail.com> wrote:
> Hi Alexander
>
> On Wed, Jan 28, 2015 at 5:15 AM, Alexander Kuleshov
> <kuleshovmail@gmail.com> wrote:
>> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
>> ---
>>  INSTALL | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/INSTALL b/INSTALL
>> index ffb071e..6f1c3d5 100644
>> --- a/INSTALL
>> +++ b/INSTALL
>> @@ -53,7 +53,7 @@ or
>>
>>  As a caveat: a profile-optimized build takes a *lot* longer since the
>>  git tree must be built twice, and in order for the profiling
>> -measurements to work properly, ccache must be disabled and the test
>> +measurements to work properly, cache must be disabled and the test
>>  suite has to be run using only a single CPU.  In addition, the profile
>>  feedback build stage currently generates a lot of additional compiler
>>  warnings.
>> --
>
> That's not a typo ccache[1] is a compiler cache tool that can be used
> to speed up rebuilding object files. I don't know anything about the
> profile enabled builds but I imagine it has something to do with
> needing the 2nd build to produce difference object files from the

s/difference/different/

> first (with ccache enabled I imagine the 2nd build would result in
> identical output since on source files are changed between builds).
>
> --
> [1] - https://ccache.samba.org/

The commit that added that note f2d713fc[1] has a bit more of an
explanation of why profile enabled builds and ccache are incompatible.

[1] - https://github.com/git/git/commit/f2d713fc3e8e0b7be89584f04b421808aa99c403
