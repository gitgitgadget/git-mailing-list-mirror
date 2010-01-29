From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: master^ is not a local branch -- =?UTF-8?Q?huh=3F!=3F?=
Date: Fri, 29 Jan 2010 23:28:48 +0000
Message-ID: <bd7fb2a884e55e176eea3002fd0c68dd@212.159.54.234>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <op.u7a909hf4oyyg1@alvarezp-ws> <ron1-1F1799.13340029012010@news.gmane.org> <op.u7bfjni44oyyg1@alvarezp-ws> <ron1-0EE62E.14474929012010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 00:36:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb0Nj-0001Ix-7U
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 00:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255Ab0A2XgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 18:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026Ab0A2XgA
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 18:36:00 -0500
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:41379 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751658Ab0A2Xf7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2010 18:35:59 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jan 2010 18:35:59 EST
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 367BF819C643;
	Fri, 29 Jan 2010 23:28:51 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id F031621D84E;
	Fri, 29 Jan 2010 23:28:50 +0000 (GMT)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qJ7vsFL9ztT0; Fri, 29 Jan 2010 23:28:48 +0000 (GMT)
Received: from webmail.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 8402F21D831;
	Fri, 29 Jan 2010 23:28:48 +0000 (GMT)
In-Reply-To: <ron1-0EE62E.14474929012010@news.gmane.org>
X-Sender: julian@quantumfyre.co.uk
User-Agent: RoundCube Webmail/0.1-rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138401>

On Fri, 29 Jan 2010 14:47:49 -0800, Ron Garret <ron1@flownet.com> wrote:
> My actual use case is very complicated, but here's a simplified version:
> 
> Suppose I'm using git as a back-end for a wiki.  I want to look at the 
> state of the entire wiki as it was in some point in the past, and I also

> want to be able to look at the diffs between individual pages as they 
> were then and as they are now.  The most straightforward way I can think

> of to do that is to simply copy an old commit into my working tree 
> without changing anything else.  Then I can look at the old version by 
> simply looking at the files, and I can get the diffs by simply doing a 
> git diff.
> 
> If I do a git reset --hard then I get the old version, but I lose my 
> HEAD pointer so that git diff doesn't give me what I want any more.
> 
> BTW, it turns out that git checkout [commit] . doesn't do the right 
> thing either.  Apparently, it still updates my index, so git diff still 
> doesn't do the right thing.

If I understand what you want correctly, then:

git diff --cached -R [path]

should be the appropriate command after the "git checkout <commit> .".

-- 
Julian
