From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Wed, 8 Jan 2014 03:12:44 +0100
Message-ID: <CALas-ihovRi755a0LKLqn4h4P0Y8tPkJjZew91kKzDTiZb9rGA@mail.gmail.com>
References: <20140106003314.GL3156@odin.tremily.us> <20140106011255.GM3156@odin.tremily.us>
 <20140106160202.GE27265@t2784.greatnet.de> <CALas-ijXQFcUHWk-jJrLifqsMHAKo6NNKya+jR6RJGGDXY76hg@mail.gmail.com>
 <CALas-ijNgaTQr77DZw3acypgaJHpDFVnGdq97ECM4zu+CPma0w@mail.gmail.com>
 <xmqqd2k3ejfr.fsf@gitster.dls.corp.google.com> <CALas-ihPmJSf9eH0P7Vf28pB4zN_dsa_2=fe+_moZgiP0C3UTA@mail.gmail.com>
 <20140107194503.GA26583@odin.tremily.us> <20140107223858.GB10782@sandbox-ub>
 <CALas-ihk6cVfosQ+Ov4QKUcfzvbXrYSonQvsN8Ay1+GTq_Ae-w@mail.gmail.com> <20140108010504.GE26583@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Wed Jan 08 03:13:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0ids-0003Gr-3s
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jan 2014 03:13:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753961AbaAHCNI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jan 2014 21:13:08 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:40161 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753750AbaAHCNG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jan 2014 21:13:06 -0500
Received: by mail-ob0-f171.google.com with SMTP id wp18so1091494obc.2
        for <git@vger.kernel.org>; Tue, 07 Jan 2014 18:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=bwlLhg8+Tngdb9VAG0Fs/LSHbl/PDoL5Aa5Q02TQ3CM=;
        b=GBEQCUGnvGO/4BT09ia7oiz4OPR80Dqx1DeB7hIRAVKoJQLtWKUuPJ7FGteUNfzUuS
         QnXuWushcbSCYH+iEdtZw7ILXEHuSZiXw17/IngMZqbvHcDM5V1jsbpyBtulSD9Mcu/m
         Kz/TRMgxNX4koU6HgQMveX0B/yX8L2hgfPn8/Hd5GF9AJEjcdrALog8QwVqZu4OhAKsq
         ZRbXdWHJKGKp4l6Oq7XA6V2B5dZ0HMci/Y7lkBwc42tExJ9hteCJNYjUAIfBGwLCRhK8
         Hxs6vMUTrrXWSENBrA/EBRA3CdzqzpiDXT02NqtlzParYK2v8OJ2uZo+dU75n8nO0A+1
         kgdA==
X-Received: by 10.182.213.166 with SMTP id nt6mr4118435obc.53.1389147185156;
 Tue, 07 Jan 2014 18:13:05 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Tue, 7 Jan 2014 18:12:44 -0800 (PST)
In-Reply-To: <20140108010504.GE26583@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240191>

2014/1/8 W. Trevor King <wking@tremily.us>:
> Note that I've moved away from =E2=80=9Csubmodule.<name>.branch
> set means attached=E2=80=9D towards =E2=80=9Cwe should set per-superp=
roject-branch
> submodule.<name>.local-branch explicitly=E2=80=9D [1].
>

Honestly, I'm having an hard time to follow this thread. Also, you
didn't update the patch. If you were endorsed by someone (Junio,
Heiko, ...) for the "submodule.<name>.local-branch" feature please
show me where.

I somehow understand the point of the
"submodule.<name>.local-branch" property, but I can't "see" the the
workflow. Please, show me some hypothetical scripting example with as
much complete as possible workflow (creation, developer update,
mantainers creates feature branch, developer update, developer attach
to another branch). Also, consider I proposed to support the attached
HEAD path to reduce complexity and support a simpler use case for
git submodules. I would be disappointed if the complexity is reduced in=
 a
way and augmented in another.

> On Wed, Jan 08, 2014 at 01:17:49AM +0100, Francesco Pretto wrote:
>> # Attach the submodule HEAD to <branch>.
>> # Also set ".git/config" 'submodule.<module>.branch' to <branch>
>> $ git submodule head -b <branch> --attach <module>
> [...]
> I also prefer 'checkout' to 'head', because 'checkout'
> already exists in non-submodule Git for switching between local
> branches.
>

I can agree with similarity to other git commands, but 'checkout' does
not give me the idea of something that writes to ".git/config" or
".gitmodules".

>> # Attach the submodule HEAD to 'submodule.<module>.branch'.
>> # If it does not exists defaults to <remote>/master
>> $ git submodule head --attach <module>
>
> Defaulting to the configured local branch is fine, but I think it
> should default to 'master' if no local branch is configured.  This
> should not have anything to do with remote-tracking branches (that's
> what 'submodule update' already handles).  I don't understand why
> remote-tracking-branch integration keeps getting mixed up with
> local-branch checkout.
>

Yep, it should default to "master", my fault.

>> # Unset  ".git/config" 'submodule.<module>.branch'
>> # Also attach or detach the HEAD according to what is in ".gitmodule=
s":
>> # with Trevor's patch 'submodule.<module>.branch' set means attached=
,
>> # unset means detached
>> $ git submodule head --reset <module>
>
> To me this reads =E2=80=9Calways detach HEAD=E2=80=9D (because it uns=
ets
> submodule.<name>.branch, and submodule.<name>.branch unset means
> detached).

I disagree: this would remove only the value in ".git/config". If the
value is till present in ".gitmodules", as I wrote above, the behavior
of what is in the index should be respected as for the other
properties. Also it gives a nice meaning to a switch like --reset :
return to how it was before.

>> NOTE: feature branch part!
>>
>> # Set ".gitmodules" 'submodule.<module>.branch' to <branch>
>> $ git submodule head -b <branch> --attach --index <module>
>>
>> # Unset ".gitmodules" 'submodule.<module>.branch'
>> $ git submodule head --reset --index <module>
>> --------------------------------------------------------------------=
-
>
> These are just manipulating .gitmodules.  I think we also need
> per-superproject-branch configs under the superproject's .git/ for
> developer overrides.
>

I disagree: in my idea the --index switch is a maintainer only command
to modify the behavior of the developers and touch only indexed files
(.gitmodules, or create a new submodule branch). It expressly don't
touch .git/config.
