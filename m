From: Gerhard Wiesinger <lists@wiesinger.com>
Subject: Re: Global .git directory
Date: Tue, 4 May 2010 08:07:01 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1005040755360.12746@bbs.intern>
References: <alpine.LFD.2.00.1004270705280.15197@bbs.intern> <201004271159.34071.trast@student.ethz.ch> <alpine.LFD.2.00.1004272144470.11216@bbs.intern> <s2y40aa078e1004271326u3fbbd46au30f187bc3ca9c8c8@mail.gmail.com> <alpine.LFD.2.00.1004280710380.27548@bbs.intern>
 <q2k40aa078e1004280550o322dc5b8jca74d401a5eb1abe@mail.gmail.com> <alpine.LFD.2.00.1004282211431.29101@bbs.intern> <alpine.LFD.2.00.1005040705470.4835@bbs.intern> <20100504054040.GC13139@goomba>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, kusmabite@gmail.com,
	Thomas Rast <trast@student.ethz.ch>
To: Andrew Ruder <andy@aeruder.net>
X-From: git-owner@vger.kernel.org Tue May 04 08:07:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9BI9-0008NH-8W
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 08:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738Ab0EDGHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 02:07:33 -0400
Received: from chello084112167138.7.11.vie.surfer.at ([84.112.167.138]:34057
	"EHLO wiesinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754655Ab0EDGHc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 02:07:32 -0400
Received: from bbs.intern (localhost [127.0.0.1])
	by wiesinger.com (8.14.4/8.14.4) with ESMTP id o44672Oq014563;
	Tue, 4 May 2010 08:07:02 +0200
Received: from localhost (gerhard@localhost)
	by bbs.intern (8.14.4/8.14.4/Submit) with ESMTP id o44671Gh014559;
	Tue, 4 May 2010 08:07:01 +0200
In-Reply-To: <20100504054040.GC13139@goomba>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-MailScanner-Information-wiesinger-com: Please contact the ISP for more information
X-wiesinger-com-MailScanner-ID: o44672Oq014563
X-MailScanner-wiesinger-com: Found to be clean
X-MailScanner-SpamCheck-wiesinger-com: not spam, SpamAssassin (not cached,
	score=-4.364, required 4.5, autolearn=not spam, ALL_TRUSTED -1.80,
	AWL 0.04, BAYES_00 -2.60)
X-MailScanner-From: lists@wiesinger.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146295>

On Mon, 3 May 2010, Andrew Ruder wrote:
> On Tue, May 04, 2010 at 07:07:08AM +0200, Gerhard Wiesinger wrote:
> I know it all seems nit-picky, but if you want to see your changes make
> it into git.git you're best off making it as EASY AS POSSIBLE for the
> reviewer to take your patch and apply it and be done with it.  This just
> isn't possible without testcases, documentation updates, etc..
> Especially for feature additions (vs bug fixes) you really have to make
> life as simple (and normal) as possible for reviewers, maintainers,
> etc.. After all, it is a lot easier living without a feature than it is
> a documented bug-fix!
>
> Just a random lurker trying to help you out here!

Thnx for your feedback. Will rework some of the parts you mentioned.

I think such a strict process should be valid for final commits to the git 
repository. But for a first patch ready for discussion I think one 
shouldn't make such strict process rules. I think we are at the state 
whether such a patch *might* be accepted and reviewers should look at the 
content first to have a decision for digging further (e.g. rework some 
parts of the patch) or for "ok this makes no sense at all". I think this 
saves time of the reviewers and also my time (I could now make all the 
formal stuff of the patch you mentioned but when there is something 
fundamental wrong there e.g in concept all the work was useless when not 
accepted. I think there should be agreement of the roadmap of a feature 
and then a focus on formalism to finally commit a pathc. So I'm a fan of 
discussion and incremental work to minimise useless and typically 
frustrating effort.)

Ciao,
Gerhard

--
http://www.wiesinger.com/
