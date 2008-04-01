From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: [EGIT PATCH 1/4] Change history page table to SWT.VIRTUAL.
Date: Tue, 01 Apr 2008 00:25:15 -0300
Message-ID: <47F1AB1B.90309@intelinet.com.br>
References: <1206890314-3712-1-git-send-email-rogersoares@intelinet.com.br> <20080331053430.GJ10274@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, robin.rosenberg@dewire.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 01 05:30:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgXCG-0005gg-2I
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 05:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbYDAD3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 23:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752733AbYDAD3T
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 23:29:19 -0400
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1091 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752224AbYDAD3S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 23:29:18 -0400
Received: (qmail 10468 invoked by uid 0); 1 Apr 2008 00:31:06 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.90248 secs); 01 Apr 2008 03:31:06 -0000
Received: from unknown (HELO ?200.152.180.33?) (200.152.180.33)
  by cvxbsd.convex.com.br with SMTP; 1 Apr 2008 03:31:05 -0000
User-Agent: Thunderbird 1.5.0.12 (X11/20080213)
In-Reply-To: <20080331053430.GJ10274@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78619>


Shawn O. Pearce escreveu:
> Yea, I originally wrote my series around the VIRTUAL flag but on
> Win32 it caused ArrayIndexOutOfBoundsExceptions to be thrown from
> deep down within the Win32 implementation of the SWT Table widget.
>
> Appears to be something of a known bug, based on the Eclipse issue
> tracker, but not much work happening to fix it.
>   
Hum, a VIRTUAL table sounds like a very usefull feature to be badly 
broken on windows, at least there should be some workaround... is it 
easily reproducible?


> I'll retest this tomorrow on Win32, but I'm pretty certain its
> a bad idea on that platform.  What are you running on, Linux?
> Maybe we can set this flag everywhere except on Win32
Yep, linux.

Maybe another option to try before leaving windows out is the 
ILazyContentProvider. Have you noticed that while GenerateHistoryJob is 
updating the table you can't use it? Because the input is regenerated 
every time, the table keeps going back to the first row.

[]s,
Roger.
