From: Sam Vilain <sam@vilain.net>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Fri, 12 Sep 2008 11:28:36 +1200
Message-ID: <48C9A9A4.8090703@vilain.net>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809100841080.3384@nehalem.linux-foundation.org> <alpine.LFD.1.10.0809100844040.3384@nehalem.linux-foundation.org> <200809101823.22072.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	"Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 01:30:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdvbp-0007U8-Ir
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 01:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754836AbYIKX2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 19:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754811AbYIKX2u
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 19:28:50 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:50948 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754802AbYIKX2t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 19:28:49 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 5A2B321C50D; Fri, 12 Sep 2008 11:28:47 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=AWL,BAYES_00 autolearn=ham
	version=3.2.3
Received: from [192.168.2.22] (leibniz.catalyst.net.nz [202.78.240.7])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id E6B9021C13D;
	Fri, 12 Sep 2008 11:28:38 +1200 (NZST)
User-Agent: Icedove 1.5.0.12 (X11/20070606)
In-Reply-To: <200809101823.22072.jnareb@gmail.com>
X-Enigmail-Version: 0.94.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95667>

Jakub Narebski wrote:
>> And that dotted line really does sound like something you could do with 
>> just the existing "hyperlink" functionality in the commit message.
> 
> As far as I understand (note: I'm neither for, nor against the proposal;
> although I think it has thin chance to be accepted, especially soon),
> it is for graphical history viewers, for git-cherry to make it more
> precise (to detect duplicated/cherry-picked changes better), and in
> the future possibly to help history-aware merge strategies. And probably
> help patch management interfaces.

Can I suggest,

 1. bury this origin link idea

 2. make git-cherry-pick have a similar option to '-x', but instead of
    recording the original commit ID, record the original *patch* ID,
    *if* there was a merge conflict for that cherry pick.

 3. tools can build indexes from patch ID => (commit IDs) to make this
    other form of history navigation fast.

Sam
