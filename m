From: David Lang <david.lang@digitalinsight.com>
Subject: Re: I want to release a "git-1.0"
Date: Wed, 1 Jun 2005 13:06:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0506011304001.21267@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org><972477.0a6782ba1d3b9f05216ed520ef720fcf.ANY@taniwha.stupidest.org><Pine.LNX.4.58.0505301801520.1876@ppc970.osdl.org><7vu0kiu8pm.fsf@assigned-by-dhcp.cox.net><Pine.LNX.4.62.0505311923240.19864@qynat.qvtvafvgr.pbz>
 <7vhdgismo0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Chris Wedgwood <cw@f00f.org>, Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 22:05:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdZRV-0000nA-JB
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 22:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVFAUGv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 16:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbVFAUGv
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 16:06:51 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:25219 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S261153AbVFAUGt
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 16:06:49 -0400
Received: from wlvims01.diginsite.com by warden.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Wed, 1 Jun 2005 13:06:48 -0700
Received: by calexc01.diginsite.com with Internet Mail Service (5.5.2657.72)
	id <L6Z5WM1Q>; Wed, 1 Jun 2005 13:06:37 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id L6Z7L1XF; Wed, 1 Jun 2005 13:06:31 -0700
To: Junio C Hamano <junkio@cox.net>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <7vhdgismo0.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 31 May 2005, Junio C Hamano wrote:

>>>>>> "DL" == David Lang <david.lang@digitalinsight.com> writes:
>
> DL> Hmm, thinking out loud. would it help to look at the deltify scripts
> DL> and let them find the major chunks and then look in detail only when
> DL> that fails?
>
> It's unclear to me which part you are trying to help with
> deltify algorithm [*1*].

I was thinking that the speedups (only look for similar sized files, etc) 
would help narrow the search. Also each chunk that's different should be 
able to be able to be annotated as a chunk, instead of by individual line

> Internally, git-diff-cache -B -C is used which does use the
> deltify to locate complete rewrites, renames and copies (that's
> why the script is so slow).  For passing on and assigning blames
> line by line, parsing "diff --unified=0" output was a lot easier
> for this script and that was what I did in this quick-and-dirty
> version.

I was under the impressin that the deltafy stuff was significantly faster 
then you are suggeting that it is here

> [Footnotes]
>
> *1* David says "deltify" and Nico calls it "deltafy".  I am not
> a native speaker so I cannot tell, but which one is correct?

Nico is correct

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
