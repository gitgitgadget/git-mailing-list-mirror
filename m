From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: faster egit history page and a pure java "gitk"
Date: Tue, 25 Mar 2008 22:37:02 -0300
Message-ID: <47E9A8BE.4010606@intelinet.com.br>
References: <20080324092726.GQ8410@spearce.org> <47E8889E.6090403@intelinet.com.br> <20080325053649.GE4759@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Mar 26 02:41:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeKe9-0005o5-Mu
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 02:41:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758691AbYCZBkX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 21:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757520AbYCZBkW
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 21:40:22 -0400
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1026 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760829AbYCZBkV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 21:40:21 -0400
Received: (qmail 94993 invoked by uid 0); 25 Mar 2008 22:42:35 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.245792 secs); 26 Mar 2008 01:42:35 -0000
Received: from unknown (HELO ?200.152.180.33?) (200.152.180.33)
  by cvxbsd.convex.com.br with SMTP; 26 Mar 2008 01:42:35 -0000
User-Agent: Thunderbird 1.5.0.12 (X11/20080213)
In-Reply-To: <20080325053649.GE4759@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78241>

Shawn O. Pearce escreveu:
> Hmm.  How long does C Git take for "git rev-list HEAD >/dev/null" ?
> I have thus far only tuned the lower level machinary, and there
> may still be tuning left there, but I _really_ have not tried to
> tune the plotting portion yet.
>
> I did push something out a few minutes ago (b66eae Limit the number
> of UI refreshes ...) that may help improve performance on larger
> histories.
>   
"git rev-list HEAD >/dev/null" returns very fast, around 1 sec I'd say. 
My git clone has 0 loose objects and 1 pack.

I updated from your repo some minutes ago and it's pretty decent now. 
The history appears very fast, even changing projects, and for the git 
clone the progress bar disapears in around 7 seconds. :)

[]s,
Roger.
