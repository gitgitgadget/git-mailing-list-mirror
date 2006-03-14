From: Paul Jakma <paul@clubi.ie>
Subject: Re: seperate commits for objects already updated in index?
Date: Tue, 14 Mar 2006 17:27:19 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0603141723240.5276@sheen.jakma.org>
References: <Pine.LNX.4.64.0603141634010.5276@sheen.jakma.org>
 <Pine.LNX.4.64.0603140856120.3618@g5.osdl.org> <Pine.LNX.4.64.0603141703080.5276@sheen.jakma.org>
 <Pine.LNX.4.64.0603140915290.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 14 18:39:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJDJM-0006wN-1Y
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 18:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbWCNR1x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Mar 2006 12:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWCNR1x
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Mar 2006 12:27:53 -0500
Received: from hibernia.jakma.org ([212.17.55.49]:41600 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S1751402AbWCNR1w
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Mar 2006 12:27:52 -0500
Received: from sheen.jakma.org (IDENT:U2FsdGVkX19uTbXUBGX6VAkVt26FTSgukF/+2naanqw@sheen.jakma.org [212.17.55.53])
	by hibernia.jakma.org (8.13.1/8.13.1) with ESMTP id k2EHRJS9023639;
	Tue, 14 Mar 2006 17:27:31 GMT
X-X-Sender: paul@sheen.jakma.org
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603140915290.3618@g5.osdl.org>
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: al aqsar fluffy jihad cute musharef kittens jet-A1 ear avgas wax ammonium bad qran dog inshallah allah al-akbar martyr iraq hammas hisballah rabin ayatollah korea revolt pelvix mustard gas x-ray british airways washington peroxide cool
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on hibernia.jakma.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17594>

On Tue, 14 Mar 2006, Linus Torvalds wrote:

> Well, I actually think git is being somewhat of an ass, for no 
> really good reason. It's true that you are doing something pretty 
> strange by _both_ using "git-update-index" and "git commit -o" but 
> the fact is, at least when adding files, that would be expected (ie 
> you have to mark a file in the index to add it).

Well, I tend to work on one thing, then notice something else 
unrelated (or in a support file), fix/tweak that, etc.. I use the 
index for 'way-point' diffs, rather than commit things I havn't quite 
tested yet (or dont know whether they'll be useful yet).

> I also think that test is historical, from before Junio cleaned up 
> how "git commit" worked - it _used_ to be that "git commit" would 
> work in the current index, but these days it generates a new index 
> to commit when you do "-o", so there's really no _technical_ reason 
> to refuse the partial commit any more as far as I can see.

Aha. So that check possibly could just be removed?

> So I don't know. I don't think you were being dumb, I think git 
> could have been friendlier to you.

:)

git reset works just fine too.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
A day for firm decisions!!!!!  Or is it?
