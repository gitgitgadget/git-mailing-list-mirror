From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: question about: Facebook makes Mercurial faster than Git
Date: Mon, 10 Mar 2014 15:48:20 +0100
Message-ID: <531DD0B4.3020603@alum.mit.edu>
References: <531D8ED9.7040305@gmx.net> <CANgJU+W+f3KUxehDGxd+f77RO24VadsnOV=szE2MkBXjs8wDCQ@mail.gmail.com> <531DA519.8090509@gmx.net> <CALKQrgcfTKy0d_BGAZ-bSx5i-=MVEF-WuRfW6T3Q-YxvVSqY_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Dennis Luehring <dl.soluz@gmx.net>, Git <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Mar 10 15:48:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WN1VF-0006BT-A0
	for gcvg-git-2@plane.gmane.org; Mon, 10 Mar 2014 15:48:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753693AbaCJOsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 10:48:25 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:48480 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753456AbaCJOsY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 10:48:24 -0400
X-AuditID: 1207440e-f79c76d000003e2c-59-531dd0b739e8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id A8.37.15916.7B0DD135; Mon, 10 Mar 2014 10:48:23 -0400 (EDT)
Received: from [192.168.69.148] (p57A2497B.dip0.t-ipconnect.de [87.162.73.123])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2AEmKEh031376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 10 Mar 2014 10:48:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <CALKQrgcfTKy0d_BGAZ-bSx5i-=MVEF-WuRfW6T3Q-YxvVSqY_A@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqLv9gmywwfsNAhbzr69ls+i60s1k
	Me/uLiYHZo/Fm/azeVx6+Z3N4/MmuQDmKG6bpMSSsuDM9Dx9uwTujPMPZ7AUXBWtePvPv4Gx
	R7CLkZNDQsBEYvbaeywQtpjEhXvr2boYuTiEBC4zSixpWMQO4ZxnkthxZxljFyMHB6+AtkTH
	lEyQBhYBVYmzU54zgdhsAroSi3qawWxRgWCJ1ZcfgA3lFRCUODnzCZgtAlS/4/EvNpAxzAKO
	Et86DEDCwgKuEr/+NrNArDrNKPHlynxmkASnQKDEiRmzWEDqJQTEJXoagyBa1SXWzxMCqWAW
	kJfY/nYO8wRGwVlIls1CqJqFpGoBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1jvdzMEr3U
	lNJNjJBg5tvB2L5e5hCjAAejEg/vgbcywUKsiWXFlbmHGCU5mJREeSvOyQYL8SXlp1RmJBZn
	xBeV5qQWH2KU4GBWEuF9AZLjTUmsrEotyodJSXOwKInzqi1R9xMSSE8sSc1OTS1ILYLJynBw
	KEnwfj0P1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPitz4YmDsgqR4gPY+Bmnn
	LS5IzAWKQrSeYtTluN326xOjEEtefl6qlDjvKpAiAZCijNI8uBWw1PWKURzoY2HeFyBVPMC0
	BzfpFdASJqAlzcelQJaUJCKkpBoYDVucX+w4H5bKpV6hl7OIv9gzZtqZLJtbOxafm/1PdfHa
	NfdUNzIx/lmYUd3HHB9aOO1Ap45mju9kx5i7+6Z0L5T5HvZtJ+uW4+wHsiSim9/l 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243763>

On 03/10/2014 01:10 PM, Johan Herland wrote:
> It should be possible to teach Git to do similar things, and IINM
> there are (and have previously been) several attempts to do similar
> things in Git, e.g.:
> 
>  - http://thread.gmane.org/gmane.comp.version-control.git/240339
> 
>  - http://thread.gmane.org/gmane.comp.version-control.git/217817
> 
> I haven't looked closely at these attempts (it is not my scratch to
> itch), and I don't know if/how they would work on top of Watchman, but
> in principle I don't see why Git shouldn't be able to leverage
> Watchman the same way Mercurial does.

This touches on the most important thing that we should take to heart
from this episode:

Of course Facebook could have modified either Git or Mercurial to do
what they want.  Why did they pick Mercurial?  The article seems to
claim that they were initially biased towards Git, but they chose
Mercurial because its code base is easier to modify.  This is a claim
that I can easily believe.

The two projects are almost exactly the same age.  The number of commits
in the two projects is similar.  Mercurial has had fewer contributors
active at any given time over its project lifetime.

But let's see how much code is in the main part of Mercurial vs. Git:

    $ find mercurial hgext \( -name '*.c' -o -name '*.py' \) -print |
          xargs cat | wc -l
    46164

    $ cat *.c *.h *.sh *.perl builtin/*.c | wc -l
    188530

These are just crude estimates and I hope I got the right directories
for Mercurial.  But, by these numbers, Git has 4 times as much code as
Mercurial.  That alone will go a long way to making Git harder to
modify.  I don't think that Git has anywhere near 4 times the features
of Mercurial.  Probably most of the difference can be explained by the
choice of implementation languages; 94% of the code in these hg
directories is Python, whereas 88% of Git's core code is C.

How can we make Git easier to hack (short of switching languages)?  Here
are my suggestions:

* Better function docstrings -- don't make developers have to read the
whole call stack to find out what a function does, or who owns the
memory that is passed around.

* More modularity -- more coherent and abstract APIs between different
parts of the system, and less pawing around in your neighbor's data
structures.

* Higher-level abstractions -- make more use of APIs like strbuf and
string_list as opposed to handling every malloc() and realloc() by hand.

I personally wish that we as a project would be more willing to spend a
few extra CPU microseconds to make our code easier to read and modify
and more robust.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
