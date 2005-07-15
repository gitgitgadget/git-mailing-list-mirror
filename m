From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Is cogito really this inefficient
Date: Fri, 15 Jul 2005 10:48:26 +0100
Message-ID: <20050715104826.H25428@flint.arm.linux.org.uk>
References: <20050713135052.C6791@flint.arm.linux.org.uk> <Pine.LNX.4.58.0507131325170.17536@g5.osdl.org> <20050714083700.A26322@flint.arm.linux.org.uk> <tnxu0ixoiuo.fsf@arm.com> <20050714105938.A31383@flint.arm.linux.org.uk> <Pine.LNX.4.58.0507140832490.19183@g5.osdl.org> <Pine.LNX.4.58.0507141725280.19183@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 15 11:49:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtMoO-0006za-GC
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 11:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263259AbVGOJsi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jul 2005 05:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263268AbVGOJsi
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jul 2005 05:48:38 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62223 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263266AbVGOJsb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2005 05:48:31 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DtMo0-0006l2-GO; Fri, 15 Jul 2005 10:48:28 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DtMnz-0007Yy-3b; Fri, 15 Jul 2005 10:48:27 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0507141725280.19183@g5.osdl.org>; from torvalds@osdl.org on Thu, Jul 14, 2005 at 05:29:09PM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 14, 2005 at 05:29:09PM -0700, Linus Torvalds wrote:
> On Thu, 14 Jul 2005, Linus Torvalds wrote:
> > I'll look into making diff-cache be more efficient. I normally don't use
> > it myself, so I didn't bother (I use git-diff-files, which is way more
> > efficient, but doesn't show the difference against the _tree_, it shows
> > the difference against the index. Since cogito tries to hide the index
> > from you, cogito can't very well use that).
> 
> Ok, done.

Thanks Linus.  I'll look forward to trying this out.

-- 
Russell King
