From: Robert Buck <buck.robert.j@gmail.com>
Subject: Re: newbie: need concrete examples for how the linux-kernel project 
	uses git
Date: Tue, 4 May 2010 22:11:03 -0400
Message-ID: <k2l408104421005041911t32652fb7ie9618a301d998983@mail.gmail.com>
References: <m2i408104421005041431l6c8b5845ld57720c2127fbb00@mail.gmail.com>
	 <20100505011045.GA16345@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 05 04:11:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9U4u-0006B2-Or
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 04:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760404Ab0EECLJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 22:11:09 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:34844 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756713Ab0EECLH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 May 2010 22:11:07 -0400
Received: by wwd20 with SMTP id 20so113091wwd.19
        for <git@vger.kernel.org>; Tue, 04 May 2010 19:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/5575jRoJB3shs+P5JuJ3EMCZuq9Hmv5CrYwyw2lLnY=;
        b=iXFNl7cqmnTEucNk199qPi7ekn828m4NrQklGFdYgHJDEB8anWKPaeloo4nGlcXZiU
         y/Fk6ukFqNCXABuSC5+jDDJQS8/ygYEjA0Qx0DihRueL2CGVm0BvkQjtC9gpflB5wR/7
         MJMck21jYA2DQWeqHT2p+4VCdRaC6NJfa9F8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=M+Q+yK7bID7Ex5biVFsGY4tgC6tlAWKUzq7sj/ANzwUuBLOLM0LQcXCF666JtNwzH+
         zCPcgCC8B8lYOw5S6VTSMgtf/vFft2dD48Ze+6Bl1CH+xttyks93Z95f28/D5Iacct/1
         QekrO/XCbkoeBSIHvppQAAkHbbAcxBh0DzVkk=
Received: by 10.216.90.130 with SMTP id e2mr1577003wef.210.1273025463588; Tue, 
	04 May 2010 19:11:03 -0700 (PDT)
Received: by 10.216.25.18 with HTTP; Tue, 4 May 2010 19:11:03 -0700 (PDT)
In-Reply-To: <20100505011045.GA16345@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146364>

Wow, this is really great folks. Let me look at these links again.

Great stuff. Thank you,

-Bob

On Tue, May 4, 2010 at 9:10 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Hi Robert,
>
> Robert Buck wrote:
>
>> We have multiple teams, lots of developers, and would like to use a
>> variant of the dictator-lieutenant scheme discussed in published
>> subject matter.
>>
>> However, I find it rather challenging finding any subject matter tha=
t
>> provides reasonable detail.
>
> Probably you have run into these already. =C2=A0But for reference...
>
> To be a maintainer:
>
> =C2=A0- the gitworkflows(7) page[1]
>
> The kernel does not follow all of these practices, but maybe similar
> projects could benefit from some. :)
>
> To be a =E2=80=9Cleaf=E2=80=9D contributor (does not require git):
>
> =C2=A0- the Linux wireless git guide[2]
> =C2=A0- submitting patches to linux-wireless.git[3]
> =C2=A0- guide to tip.git (Linux=E2=80=99s x86 architecture support su=
bsystem) [4]
>
> To build a throw-away integration branch:
>
> =C2=A0- Stephen Rothwell=E2=80=99s linux-next tree[5]
>
> To be, well, anyone:
>
> =C2=A0- =E2=80=9Ceveryday git in 20 commands or so=E2=80=9D [6]
>
> Patch flow:
>
> =C2=A0- for Linux wireless [7]
> =C2=A0- for git [8]
>
> Separate =E2=80=9Cinternal use=E2=80=9D and =E2=80=9Cpublic=E2=80=9D =
trees:
>
> =C2=A0- nouveau/linux-2.6 [9]
>
>> What I'd like to find are concrete
>> examples, step-by-step, of specifically how to:
>
> If you find these, information for each about
>
> =C2=A0- where you expected to find it
> =C2=A0- where you actually found it
> =C2=A0- how helpful that information was
>
> would be very useful. =C2=A0It would be nice to be able to update =E2=
=80=9Ceveryday git=E2=80=9D,
> the user manual, the reference manual pages, and other documents to m=
ake
> this sort of question easier to answer.
>
> Hope that helps,
> Jonathan
>
> [1] http://www.kernel.org/pub/software/scm/git/docs/gitworkflows.html
> [2] http://wireless.kernel.org/en/developers/Documentation/git-guide
> [3] http://wireless.kernel.org/en/developers/Documentation/Submitting=
Patches
> [4] http://people.redhat.com/mingo/tip.git/readme.txt
> [5] http://git.kernel.org/?p=3Dlinux/kernel/git/next/linux-next.git;a=
=3Dtree;f=3DNext
> [6] http://www.kernel.org/pub/software/scm/git/docs/everyday.html
> [7] http://wireless.kernel.org/en/developers/process
> [8] https://git.wiki.kernel.org/index.php/MaintNotes
> [9] http://lists.freedesktop.org/archives/nouveau/2009-March/002765.h=
tml
> http://cgit.freedesktop.org/nouveau/linux-2.6/
> =E2=80=98git rebase=E2=80=99 is the main tool here.
>
