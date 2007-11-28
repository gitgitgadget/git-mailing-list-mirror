From: Andreas Ericsson <ae@op5.se>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 28 Nov 2007 09:12:12 +0100
Message-ID: <474D22DC.1060408@op5.se>
References: <200711270622.lAR6MFXQ010010@mi0.bluebottle.com> <Pine.LNX.4.64.0711271109130.27959@racer.site> <alpine.LFD.0.99999.0711270917580.9605@xanadu.home> <20071127150829.GB3853@fieldses.org> <alpine.LFD.0.99999.0711271013310.9605@xanadu.home> <20071127153411.GA11731@fieldses.org> <alpine.LFD.0.99999.0711271047590.9605@xanadu.home> <20071127164243.GE11731@fieldses.org> <Pine.LNX.4.64.0711271652070.27959@racer.site> <20071127170749.GA19136@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>,
	=?UTF-8?B?44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 14:26:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKv7-00041k-9f
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:17:33 +0100
Received: from mail-mx9.uio.no ([129.240.10.39])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxI5Q-0004ct-8j
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 09:16:00 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx9.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxI4E-0006xT-PE
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 09:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbXK1IMV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 03:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753026AbXK1IMV
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 03:12:21 -0500
Received: from mail.op5.se ([193.201.96.20]:53034 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751482AbXK1IMU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 03:12:20 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E2D831F08038;
	Wed, 28 Nov 2007 09:12:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3rHS4u7mcS8x; Wed, 28 Nov 2007 09:12:16 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id DAE781F08022;
	Wed, 28 Nov 2007 09:12:14 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <20071127170749.GA19136@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.4, required=5.0, autolearn=disabled, AWL=2.605,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: C0A2AF8F4354B36642A8B330266425CB5CC6F3E2
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -43 maxlevel 200 minaction 2 bait 0 mail/h: 32 total 724103 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66325>

J. Bruce Fields wrote:
> On Tue, Nov 27, 2007 at 04:54:18PM +0000, Johannes Schindelin wrote:
>> Hi,
>>
>> On Tue, 27 Nov 2007, J. Bruce Fields wrote:
>>
>>> If we really want a fetch+rebase script, OK, but call it something other 
>>> than pull.
>> Why?  pull = fetch + merge only because that was the originally envisioned 
>> way to pull remote changes into your local working tree.  However, I do 
>> not see why we should be married to pull being a fetch and a merge for 
>> eternity.
> 
> Two responses:
> 
> First, OK, if you want to say "pull" means "fetch something and then
> incorporate it somehow into your current branch", that doesn't bother me
> quite as much as saying that "pull" always means "fetch + merge", and
> that "rebase" is really just a special kind of merge.  It's clearly not
> a merge.
> 

I beg to differ. The end result is identical to a merge (assuming one
never does "git rebase skip", which otoh could be thought of as one way
of resolving a merge conflict). It's just history that doesn't turn out
the same. git has always been about content, so from that pov, a rebase
is exactly the same as a merge.


> Second: "fetch+rebase" will really have very different properties from
> "fetch+pull".

"fetch+merge", no?

>  It may be possible to make the former behave a little
> like the latter in some common cases, but it's going to complicated.


True. I don't think octopus rebase needs to be supported, for example.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
