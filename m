From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Showing commit info like the CVS plugin instead of tooltips.
Date: Wed, 9 Jan 2008 19:12:37 +0100
Message-ID: <200801091912.37723.robin.rosenberg.lists@dewire.com>
References: <200801072320.26987.rogersoares@intelinet.com.br> <200801082320.52548.robin.rosenberg.lists@dewire.com> <4784209D.6080100@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Wed Jan 09 19:14:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCfRo-0001x3-0l
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 19:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754349AbYAISON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 13:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754206AbYAISOM
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 13:14:12 -0500
Received: from [83.140.172.130] ([83.140.172.130]:9780 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754188AbYAISOL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 13:14:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 14F2A8030A3;
	Wed,  9 Jan 2008 19:14:10 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FiU23VNEzHFr; Wed,  9 Jan 2008 19:14:09 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 4CE9D80019B;
	Wed,  9 Jan 2008 19:14:09 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <4784209D.6080100@intelinet.com.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70002>

onsdagen den 9 januari 2008 skrev Roger C. Soares:
> Hi Robin,
> 
> > Looks nice. We probably want this into preferences and I'd still like the 
tooltop as an option. I.e. when you turn off
> > the other panes the tooltip should come back. What I'd really want is 
the "Press F2"-version, like the javadoc
> > tooltips, but that requires some more work (I guess, maybe only a little 
is needed).
> >   
> Showing the tooltips when you press F2 makes more sense to me. What I'm 
Actually not what I meant. Javadoc tooltips popup as a tooltip. When it is 
active you can press F2 to see more information,
copy text etc.

> For the search bar, I would like to make it visible by pressing ctrl-f 
> when the history panel has the focus. 
You're free to experiment. I'm quite fond of the search field in kmail. It is 
a textfield that filters mail on
header fields as I type.
> >> -	protected boolean hintShowDiffNow;
> >> +	/* private */boolean hintShowDiffNow;
> >>     
> > Why? What's wrong plain private?
> >   
> This is to improve performance and getting rid of the warning:
> Read access to enclosing field GitHistoryPage.appliedPatches is emulated 
> by a synthetic accessor method. Increasing its visibility will improve 
> your performance

Ah, should have noticed. That's ok.

I found a bug. When you travel down the histtory using arrow keys all of the 
sudden the commit info disappears.

-- robin
