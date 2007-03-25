From: David Lang <david.lang@digitalinsight.com>
Subject: Re: merge strategy request
Date: Sun, 25 Mar 2007 15:16:26 -0800 (PST)
Message-ID: <Pine.LNX.4.63.0703251514060.13765@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.63.0703241430420.12864@qynat.qvtvafvgr.pbz> 
 <Pine.LNX.4.63.0703250315461.4045@wbgn013.biozentrum.uni-wuerzburg.de> 
 <Pine.LNX.4.64.0703242130050.6730@woody.linux-foundation.org> 
 <7v648paj14.fsf@assigned-by-dhcp.cox.net> <46a038f90703251634t2ab6a455t382ebe29cdb53667@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 01:42:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVcMH-0004Dr-Kf
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 01:42:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932954AbXCYXm1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 19:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932966AbXCYXm1
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 19:42:27 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:36135 "HELO
	warden.diginsite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S932954AbXCYXm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 19:42:26 -0400
Received: from wlvims02.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Sun, 25 Mar 2007 15:42:26 -0800
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Sun, 25 Mar 2007 16:42:18 -0700
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <46a038f90703251634t2ab6a455t382ebe29cdb53667@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43097>

On Mon, 26 Mar 2007, Martin Langhoff wrote:

> On 3/25/07, Junio C Hamano <junkio@cox.net> wrote:
>> Right.  In the current system, git-mergetool might be a better
>> place to add support for special perpose 3-version file-level
>> merge backend than merge-recursive, at least until gitattributes
>> materializes.
>
> Would it be possible to have an env var (GIT_MERGE) that can be used
> to call an arbitrary script with merge/diff3 semantics instead of
> using the internal 3-way merge? That way we could do syntax-specific
> merges (ignore comments/whitespace, for example).
>
> i would surely have a use for it, as sometimes my internal team is not
> _that_ good about trimming whitespace, and we have merges that succeed
> except for their whitespace conflicts.

would you really want that for _all_ merges, or only for merges of specific file 
types?

if you want it for all merges you should be able to create a modified version of 
the current merge and just substatute it in your install.

if you want it only for specific file types (say .c, .h, and .cfg files) then 
you really want the gitattributes support.

did anyone jump in on that for a soc project?

David Lang
