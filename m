From: Andreas Ericsson <ae@op5.se>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Thu, 14 May 2009 17:02:26 +0200
Message-ID: <4A0C3282.4000101@op5.se>
References: <200905122329.15379.jnareb@gmail.com> <20090512233450.GY30527@spearce.org> <200905141024.17525.jnareb@gmail.com> <20090514145724.GE30527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 14 17:03:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4cSk-0000rK-RY
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 17:03:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794AbZENPCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 11:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753220AbZENPCf
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 11:02:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:43804 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbZENPCe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 11:02:34 -0400
Received: by fg-out-1718.google.com with SMTP id 16so470455fgg.17
        for <git@vger.kernel.org>; Thu, 14 May 2009 08:02:34 -0700 (PDT)
Received: by 10.86.51.2 with SMTP id y2mr2637092fgy.3.1242313354577;
        Thu, 14 May 2009 08:02:34 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id l12sm2390018fgb.19.2009.05.14.08.02.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 May 2009 08:02:34 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <20090514145724.GE30527@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119202>

Shawn O. Pearce wrote:
> 
> In loopback mode for local file URIs, it may become an issue.  C Git
> is just getting lucky by the pipe size I think.  Though I thought I
> read somewhere yesterday pipe FIFOs in Linux were being allocated
> at 512 bytes, not one system page.  Of course other systems could
> allocate whatever size they want too, and may allocate something
> below the 2952 minimum, and we'd most likely see a deadlock on them.
> 

Linux allocates one page 4096 bytes for a FIFO. 512 is the maximum
size guaranteed by POSIX to result in an atomic write.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
