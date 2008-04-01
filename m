From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: [EGIT PATCH 1/4] Change history page table to SWT.VIRTUAL.
Date: Tue, 01 Apr 2008 00:54:01 -0300
Message-ID: <47F1B1D9.3090209@intelinet.com.br>
References: <1206890314-3712-1-git-send-email-rogersoares@intelinet.com.br> <20080331053430.GJ10274@spearce.org> <47F1AB1B.90309@intelinet.com.br> <20080401033614.GP10274@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, robin.rosenberg@dewire.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 01 05:59:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgXeH-0002KJ-W1
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 05:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbYDAD6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 23:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbYDAD6F
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 23:58:05 -0400
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1467 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751330AbYDAD6E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 23:58:04 -0400
Received: (qmail 34286 invoked by uid 0); 1 Apr 2008 00:59:51 -0300
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.372336 secs); 01 Apr 2008 03:59:51 -0000
Received: from unknown (HELO ?200.152.180.33?) (200.152.180.33)
  by cvxbsd.convex.com.br with SMTP; 1 Apr 2008 03:59:50 -0000
User-Agent: Thunderbird 1.5.0.12 (X11/20080213)
In-Reply-To: <20080401033614.GP10274@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78622>


Shawn O. Pearce escreveu:
> So anyway, I see no breakage on Mac OS X or Win32 with your patch,
> and you said you tested it on Linux, so I'm going to include it.
> Thanks for figuring that one out, its a nice performance boost.
>   
Cool.


>> Maybe another option to try before leaving windows out is the 
>> ILazyContentProvider. Have you noticed that while GenerateHistoryJob is 
>> updating the table you can't use it? Because the input is regenerated 
>> every time, the table keeps going back to the first row.
>>     
>
> Hmm.  I didn't notice that, but at this point its so damn fast for
> me that I don't have the reflexes to really try and use the table
> before GenerateHistoryJob is complete.  I'll have to add some sleeps
> in there to make it slow down its work and see if I can reproduce
> what you are describing.
>   
Yep, I noticed it while debuging and don't think it's very important. 
I'm very happy with the current speed and it's also almost instant to 
me. I think the lazy provider could be of some help in case someone is 
reading from a slow nfs partition or something like that. It's very 
border case thought.

[]s,
Roger.
