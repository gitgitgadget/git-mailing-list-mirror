From: Guillermo Gonzalez <guillermog@tricuspide.com>
Subject: Re: Commit ID of a branch
Date: Tue, 17 Aug 2010 14:35:40 +0200
Message-ID: <AANLkTikdVh9-60UjJW3vOp7jPA8_D_L+GqQ-9B5tcVeB@mail.gmail.com>
References: <loom.20100816T231539-211@post.gmane.org>
	<4C69CD2C.9000700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 14:35:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlLOO-0005HV-Lg
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 14:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175Ab0HQMfm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 08:35:42 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38539 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab0HQMfm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 08:35:42 -0400
Received: by yxg6 with SMTP id 6so2430601yxg.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 05:35:41 -0700 (PDT)
Received: by 10.231.35.196 with SMTP id q4mr7632942ibd.38.1282048541073; Tue,
 17 Aug 2010 05:35:41 -0700 (PDT)
Received: by 10.231.32.9 with HTTP; Tue, 17 Aug 2010 05:35:40 -0700 (PDT)
In-Reply-To: <4C69CD2C.9000700@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153748>

Thank you!

On 17 August 2010 01:43, Chris Packham <judge.packham@gmail.com> wrote:
> On 16/08/10 14:19, Guillermo wrote:
>> Hello,
>>
>> I want to write a script what checks in all my projects which is the=
 submodule
>> commit that is registered in every git repo.
>>
>> Lets say we have the following structure:
>>
>> project1
>> - submodule1
>> project2
>> - submodule1
>>
>> I want to find out what file within the .git dir of every project co=
ntains the
>> proper submodule Commit ID that should be checkout with git submodul=
e update.
>>
>> Regards,
>> Guillermo
>
> If I understand your question correctly, what you want is
>
> =A0git ls-tree HEAD submodule1
>
> Which will give you the sha1 of the commit in the submodule your proj=
ect
> should be pointing to. We use this in various scripts at work.
>
> It is also possible to get this information (and more) from a slightl=
y
> friendlier submodule command if you want it for non-script usage.
>
> =A0git submodule status
>



--=20
Guillermo
