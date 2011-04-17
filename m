From: "Marcus D. Hanwell" <marcus.hanwell@kitware.com>
Subject: Re: Generating GNU-style Changelog from git commits
Date: Sat, 16 Apr 2011 21:47:58 -0400
Message-ID: <BANLkTikQvOkoFSXXC3oUKQfASo8==qdgxA@mail.gmail.com>
References: <BANLkTi=j_Ge9h8+r8R-a5Fppan_2dtu5LA@mail.gmail.com> <4DAA3A0D.6070904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Chanters <david.chanters@googlemail.com>, git@vger.kernel.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 03:48:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBH6P-0000IV-AY
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 03:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398Ab1DQBsh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Apr 2011 21:48:37 -0400
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:44468 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751364Ab1DQBsg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2011 21:48:36 -0400
Received: from mail-iy0-f179.google.com ([209.85.210.179]) (using TLSv1) by na3sys009aob113.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTapG48/PCwZUzNK2O0FLP+Shw6Q6ormH@postini.com; Sat, 16 Apr 2011 18:48:36 PDT
Received: by iym7 with SMTP id 7so4062660iym.24
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 18:48:19 -0700 (PDT)
Received: by 10.42.246.72 with SMTP id lx8mr4506902icb.276.1303004898146; Sat,
 16 Apr 2011 18:48:18 -0700 (PDT)
Received: by 10.231.38.218 with HTTP; Sat, 16 Apr 2011 18:47:58 -0700 (PDT)
In-Reply-To: <4DAA3A0D.6070904@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171708>

On Sat, Apr 16, 2011 at 8:53 PM, Chris Packham <judge.packham@gmail.com=
> wrote:
> On 17/04/11 10:46, David Chanters wrote:
>>
>> [Please Cc me on replies. =A0Thanks!]
>>
>> Hi,
>>
>> Some projects maintain a ChangeLog file, which looks something like =
this:
>>
>> 2011-01-01 =A0David Chanters<d.c@example.com>
>> =A0 =A0 =A0 =A0 * foo/bar.c (some_function):
>> =A0 =A0 =A0 =A0 =A0Changed static variable in some_function to auto.
>>
>> etc., etc.
>>
>> Here "foo" is some directory relative to the top-level directory the
>> .git one is in.
>>
>> These ChangeLog files are maintained manually, irrespective of the/a=
ny
>> revision control system in use. =A0I am wondering if it's possible i=
f
>> the project is in Git to be able to automatically append to such a
>> ChangeLog file with each commit automatically, and have it formatted
>> in the style above.
>>
>> Is this possible? =A0Is it a solved problem? =A0If not, and I wanted=
 to
>> try myself, could someone point me at the git-specific tools I'd nee=
d
>> to know to use to achieve it?
>
> Shouldn't be to hard, there are numerous hooks that could be used eit=
her on
> the developer end (post-commit), on the server end (post-update) or e=
ven
> when a maintainer applies a patch (post-applypatch). See githooks(5) =
for
> more info on what hooks are available and what args are passed.
>
> There is also the possibility of generating this changelog at the tim=
e of
> release. I'd advocate this approach as it would allow you to edit the
> changelog to make it more useful to readers.

Something I wrote a few years ago does this for us. It may not be
perfect, but there was a desire to have a Changelog in our released
tarballs,

https://github.com/cryos/avogadro/blob/master/scripts/gitlog2changelog.=
py

If there are better ways of doing this I would certainly be
interested, but have not spent much time on this since writing the
initial script. We had a similar desire, but didn't want to end up
resolving conflicts around a file in version control.

Marcus
