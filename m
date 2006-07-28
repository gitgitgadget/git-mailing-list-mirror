From: Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
Subject: Re: Java GIT/Eclipse GIT version 0.1.1
Date: Fri, 28 Jul 2006 09:23:42 +0200
Message-ID: <slrnecjeru.bou.Peter.B.Baumann@xp.machine.xx>
References: <20060728063620.GD30783@spearce.org> <slrnecjcsn.8td.Peter.B.Baumann@xp.machine.xx> <20060728030859.n8ks44ck8884ss44@webmail.spamcop.net>
X-From: git-owner@vger.kernel.org Fri Jul 28 09:24:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6Mhf-0007r9-Nm
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 09:24:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWG1HX5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 03:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWG1HX5
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 03:23:57 -0400
Received: from main.gmane.org ([80.91.229.2]:11472 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750760AbWG1HX5 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Jul 2006 03:23:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G6MhP-0007pK-Sw
	for git@vger.kernel.org; Fri, 28 Jul 2006 09:23:55 +0200
Received: from mason.hofmann.stw.uni-erlangen.de ([131.188.24.36])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Jul 2006 09:23:55 +0200
Received: from Peter.B.Baumann by mason.hofmann.stw.uni-erlangen.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Jul 2006 09:23:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mason.hofmann.stw.uni-erlangen.de
User-Agent: slrn/0.9.8.0 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24372>

On 2006-07-28, Pavel Roskin <proski@gnu.org> wrote:
> Quoting Peter Baumann <Peter.B.Baumann@stud.informatik.uni-erlangen.de>:
>
>> On 2006-07-28, Shawn Pearce <spearce@spearce.org> wrote:
>> > My Java GIT library and Eclipse GIT team provider is now at a point
>> > where it may be partially useful to someone else who is also trying
>> > to write something which interacts with GIT.  Or who might also
>> > be interested in seeing a pure-Java Eclipse team provider for GIT.
>> >
>> > So I've posted my repository (currently ~200 KB) on my website:
>> >
>> >   http://www.spearce.org/projects/scm/egit.git
>> >
>>
>> Doesn't work for me.
>
> Neither does it for me:
>
> $ git clone http://www.spearce.org/projects/scm/egit.git
> error: File ac32c7cc2f7cf87a1ed80d0cdfca2af2a0385bb2
> (http://www.spearce.org/projects/scm/egit.git/objects/ac/32c7cc2f7cf87a1ed80d0cdfca2af2a0385bb2)
> corrupt
> Getting pack list for http://www.spearce.org/projects/scm/egit.git/
> error: XML error: not well-formed (invalid token)
>
>> *** glibc detected *** double free or corruption (!prev): 0x080933b0 ***
>> /usr/bin/git-clone: line 29: 10712 Aborted                 git-http-fetch -v
>> -a -w "$tname" "$name" "$1/"
>
> I'm not getting that.  I hope you are just using an obsolete version of git.

Not _that_ old, me thinks. I'm using the debian unstable version.

devil:~ dpkg -l |grep git-core
ii  git-core       1.4.1-1        content addressable filesystem

(Yes, I'am aware that this version has the timing bug on the server
side, but I was just too lazy to compile git myself this time :-)

-Peter
