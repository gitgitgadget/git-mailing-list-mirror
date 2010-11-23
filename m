From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Git branch workflow
Date: Tue, 23 Nov 2010 04:05:16 +0100
Message-ID: <20101123030516.GA27595@nibiru.local>
References: <20101122170805.8jtzkqwxpcog0kgk@dennymagicsite.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 23 14:30:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKswz-0008Kh-Tq
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 14:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453Ab0KWNaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 08:30:19 -0500
Received: from caprica.metux.de ([82.165.128.25]:51507 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751293Ab0KWNaS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 08:30:18 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id oANDW4pL014887
	for <git@vger.kernel.org>; Tue, 23 Nov 2010 14:32:37 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id oANDV5oe011514
	for git@vger.kernel.org; Tue, 23 Nov 2010 14:31:05 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id oAN35GIn031491
	for git@vger.kernel.org; Tue, 23 Nov 2010 04:05:16 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20101122170805.8jtzkqwxpcog0kgk@dennymagicsite.com>
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161961>

* denny@dennymagicsite.com <denny@dennymagicsite.com> wrote:

> Consider a specific scenario:
> I am on dev server on master branch and I want to develop a specific  
> feature F.
> I cut a Feature branch F from master and start working on the feature.  
>   Once I am done with most of the work on F and it works reasonably  
> well, I want to push it to production, but .. before I do I realize  
> that I want to make some CSS fixes to the site, unrelated to other  
> branches, and I can wait with pushing Feature branch to Production  
> until I fix up CSS reasonably well.
> Here is the question:  do I cut the CSS branch from Master or do I cut  
> it from the Feature branch?

My advise: always fork from the latest stable revision (in your case:
production server's master). Before merging, always rebase onto latest
master and possibly rerun the test cycle.


cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
