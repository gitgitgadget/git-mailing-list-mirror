From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Showing commit info like the CVS plugin instead of tooltips.
Date: Tue, 8 Jan 2008 23:20:52 +0100
Message-ID: <200801082320.52548.robin.rosenberg.lists@dewire.com>
References: <200801072320.26987.rogersoares@intelinet.com.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: "Roger C. Soares" <rogersoares@intelinet.com.br>
X-From: git-owner@vger.kernel.org Tue Jan 08 23:21:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCMpP-0000q6-0L
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 23:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357AbYAHWVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 17:21:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755544AbYAHWVF
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 17:21:05 -0500
Received: from [83.140.172.130] ([83.140.172.130]:20546 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754357AbYAHWVD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 17:21:03 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BC74F1447762;
	Tue,  8 Jan 2008 23:21:01 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Jww56ozrF65w; Tue,  8 Jan 2008 23:21:01 +0100 (CET)
Received: from [10.9.0.4] (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 2F46A802861;
	Tue,  8 Jan 2008 23:21:01 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <200801072320.26987.rogersoares@intelinet.com.br>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69930>

tisdagen den 8 januari 2008 skrev du:
> Tooltips for the info were annoying, especially on MacOS where the tooltip center is your pointer location.
> It is now possible to copy&paste data.
> Like the CVS plugin, there's a menu to show/hide views. Thought it doesn't save in the preferences store for now.
Looks nice. We probably want this into preferences and I'd still like the tooltop as an option. I.e. when you turn off
the other panes the tooltip should come back. What I'd really want is the "Press F2"-version, like the javadoc
tooltips, but that requires some more work (I guess, maybe only a little is needed).

> +	/* private */TextViewer revDetailTextViewer;
> +	/* private */TextViewer revCommentTextViewer;
> +	/* private */IAction toggleCommentWrapAction;
> +	/* private */IAction toggleRevDetailAction;
> +	/* private */IAction toggleRevCommentAction;
>  
> -	private Table table;
> +	/* private */Table table;
>  
> -	private List<IFileRevision> fileRevisions;
> +	/* private */List<IFileRevision> fileRevisions;
>  
> -	protected boolean hintShowDiffNow;
> +	/* private */boolean hintShowDiffNow;
Why? What's wrong plain private?

> \ No newline at end of file
There was trailing whitespace also, but I can fix such things easily. I'm erasing those on changed lines only, a
change at the time at the moment instead of big ws fixes. In eclipse 3.3 there is an option to fix trailing spaces
on save on changed lines only.

-- robin
