From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: [PATCH 2/2] Document "git log --simplify-by-decoration"
Date: Tue, 11 Nov 2008 12:03:48 +0100
Message-ID: <adf1fd3d0811110303x4a8be5f7vd91979858dcfba59@mail.gmail.com>
References: <20081111184700.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Nanako Shiraishi" <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 12:06:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzr3S-0000tS-AS
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 12:05:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755345AbYKKLDv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Nov 2008 06:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755099AbYKKLDv
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 06:03:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:45569 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625AbYKKLDu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Nov 2008 06:03:50 -0500
Received: by ug-out-1314.google.com with SMTP id 39so694153ugf.37
        for <git@vger.kernel.org>; Tue, 11 Nov 2008 03:03:48 -0800 (PST)
Received: by 10.103.161.16 with SMTP id n16mr4427876muo.79.1226401428302;
        Tue, 11 Nov 2008 03:03:48 -0800 (PST)
Received: by 10.103.165.1 with HTTP; Tue, 11 Nov 2008 03:03:48 -0800 (PST)
In-Reply-To: <20081111184700.6117@nanako3.lavabit.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100639>

On Tue, Nov 11, 2008 at 10:47 AM, Nanako Shiraishi <nanako3@lavabit.com=
> wrote:
> Quoting "Santi B=E9jar" <santi@agolina.net>:
>
>>> +The '\--simplify-by-decoration' option can be used to treat commit=
s that
>>> +are not referenced by tags as TREESAME, and treat commits that are=
 tagged
>>> +as !TREESAME (even when they have exactly the same tree as their p=
arents).
>>> +This can be used when you are only interested in the big picture o=
f the
>>> +topology of the history.
>>> +
>>> +
>>
>> I prefer the other way around, first what it does, and then how it
>> does it (but it is a general comment about the help in "History
>> Simplification", at least when viewing the help for "git log").
>
> Thank you for your comments.
>
> In the earlier part of the description, TREESAME (or !TREESAME) is ex=
plained as a prerequisite concept for understanding how the history sim=
plification works.  I think my description first talks about what it do=
es using the concept that was already explained (in other words, "which=
 commits are marked as TREESAME"), and then talks about what the conseq=
uence of what it does is (in other words, "only shows the big picture")=
=2E
>
> I can swap them around.  Let's see if you like this better:
>
>        The '\--simplify-by-decoration' option allows you to view only=
 the
>        big picture of the topology of the history, by omitting commit=
s
>        that are not referenced by tags.  Commits are marked as !TREES=
AME
>        (in other words, kept after history simplification rules descr=
ibed
>        above) if (1) they are referenced by tags, or (2) they change =
the
>        contents of the paths given on the command line.  All other
>        commits are marked as TREESAME (subject to be simplified away)=
=2E
>

Better. I think it also makes sense to present the options at the
beginning of the section, explain what they do, and then explain them
in detail. I'll try to do it.

>> And you should rewrite the line 416:
>>
>> Finally, there is a fourth simplification mode available
>>
>> as it is no longer "Finally".
>
> Yes, I thought about it, but describing the new option at the end doe=
s not change the fact that the fourth simplification mode is the final =
one.

I take "Finally" as the last thing is explained in the section.

>
> The new option is not about a "simplification mode".  Given a set of =
commits marked as TREESAME and !TREESAME, simplification modes decide h=
ow the history is simplified.  The new option does not add any new mode=
=2E Instead, it affects which commits are marked as TREESAME/!TREESAME.

Make sense.

Santi
