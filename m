From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Tue, 01 Jun 2010 22:12:49 +0100
Message-ID: <4C0577D1.6030805@pileofstuff.org>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com>	<4BF7B751.7050704@pileofstuff.org>	<4BFB7F7F.5090407@drmicha.warpmail.net>	<4C041656.7000008@pileofstuff.org> <AANLkTinO_Z-1myhT-0TBIjELiEd4H-NnESs-AjTIpEf9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 23:13:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJYmC-00054a-KA
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 23:13:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757357Ab0FAVN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 17:13:27 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:22275 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757486Ab0FAVN0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 17:13:26 -0400
Received: from aamtaout04-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100601211251.MZMH3075.mtaout03-winn.ispmail.ntl.com@aamtaout04-winn.ispmail.ntl.com>;
          Tue, 1 Jun 2010 22:12:51 +0100
Received: from [192.168.1.5] (really [80.6.134.127])
          by aamtaout04-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100601211251.DXKC1593.aamtaout04-winn.ispmail.ntl.com@[192.168.1.5]>;
          Tue, 1 Jun 2010 22:12:51 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <AANLkTinO_Z-1myhT-0TBIjELiEd4H-NnESs-AjTIpEf9@mail.gmail.com>
X-Cloudmark-Analysis: v=1.1 cv=ZtHxNT4mZm3rCuM0SmWmgWxeBwJsziC8EqOrwwVkrhA= c=1 sm=0 a=BxPs6DqL8UcA:10 a=UBIxAjGgU1YA:10 a=IkcTkHD0fZMA:10 a=EMbafPi9zDA4U6LO6DQA:9 a=SEHpnXaIVdn4347SymoA:7 a=mHb2IlXENrxUEqr5H9r37j1Yo7gA:4 a=QEXdDO2ut3YA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148158>

I certainly think a "Git Traps for the Unwary" section would go well at
the bottom of the page.  My life would have been much easier if I could
have shown people a page where they could find ways to fix the things
I'd wrongly dismissed as non-problems.

I definitely agree about empty directories - even with Erik's point
about git-svn handling these, it's an issue people will face when they
transfer to git proper.

I'd suggest discussing svn:ignore as part of the wider topic of git's
non-support of SVN properties.  There are probably SVN teams out there
with elaborate sets of properties to migrate, and svn:ignore is a nice
hook to hang that discussion on without sending everyone else to sleep.

I agree that local/remote branches are worth discussing in more detail,
although I'm not sure how to explain it in SVN-friendly terms beyond
"this will seem weird at first, but will make sense eventually".  In
fact this is definitely a trap for the unwary, because the move from
directory-branches to label-branches tripped our migration up when we
had to rewrite tools that expected a "trunk" directory that was
guaranteed to have mainline code.

I think it's also worth mentioning local/remote commits, as it's quite
easy for people to commit and forget to push.

Finally, I agree that stash is certainly worth a mention - I'd also
suggest explaining how it's useful with `git svn rebase` and with
switching branches.  So I'd recommend putting it after both of those
sections.


I hope to have some writing time available this weekend, though that
could easily not happen.  So if someone else wants to have a crack at
it, be my guest :)

	- Andrew
