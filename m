From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: [EGIT PATCH] Showing commit info like the CVS plugin instead
 of tooltips.
Date: Tue, 08 Jan 2008 23:17:17 -0200
Message-ID: <4784209D.6080100@intelinet.com.br>
References: <200801072320.26987.rogersoares@intelinet.com.br> <200801082320.52548.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 02:16:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCPYj-0003MI-50
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 02:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbYAIBQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 20:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbYAIBQQ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 20:16:16 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1181 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750737AbYAIBQP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 20:16:15 -0500
Received: (qmail 4434 invoked by uid 0); 8 Jan 2008 23:18:37 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.01036 secs); 09 Jan 2008 01:18:37 -0000
Received: from unknown (HELO localhost.localdomain) (189.63.230.250)
  by cvxbsd.convex.com.br with SMTP; 9 Jan 2008 01:18:37 -0000
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <200801082320.52548.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69940>

Hi Robin,

> Looks nice. We probably want this into preferences and I'd still like the tooltop as an option. I.e. when you turn off
> the other panes the tooltip should come back. What I'd really want is the "Press F2"-version, like the javadoc
> tooltips, but that requires some more work (I guess, maybe only a little is needed).
>   
Showing the tooltips when you press F2 makes more sense to me. What I'm 
confortable to do now is to add another option in the history menu 
(after show revision comment) to show the tooltips. I can send a new 
patch with this.

For the search bar, I would like to make it visible by pressing ctrl-f 
when the history panel has the focus. So if I learn how to do it I can 
also do the F2 for the tooltips (low priority though).


>> +	/* private */TextViewer revDetailTextViewer;
>> +	/* private */TextViewer revCommentTextViewer;
>> +	/* private */IAction toggleCommentWrapAction;
>> +	/* private */IAction toggleRevDetailAction;
>> +	/* private */IAction toggleRevCommentAction;
>>  
>> -	private Table table;
>> +	/* private */Table table;
>>  
>> -	private List<IFileRevision> fileRevisions;
>> +	/* private */List<IFileRevision> fileRevisions;
>>  
>> -	protected boolean hintShowDiffNow;
>> +	/* private */boolean hintShowDiffNow;
>>     
> Why? What's wrong plain private?
>   
This is to improve performance and getting rid of the warning:
Read access to enclosing field GitHistoryPage.appliedPatches is emulated 
by a synthetic accessor method. Increasing its visibility will improve 
your performance

[]s,
Roger.
