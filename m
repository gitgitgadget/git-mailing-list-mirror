From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: git add -i failed in 2.0.3
Date: Tue, 29 Jul 2014 10:06:58 +0200
Message-ID: <53D75622.8070105@web.de>
References: <DB19F40E-912E-42F0-AB63-838BADAF77FB@gmail.com> <53D74131.40005@web.de> <9A4F68F4-6162-462C-92E4-BD80D1BC1A75@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Guang Chen <cgcgbcbc@gmail.com>,
	=?windows-1252?Q?Torsten_B=F6gersh?= =?windows-1252?Q?ausen?= 
	<tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 10:07:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC2RW-0002dO-Iu
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 10:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbaG2IHY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Jul 2014 04:07:24 -0400
Received: from mout.web.de ([212.227.17.12]:56962 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044AbaG2IHW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 04:07:22 -0400
Received: from [192.168.1.87] ([77.119.129.132]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Ma2YF-1WueJE4B15-00LiyW; Tue, 29 Jul 2014 10:07:20
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Icedove/24.6.0
In-Reply-To: <9A4F68F4-6162-462C-92E4-BD80D1BC1A75@gmail.com>
X-Provags-ID: V03:K0:jRabkVnerJSuVuBcAx56Otvf2dOFQziVZLf5lVxuXd7whUdQNql
 cl1+z4yZwlppFm/Yct3iSuI3xGC87tmEn4ZXElHDd2rr2SZ1R2LXhgi+fLdykdnTBbB146K
 FEoNOGrVEQ2jbJS5iwMoLhIcxLh7Q40gQ262nD3DRQGlV+Tobpgb4sVGCUA/EmGdYGwJ8ey
 5dERE1HsFDPrK8cDPXBXw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254404>

[please avoid top-posting]
On 07/29/2014 08:55 AM, Guang Chen wrote:
> I used 1.9.2 before, it was installed with brew as well.
> I didn=92t found Git.pm under /usr/local/Cellar/git/, /usr/local/Cell=
ar/git/2.0.3/, and I looked at /usr/local/Cellar/git/1.9.2/, there isn=92=
t a Git.pm either.
>
> type perl says:
> perl is /usr/bin/perl
>
> Additionally, perl --version says:
>
> This is perl 5, version 16, subversion 2 (v5.16.2) built for darwin-t=
hread-multi-2level
> (with 3 registered patches, see perl -V for more detail)
>
> On Jul 29, 2014, at 14:37, Torsten B=F6gershausen <tboegi@web.de> wro=
te:
>
>> On 07/27/2014 05:26 PM, Guang Chen wrote:
>>> I use brew upgrade git to this version on OSX. And when I use git a=
dd -i, it says:
>> Which version did you use before?
>> Was it installed with brew as well ?
>>> Can't locate Git.pm in @INC (@INC contains: @@@/git/2.0.3/lib/perl5=
/site_perl /Applications/Xcode.app/Contents/Developer/Library/Perl/5.16=
/darwin-thread-multi-2level /Library/Developer/CommandLineTools/Library=
/Perl/5.16/darwin-thread-multi-2level /Users/guangchen/.opam/system/lib=
/perl5/darwin-thread-multi-2level /Users/guangchen/.opam/system/lib/per=
l5 /Library/Perl/5.16/darwin-thread-multi-2level /Library/Perl/5.16 /Ne=
twork/Library/Perl/5.16/darwin-thread-multi-2level /Network/Library/Per=
l/5.16 /Library/Perl/Updates/5.16.2 /System/Library/Perl/5.16/darwin-th=
read-multi-2level /System/Library/Perl/5.16 /System/Library/Perl/Extras=
/5.16/darwin-thread-multi-2level /System/Library/Perl/Extras/5.16 .) at=
 /usr/local/Cellar/git/2.0.3/libexec/git-core/git-add--interactive line=
 7.
>>> BEGIN failed--compilation aborted at /usr/local/Cellar/git/2.0.3/li=
bexec/git-core/git-add--interactive line 7.
>> Do you have Git.pm on your disc, somewhere under /usr/local/Cellar/g=
it ?
>>
>> Which perl do you have, (may be more than 1?)
>> I tend to have different perl installations under Mac OS, whch needs
>> tweeking in the PATH, to have the "right one" in the PATH before e.g=
=2E the
>> one that comes with Mac OS.
>> (Or write a wrapper script that sets up the PATH and then calls git)
>>
>> What does "type perl" in a command window say?
>>

So git add -i needs perl (which is there) and Git.pm (which isn't there=
)
There doesn't seem to be a Git.pm at all on your disc ?
I haven't used brew myself, I use to clone git from
git://git.kernel.org/pub/scm/git/git.git,
checkout the version I want,
and run "make install" which installs git under $HOME/bin,
and Git.pm under /Users/tb/share/perl/5.14.2/Git.pm
You can try that, clone into a directory, run "make -k", and see if=20
there is a Git.pm ?
