From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: MinGW port - initial work uploaded
Date: Sat, 20 Jan 2007 21:05:23 +0100
Message-ID: <200701202105.23861.johannes.sixt@telecom.at>
References: <200701192148.20206.johannes.sixt@telecom.at> <20070120033149.GB11200@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 20 21:05:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8MSy-0001Nt-A0
	for gcvg-git@gmane.org; Sat, 20 Jan 2007 21:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965363AbXATUF3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Jan 2007 15:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965365AbXATUF3
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jan 2007 15:05:29 -0500
Received: from smtp3.noc.eunet-ag.at ([193.154.160.89]:44294 "EHLO
	smtp3.noc.eunet-ag.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965363AbXATUF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jan 2007 15:05:28 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.noc.eunet-ag.at (Postfix) with ESMTP
	id A0D293410E; Sat, 20 Jan 2007 21:05:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 15F81121CF;
	Sat, 20 Jan 2007 21:05:25 +0100 (CET)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <20070120033149.GB11200@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37285>

On Saturday 20 January 2007 04:31, Shawn O. Pearce wrote:
> Base your branch on Junio's 'master', not 'next'.  This looks like
> its going to be a fairly long-running topic with a large number
> of commits.  It will be easier to convince Junio to pull the topic
> in if its based solely on 'master' than if its based on 'next'.

I consider this branch only the sandbox for the MinGW port.

Although I've tried to make the branch as clean as possible, it is still a bit 
messy, and not everything is #ifdef'd that should be. For this reason I will 
not try to convince Junio to pull this topic directly. The goal is rather to 
work towards a complete port, then later factor out patches that 
bring 'master' or 'next' closer to this branch so that finally only at most a 
small patch series is needed that contains this topic.

> 	git-compat-util:
> 	#ifdef __MINGW32__
> 	#define is_mingw32 1
> 	#else
> 	#define is_mingw32 0
> 	#endif
>
> 	everywhere else:
> 	if (is_mingw32) {
> 	}

I like this idea.

-- Hannes
