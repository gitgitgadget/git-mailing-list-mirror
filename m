From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Subject: Re: [PATCH v2 0/4] perf bench: Common option for specifying style
 formatting
Date: Tue, 10 Nov 2009 17:23:57 +0900 (JST)
Message-ID: <20091110.172357.877383598482614594.mitake@dcl.info.waseda.ac.jp>
References: <20091110035812.GB29454@elte.hu>
	<20091110.165102.386189748263321818.mitake@dcl.info.waseda.ac.jp>
	<20091110080135.GA32322@elte.hu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org,
	a.p.zijlstra@chello.nl, paulus@samba.org
To: mingo@elte.hu
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754879AbZKJIXz@vger.kernel.org Tue Nov 10 09:24:18 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754879AbZKJIXz@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7m1P-0002EI-Pu
	for glk-linux-kernel-3@lo.gmane.org; Tue, 10 Nov 2009 09:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754879AbZKJIXz (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 10 Nov 2009 03:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754796AbZKJIXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Nov 2009 03:23:54 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:59790 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754780AbZKJIXy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Nov 2009 03:23:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 6CC2DBB6D31;
	Tue, 10 Nov 2009 17:23:59 +0900 (JST)
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dPQC9nm6gmDu; Tue, 10 Nov 2009 17:23:59 +0900 (JST)
Received: from localhost (fw-cisco.dcl.info.waseda.ac.jp [133.9.216.204])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 0A6B0BB6D2C;
	Tue, 10 Nov 2009 17:23:59 +0900 (JST)
In-Reply-To: <20091110080135.GA32322@elte.hu>
X-Mailer: Mew version 5.2 on Emacs 22.2 / Mule 5.0 (SAKAKI)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132549>

From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH v2 0/4] perf bench: Common option for specifying style formatting
Date: Tue, 10 Nov 2009 09:01:35 +0100

> 
> * Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp> wrote:
> 
> > And I have a question.
> > In tools/perf/command-list.txt, there is the word "mainporcelain".
> > What does this mean?
> 
> tools/perf/ inherited the command-list.txt code from the Git project:
> 
>   git://git.kernel.org/pub/scm/git/git.git
> 
> in Git talk, 'porcelain' is the pretty stuff humans use. 'plumbing' is 
> the lowlevel stuff humans dont get to see.
> 
> 'mainporcelain' are the major commands you get listed when you type 
> 'perf' (or 'git').

Thanks, I got it!

> 
> ( i've Cc:-ed the Git list as i never saw any real formal definition for
>   this anywhere, maybe i got this wrong :-)
> 
> > Of course I searched this word on my dictionary, but cannot got an answer.
> > I'm preparing the initial document for perf-bench.
> > Can I add perf-bench with mainporcelain to command-list.txt?
> 
> yeah, i'd suggest to do that - that will make 'perf bench' show up in 
> 'perf' output.

I'll describe perf bench as mainporcelain command, thanks.
