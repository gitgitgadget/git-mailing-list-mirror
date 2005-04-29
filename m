From: "Joshua T. Corbin" <jcorbin@wunjo.org>
Subject: Re: How to get bash to shut up about SIGPIPE?
Date: Thu, 28 Apr 2005 21:00:53 -0400
Message-ID: <200504282100.53567.jcorbin@wunjo.org>
References: <Pine.LNX.4.58.0504281121430.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 29 02:56:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRJmy-0001uZ-6H
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 02:55:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVD2BBD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 21:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbVD2BBD
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 21:01:03 -0400
Received: from smtp1.losch.net ([66.212.32.3]:709 "HELO smtp1.losch.net")
	by vger.kernel.org with SMTP id S262359AbVD2BA7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 21:00:59 -0400
Received: (qmail 31318 invoked by uid 102); 29 Apr 2005 01:01:01 -0000
Received: from 66.212.35.47 by smtp1 (envelope-from <jcorbin@wunjo.org>, uid 71) with qmail-scanner-1.24 
 (clamdscan: 0.80/856.  
 Clear:RC:1(66.212.35.47):. 
 Processed in 0.022985 secs); 29 Apr 2005 01:01:01 -0000
Received: from office.losch.net (66.212.35.47)
  by smtp1.losch.net with SMTP; 29 Apr 2005 01:01:01 -0000
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.58.0504281121430.18901@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 28 April 2005 14:28, you wrote:
> Right now my major gripe with cogito is "cg-log" (which is actually the
> only command I use right now, everything else I just do by hand with the
> raw git archive) is that bash is being an ass about SIGPIPE, and when I
> only look at the top part of the log, ie I do something like:

If cg-log is all you use, then you could get away with using yagf:
  rsync://node1.wunjo.org/yagf.git

Features of cg-log missing in yagf log:
  * colors
  * sigpipe gripes ;)
  * #!/bin/bash (or /usr/bin/env bash)
  * ability to log between two commits with rev-tree (it's a planned feature
    in the near future.)

Cheers,
Josh
