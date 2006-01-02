From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] diff-tree: stop on broken output pipe
Date: Mon, 02 Jan 2006 02:21:23 +0100
Message-ID: <43B88013.3020904@op5.se>
References: <Pine.LNX.4.63.0601020116020.11331@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 02 02:21:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EtEOF-0003Mw-GL
	for gcvg-git@gmane.org; Mon, 02 Jan 2006 02:21:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWABBV0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Jan 2006 20:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWABBV0
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jan 2006 20:21:26 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:63434 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932304AbWABBVZ
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 1 Jan 2006 20:21:25 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 25CD46BCFE; Mon,  2 Jan 2006 02:21:24 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0601020116020.11331@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14136>

Johannes Schindelin wrote:
> ---
> 
> 	Without this, on my iBook git-whatchanged keeps running when I 
> 	quit "less". I have to interrupt the process a second time. No
> 	idea why it works on Linux.
> 

On Linux the sending end dies when it catches SIGPIPE. I would have 
thought that should happen on OSX too. What shell are you running?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
