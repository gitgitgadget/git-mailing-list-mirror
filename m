From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: [PATCH v2 1/2] Ensure consistent usage of mergetool.keepBackup
 in git
Date: Fri, 10 Apr 2009 10:25:36 +0200
Message-ID: <49DF0280.2060000@pelagic.nl>
References: <20090409153033.GN23604@spearce.org> <f6297e57a23dc3abac2fcedceb00cecde607de02.1239291673.git.ferry.huberts@pelagic.nl> <20090410032731.GA1545@gmail.com> <49DEEE22.5030500@pelagic.nl> <20090410074327.GA9369@gmail.com> <20090410081843.GB9369@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Charles Bailey <charles@hashpling.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 10 10:27:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsC4y-0005Go-6m
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 10:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761214AbZDJIZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 04:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759092AbZDJIZl
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 04:25:41 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:55240 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758655AbZDJIZk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Apr 2009 04:25:40 -0400
Received: from [192.168.0.101] (unknown [192.168.0.101])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id 191CC58BD88;
	Fri, 10 Apr 2009 10:25:37 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090410081843.GB9369@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116247>

David Aguilar wrote:
> On  0, David Aguilar <davvid@gmail.com> wrote:
>> It /seems/ like the docs and completion should be updated.
> 
> Though my guess is as good as any....
> I'd rather hear someone else's opinion.
> 
> $ git log -p 44c36d1c
> commit 44c36d1ccc9a40bfb31910dfd7e18d59fa8be502
> Author: Charles Bailey <charles@hashpling.org>
> Date:   Thu Feb 21 23:30:02 2008 +0000
> 
>     Tidy up git mergetool's backup file behaviour
>     
>     Currently a backup pre-merge file with conflict markers is sometimes
>     kept with a .orig extenstion and sometimes removed depending on the
>     particular merge tool used.
>     
>     This patch makes the handling consistent across all merge tools and
>     configurable via a new mergetool.keepBackup config variable
>     
>     Signed-off-by: Charles Bailey <charles@hashpling.org>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> 
> The commit comment says mergetool.keepBackup, even though the code always
> had it as merge.keepBackup.
> 
> $ git log -p 7e30682c
> 
> Right now more people have merge.keepbackup already set since git-gui
> has had it that way for the last 7 months or so.  Nevertheless,
> Shawn's already applied the git-gui patch which hints that maybe
> we should just make the code match the docs.  In which case, a
> patch against pu would be a good thing, but I would like to
> hear someone else's opinion just so that you don't waste time
> going down the wrong route.
> 
agree
