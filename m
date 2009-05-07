From: Miles Bader <miles@gnu.org>
Subject: Re: git repack with a --reference
Date: Thu, 07 May 2009 14:57:17 +0900
Message-ID: <87bpq5bgle.fsf@catnip.gol.com>
References: <4A0261D8.8040105@catalyst.net.nz>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Harker <jonathan@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu May 07 07:57:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1wbv-0000Hs-3D
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 07:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbZEGF51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 01:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbZEGF51
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 01:57:27 -0400
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:59178 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581AbZEGF50 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 01:57:26 -0400
Received: from 218.231.212.123.eo.eaccess.ne.jp ([218.231.212.123] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	id 1M1wbe-0005DN-Dm; Thu, 07 May 2009 14:57:18 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 92F46DFA9; Thu,  7 May 2009 14:57:17 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <4A0261D8.8040105@catalyst.net.nz> (Jonathan Harker's message of
	"Thu, 07 May 2009 16:21:44 +1200")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118427>

Jonathan Harker <jonathan@catalyst.net.nz> writes:
> Hi - hope this isn't too noobish but I'm trying to get an existing git
> checkout to repack/prune/gc itself such that it would be like I had
> cloned it with --reference /path/to/local/repo (i.e. I've added
> /path/to/local/repo to .git/objects/info/alternatives, and I'd like it
> to reduce its objects from 200 MB to 5 MB). Is this
>
> a. possible,
> b. desirable, and
> c. not insane?

I've done this in the past (using "git gc", but same difference I
guess), and it worked as you'd hope, reducing .git to something very
small.

I don't recall any real problems, but you might need to manually
remove any pack ".keep" files first though (I seem to recall something
like that, anyway).

-Miles

-- 
Friendship, n. A ship big enough to carry two in fair weather, but only one
in foul.
