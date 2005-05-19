From: Ingo Molnar <mingo@elte.hu>
Subject: Re: gitk-1.0 released
Date: Thu, 19 May 2005 15:24:11 +0200
Message-ID: <20050519132411.GA29111@elte.hu>
References: <17036.36624.911071.810357@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 15:27:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYl17-0002MO-0u
	for gcvg-git@gmane.org; Thu, 19 May 2005 15:24:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbVESNZb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 09:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbVESNZb
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 09:25:31 -0400
Received: from mx1.elte.hu ([157.181.1.137]:36240 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262495AbVESNYt (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 May 2005 09:24:49 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 1C36B3229B6;
	Thu, 19 May 2005 15:22:52 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 50F371FC2; Thu, 19 May 2005 15:24:19 +0200 (CEST)
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
In-Reply-To: <17036.36624.911071.810357@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Paul Mackerras <paulus@samba.org> wrote:

> I have released a new version of gitk.  I got brave and called it 1.0
> and it is at:
> 
> 	http://ozlabs.org/~paulus/gitk-1.0

very nice! Works well and it's pretty fast on a 2GHz P4.

a bugreport: when looking at the main git history, the following commit 
seems to be rendered incorrectly:

 211232bae64bcc60bbf5d1b5e5b2344c22ed767e

The "Octopus merge ..." text is incorrectly overlayed with a graph line.

here's a feature wishlist if you dont mind:

- the ability to copy & paste from all the windows would be nice. (e.g. 
  in the bugreport above i had to type down the "Octopus merge .." text 
  instead of pasting it from gitk)

- i guess this one is on your todo list: the history graph of a single
  object (file).

- first window appearance on an uncached repository can be pretty slow 
  due to disk seeks - so it might make sense to display something (an 
  hourglass?) sooner - when i first started it i thought it hung. On 
  already cached repositories the window comes up immediately, and the 
  list of commits is updated dynamically.

(and the biggest missing feature of GIT right now is author + 
last-commit annotated file viewing which could be integrated into gitk 
a'ka BK's revtool: selecting a given line of the file would bring one to 
that commit, etc.)

	Ingo
