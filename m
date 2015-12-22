From: Stephen & Linda Smith <ischis2@cox.net>
Subject: Re: [PATCH 2/2] Add a section to the users manual documenting shallow clones.
Date: Tue, 22 Dec 2015 09:18:54 -0700
Message-ID: <2514196.BYhOBJ81ik@thunderbird>
References: <1450750180-1811-1-git-send-email-ischis2@cox.net> <1450750180-1811-2-git-send-email-ischis2@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 22 17:18:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBPdg-0004LF-KJ
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 17:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754441AbbLVQSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 11:18:12 -0500
Received: from fed1rmfepo101.cox.net ([68.230.241.143]:47898 "EHLO
	fed1rmfepo101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbbLVQSL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 11:18:11 -0500
Received: from fed1rmimpo209 ([68.230.241.160]) by fed1rmfepo101.cox.net
          (InterMail vM.8.01.05.15 201-2260-151-145-20131218) with ESMTP
          id <20151222161810.QYL331.fed1rmfepo101.cox.net@fed1rmimpo209>
          for <git@vger.kernel.org>; Tue, 22 Dec 2015 11:18:10 -0500
Received: from thunderbird ([68.231.74.134])
	by fed1rmimpo209 with cox
	id wgJA1r0072tqoqC01gJAuv; Tue, 22 Dec 2015 11:18:10 -0500
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A020202.567977C2.0127,ss=1,re=0.000,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.0 cv=RNFt6fe+ c=1 sm=1
 a=/Rt4pg3TtX3KzfzhvVoEow==:17 a=kviXuzpPAAAA:8 a=wUQvQvOEmiQA:10
 a=9ytqajnV8cKjawKik6UA:9 a=CjuIK1q_8ugA:10 a=/Rt4pg3TtX3KzfzhvVoEow==:117
X-CM-Score: 0.00
Authentication-Results: cox.net; none
Received: from thunderbird.localnet (thunderbird [127.0.0.1])
	by thunderbird (Postfix) with ESMTP id DD3A113F6F3;
	Tue, 22 Dec 2015 09:18:55 -0700 (MST)
User-Agent: KMail/5.0.2 (Linux/4.3.0-2-generic; KDE/5.15.0; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282884>

On Monday, December 21, 2015 10:47:16 PM Eric Sunshine wrote:
> On Mon, Dec 21, 2015 at 9:09 PM, Stephen P. Smith <ischis2@cox.net> wrote:
> >  [[repositories-and-branches]]
> >  Repositories and Branches
> >  =========================
> > @@ -72,6 +71,25 @@ called the <<def_working_tree,working tree>>, together with a special
> >  top-level directory named `.git`, which contains all the information
> >  about the history of the project.
> >
> > +[[how-to-get-a-git-repository-with-minimal-history]]
> > +How to get a Git repository with minimal history
> > +------------------------------------------------
> 
> Is this a good placement for this topic? Shallow repositories are not
> heavily used, yet this placement amidst the very early and important
> topics of cloning and checking out branches assigns potentially
> significant (and perhaps unwarranted) weight to something used so
> rarely.

After some thought I think that the section should be moved near the bottom of 
"Sharing development with others" since 1) that would reduce the significance 
and 2) it seems that a shallow clone would normally be used for contributing to a 
large project when downloading the entire history is expensive.
Should it be placed just above the Tony Luk example?

sps
