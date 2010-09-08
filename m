From: Stephen Bash <bash@genarts.com>
Subject: Re: git log for a merged branch
Date: Wed, 8 Sep 2010 11:22:22 -0400 (EDT)
Message-ID: <7551190.230240.1283959342943.JavaMail.root@mail.hq.genarts.com>
References: <AANLkTimSHrmQgcrx-CqMgvkcBdgBG9icqw934+7qP7kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Wed Sep 08 17:22:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtMTt-0000hC-Fm
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 17:22:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755010Ab0IHPWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Sep 2010 11:22:33 -0400
Received: from hq.genarts.com ([173.9.65.1]:46359 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751716Ab0IHPWb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Sep 2010 11:22:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id C4F9C1E26254;
	Wed,  8 Sep 2010 11:22:30 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RMMKcR+M+OdT; Wed,  8 Sep 2010 11:22:23 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 06F331E261EA;
	Wed,  8 Sep 2010 11:22:23 -0400 (EDT)
In-Reply-To: <AANLkTimSHrmQgcrx-CqMgvkcBdgBG9icqw934+7qP7kg@mail.gmail.com>
X-Mailer: Zimbra 6.0.7_GA_2473.UBUNTU8 (ZimbraWebClient - SAF3 (Mac)/6.0.7_GA_2473.UBUNTU8)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155794>

----- Original Message -----
> From: "Tor Arntsen" <tor@spacetec.no>
> To: "Stephen Bash" <bash@genarts.com>
> Cc: "Git Mailing List" <git@vger.kernel.org>
> Sent: Wednesday, September 8, 2010 10:23:47 AM
> Subject: Re: git log for a merged branch
> On Wed, Sep 8, 2010 at 16:04, Stephen Bash <bash@genarts.com> wrote:
>
> > If I want to
> > see the commits (bug fixes) performed on the release branch, how do
> > I do it?
> [..]
> 
> Maybe not exactly what you ask for, but the way I do it is simply to
> use a non-ff merge with additional logging, i.e. git merge --no-ff
> --log <branchname-with-fixes>
> which will give me a merge commit which includes one-liners for each
> of those commits merged into mainline.

That's actually a pretty cool trick.  I will file that one for adoption as we move to a git-centric workflow.

I'm still curious if there's an "easy" way to extract the segment of history that was the release branch because I feel like there may be other uses than just git log... (not that I've nailed them down yet)

Thanks!
Stephen
