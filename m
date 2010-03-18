From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCHv2] Teach --no-ff option to 'rebase -i'.
Date: Thu, 18 Mar 2010 09:03:31 +0100
Message-ID: <20100318080331.GC2557@m62s10.vlinux.de>
References: <1268755735-20588-1-git-send-email-marcnarc@xiplink.com> <1268768556-32176-1-git-send-email-marcnarc@xiplink.com> <20100316214717.GA24880@progeny.tock> <4BA07DC7.9070502@viscovery.net> <20100317155842.GA2557@m62s10.vlinux.de> <4BA0FE59.7020303@viscovery.net> <20100317184210.GB2557@m62s10.vlinux.de> <4BA1D183.3050907@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 18 09:03:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsAhx-00067t-0f
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 09:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025Ab0CRIDn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 04:03:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:46921 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751802Ab0CRIDh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 04:03:37 -0400
Received: (qmail invoked by alias); 18 Mar 2010 08:03:34 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp014) with SMTP; 18 Mar 2010 09:03:34 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+7s+0irYK7jzLQu+1MaOL4wiKNUT8Px45NCKuzTt
	wdbo+8eknMcWIS
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 6EBE9D4006; Thu, 18 Mar 2010 09:03:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4BA1D183.3050907@viscovery.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59999999999999998
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142453>

On Thu, Mar 18, 2010 at 08:08:51AM +0100, Johannes Sixt wrote:
> Peter Baumann schrieb:
> > On Wed, Mar 17, 2010 at 05:07:53PM +0100, Johannes Sixt wrote:
> >> Peter Baumann schrieb:
> >>> On Wed, Mar 17, 2010 at 07:59:19AM +0100, Johannes Sixt wrote:
> >>>> If I were to re-merge topic into master a second time after this
> >>>> situation, I would install a temporary graft that removes the second
> >>>> parent of M and repeat the merge. After the graft is removed, the history
> >>>> would look like this:
> >>>>
> >>>>      B --- C --- D --------------.   [topic]
> >>>>    /              \               \
> >>>>   A ---  ...   --- M ... --- U ... N [master]
> >>>>
> >>>> Are there any downsides? I don't know - I haven't thought it through.
> >>>>
> >>> Might be. If there is any branch starting anywhere in between M and U
> >>> which also needs to merge [topic] will also cause you headaches :-)
> >>>
> >>>        B --- C --- D --------------.   [topic]
> >>>      /              \               \
> >>>     A ---  ...   --- M ... --- U ... N [master]
> >>>                          \
> >>>                           x --- y [side_branch wich needs to merge topic] 
> >> ?? I don't follow you. The side branch already contains the topic. What do
> >> you want to merge?
> >>
> > 
> > Won't it loose the revert 'U' after merging side_branch back to master?
> > 
> > Ah. Looking at the picture more closely, I could answer myself and say it would
> > only cause a huge mergeconflict, won't it?.
> 
> No. N and the merge-base of N and y are identical (wrt changes introduced
> by B,C,D). At least this part will not cause any conflicts.
> 

You are right. How could I missed that.

Thanks for the clarification.

--
Peter
