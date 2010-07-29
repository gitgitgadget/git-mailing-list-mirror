From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What is the scenario for a commit with 3 or more parents
Date: Wed, 28 Jul 2010 19:19:46 -0700
Message-ID: <20100729021946.GG25268@spearce.org>
References: <AANLkTikMRa_LrD2fU9Piv3GW2H0r7Jf_9s5iM0wc9t6s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 04:20:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeIj2-0005y0-Fm
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 04:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451Ab0G2CTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jul 2010 22:19:55 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54025 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab0G2CTy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jul 2010 22:19:54 -0400
Received: by pzk26 with SMTP id 26so30982pzk.19
        for <git@vger.kernel.org>; Wed, 28 Jul 2010 19:19:53 -0700 (PDT)
Received: by 10.114.73.5 with SMTP id v5mr16207246waa.68.1280369993240;
        Wed, 28 Jul 2010 19:19:53 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id g4sm493943wae.2.2010.07.28.19.19.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Jul 2010 19:19:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikMRa_LrD2fU9Piv3GW2H0r7Jf_9s5iM0wc9t6s@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152149>

Bradley Wagner <bradley.wagner@hannonhill.com> wrote:
> I was reading over the Specifying Revisions section in the man entry
> gitrevisions. I understand having 2 parent commits with a merge.
> 
> I was trying to understand the HEAD^2 style syntax and wondering where
> HEAD^3 would be used. From the example diagram, this would be Commit B
> but I'm unclear how this would ever happen. Is this some kind of
> multi-way merge?

Yes.  Its called an octopus merge.  It happpens sometimes when
merging 2 or more otherwise fairly isolated changes in a single
shot.  E.g. `git merge feature-a feature-b thing-c`.
 
> Does git log show the parents in their ordinal order in the "Merge:" line?

Yes.

-- 
Shawn.
