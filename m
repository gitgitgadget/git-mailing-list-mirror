From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow branch names that end with ".lock"
Date: Thu, 07 May 2009 17:57:09 -0700
Message-ID: <7veiv0bee2.fsf@alter.siamese.dyndns.org>
References: <1241708714-20326-1-git-send-email-spearce@spearce.org>
	<1241708714-20326-2-git-send-email-spearce@spearce.org>
	<200905080102.44053.robin.rosenberg@dewire.com>
	<alpine.LFD.2.01.0905071620240.4983@localhost.localdomain>
	<7vprekbfik.fsf@alter.siamese.dyndns.org>
	<7viqkcbenb.fsf_-_@alter.siamese.dyndns.org>
	<20090508005417.GV30527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 08 02:57:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2EOw-0007uB-0k
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 02:57:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753591AbZEHA5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 20:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbZEHA5K
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 20:57:10 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:59872 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbZEHA5J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 20:57:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090508005709.HAWK20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 7 May 2009 20:57:09 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id oox91b0054aMwMQ04ox9X2; Thu, 07 May 2009 20:57:09 -0400
X-Authority-Analysis: v=1.0 c=1 a=wDcnqk65jR8A:10 a=oVFSCg6HenwA:10
 a=oAYF_C9AAAAA:8 a=ybZZDoGAAAAA:8 a=n60OEgzWI7GHfpt4_ZQA:9
 a=-W57LWIillU3vLjLE5oA:7 a=mcg_glfADf05QOqjgnZcn-mx_CMA:4 a=R0wQ3QzoQ0IA:10
 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <20090508005417.GV30527@spearce.org> (Shawn O. Pearce's message of "Thu\, 7 May 2009 17\:54\:17 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118552>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> A project policy for naming branches could be to use a dot as a word
>> separator (instead of '-' which is often done by existing projects), and
>> "fix.vm.lock" could be a very valid name for a branch to address a VM
>> locking issues.
>
> I think we sent the same patch... except...
>
>>  git-gui/lib/index.tcl                    |    2 +-
>
> Don't do that.  I'll patch git-gui and send you a pull request.

Why not?  I never commit my "how about this" weatherbaloon patches
directly ;-)

If you found that ours match identically except for that one line, that is
a very good indication.  I didn't check.
