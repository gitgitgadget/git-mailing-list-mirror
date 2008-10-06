From: Russell Cattelan <cattelan@thebarn.com>
Subject: Re: [xfs-masters] git://oss.sgi.com broke
Date: Mon, 06 Oct 2008 12:30:10 -0500
Message-ID: <48EA4B22.2050900@thebarn.com>
References: <20081003121903.6c9a7ebc.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
To: xfs-masters@oss.sgi.com
X-From: git-owner@vger.kernel.org Mon Oct 06 19:37:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmtw9-0000z1-Vq
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 19:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbYJFRaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 13:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbYJFRav
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 13:30:51 -0400
Received: from cattelan-host202.dsl.visi.com ([208.42.117.202]:54565 "EHLO
	slurp.thebarn.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751366AbYJFRav (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 13:30:51 -0400
Received: from funky.thebarn.com (slurp.thebarn.com [208.42.117.201])
	(authenticated bits=0)
	by slurp.thebarn.com (8.14.0/8.13.8) with ESMTP id m96HUAbL016703;
	Mon, 6 Oct 2008 12:30:10 -0500 (CDT)
	(envelope-from cattelan@thebarn.com)
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <20081003121903.6c9a7ebc.akpm@linux-foundation.org>
X-Virus-Scanned: ClamAV 0.91.2/8378/Mon Oct  6 07:51:03 2008 on slurp.thebarn.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97608>

Andrew Morton wrote:
> y:/usr/src/git26> git --version
> git version 1.5.6.rc0
>
> y:/usr/src/git26> cat .git/branches/git-xfs
> git://oss.sgi.com:8090/xfs/xfs-2.6.git#master
>
> y:/usr/src/git26> git-fetch git-xfs        
> remote: usage: git-pack-objects [{ -q | --progress | --all-progress }] 
> remote:         [--max-pack-size=N] [--local] [--incremental] 
> remote:         [--window=N] [-remote: -window-memory=N] [--depth=N] 
> remote:         [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] 
> remote:         [--threads=N] [--non-empty] [--reremote: vs [--unpacked | --all]*] [--reflog] 
> remote:         [--stdout | base-name] [--keep-unreachable] [<ref-list | <object-list]
> remote: aborting due to possible repository corruption on the remote side.
> fatal: protocol error: bad pack header
>
> It was OK yesterday.
>
> (cc'ing the git list in case this is an faq?)
>
> The last two error messages there look wrong/misleading?
>
>   
Ok not sure exactly what was wrong but it looks like there was some 
confusion
with older git bits still install on oss.

I manually cleaned everything from the system and reinstalled git from a 
fresh "make rpm" rpm.

Please try your pull again and see if the problem is resolved.

-Russell
