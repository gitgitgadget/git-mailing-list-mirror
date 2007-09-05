From: Nix <nix@esperi.org.uk>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 19:28:13 +0100
Message-ID: <873axt0xxe.fsf@hades.wkstn.nix>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
	<69b0c0350709050947k5e32ba7fj38924a0968569d9a@mail.gmail.com>
	<46DEE8E8.2000801@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Govind Salinas <govindsalinas@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 20:28:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISzc9-0006N0-9k
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 20:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753672AbXIES22 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 14:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753802AbXIES22
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 14:28:28 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:46854 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753672AbXIES21 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 14:28:27 -0400
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id l85ISDPZ009238;
	Wed, 5 Sep 2007 19:28:13 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id l85ISD4w025564;
	Wed, 5 Sep 2007 19:28:13 +0100
Emacs: more boundary conditions than the Middle East.
In-Reply-To: <46DEE8E8.2000801@midwinter.com> (Steven Grimm's message of "Wed, 05 Sep 2007 10:35:36 -0700")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.5-b28 (linux)
X-DCC-INFN-TO-Metrics: hades 1233; Body=4 Fuz1=4 Fuz2=4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57735>

On 5 Sep 2007, Steven Grimm stated:

> Govind Salinas wrote:
>> This is one reason why I really think that gc should be *plumbing*
>> and *not* porcelain.
>
> That's a good way to think of it IMO. It's a low-level operation
> (albeit one that encapsulates other, lower-level ones) that tells git
> to rearrange its internal data structures. It is not something that
> has any user-visible effect.

It certainly has a sysadmin-visible effect. Repack a couple of big git
repositories and that's a backup tape gone if you do incremental
backups: and you can't *not* back up the pack files, even though a lot
of the state in them is recoverable from elsewhere on the net: the stuff
which is not recoverable is tangled up with the stuff which is.

(of course the solution here was .keep files. I cheered when they were
introduced and started rolling git out everywhere I could. There's just
one last vast repository maintained by a horrible shell script layered
atop SCCS which I have to find some way to convert...)
