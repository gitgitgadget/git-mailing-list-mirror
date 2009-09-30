From: Matthias Andree <matthias.andree@gmx.de>
Subject: Re: Deciding between Git/Mercurial
Date: Wed, 30 Sep 2009 13:14:12 +0200
Message-ID: <4AC33D84.406@gmx.de>
References: <h9nlhj$heq$1@ger.gmane.org> <94a0d4530909280136s1ff65004q1733bd4ef78bdc07@mail.gmail.com> <alpine.DEB.1.00.0909281059180.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 30 13:14:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Msx8X-0002u9-Aj
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 13:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbZI3LOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 07:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753693AbZI3LOL
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 07:14:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:44800 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753073AbZI3LOK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 07:14:10 -0400
Received: (qmail invoked by alias); 30 Sep 2009 11:14:12 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp002) with SMTP; 30 Sep 2009 13:14:12 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1+v5XkfM5av7VG1HFq3Ck0ry00JwwYHH/EbkyIlK/
	s5i7NzOLilVX2i
Received: from localhost ([127.0.0.1])
	by balu.cs.uni-paderborn.de with esmtp (Exim 4.69)
	(envelope-from <matthias.andree@gmx.de>)
	id KQS77O-0003SG-9S
	for git@vger.kernel.org; Wed, 30 Sep 2009 13:14:12 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
In-Reply-To: <alpine.DEB.1.00.0909281059180.4985@pacific.mpi-cbg.de>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129339>

Johannes Schindelin schrieb:
> Hi,
> 
> I tried to refrain from commenting in this thread, because I do not want 
> to encourage people just to use msysGit and never even attempt to fix 
> their own issues.
> 
> But I cannot let this go uncommented:
> 
> On Mon, 28 Sep 2009, Felipe Contreras wrote:
> 
>> IMO the key difference between hg and git is the storage model: hg 
>> stores deltas, while git stores snapshots. That would mean that certain 
>> operations are theoretically faster in git (e.g. checkout, diff) while 
>> others faster in hg, although with git's packed format I guess there's 
>> no operation faster in hg. This means that it doesn't matter how much 
>> hg's python code improves, or if they even re-write parts in C, they 
>> will never be able to match git's performance (unless they change the 
>> storage model, which essentially means changing the whole design -- 
>> won't happen).
> 
> That is wrong.  "git log -- <file>" will always be slightly faster in 
> Mercurial, for all the reasons you mentioned.
> 
> In addition, Mercurial _has_ parts re-written in C for performance, which 
> renders it not-exactly more portable if you ask me.  Last time I checked, 
> there was no way to compile a Python module with MinGW (or for that 
> matter, Python itself), but you needed MSVC...

I have a shortish mercurial build script that works under Cygwin 1.5 and uses
msys, py2exe and iscc to build an installable Mercurial package, but I'm not
sure what this boils down to WRT C-versions of "modules". Maybe these are lumped
into the resulting hg.exe, I never bothered to check the details.
