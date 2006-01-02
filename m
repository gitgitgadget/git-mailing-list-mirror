From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff-tree: stop on broken output pipe
Date: Mon, 2 Jan 2006 12:01:38 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601021159170.24000@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0601020116020.11331@wbgn013.biozentrum.uni-wuerzburg.de>
 <43B88013.3020904@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 02 12:01:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EtNRg-0000BU-PO
	for gcvg-git@gmane.org; Mon, 02 Jan 2006 12:01:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWABLBk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jan 2006 06:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWABLBk
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jan 2006 06:01:40 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:13453 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932304AbWABLBj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jan 2006 06:01:39 -0500
Received: from amavis.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D6C6613EBA5; Mon,  2 Jan 2006 12:01:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by amavis.mail (Postfix) with ESMTP id C70B02AF5;
	Mon,  2 Jan 2006 12:01:38 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by amavis.mail (Postfix) with ESMTP id AC35B27C0;
	Mon,  2 Jan 2006 12:01:38 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7899213EBA5; Mon,  2 Jan 2006 12:01:38 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43B88013.3020904@op5.se>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
X-Spam-Status: No, hits=0.0 tagged_above=0.0 required=8.0 tests=
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14138>

Hi,

On Mon, 2 Jan 2006, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
> > ---
> > 
> > 	Without this, on my iBook git-whatchanged keeps running when I 	quit
> > "less". I have to interrupt the process a second time. No
> > 	idea why it works on Linux.
> > 
> 
> On Linux the sending end dies when it catches SIGPIPE. I would have thought
> that should happen on OSX too. What shell are you running?

Why, bash 2.05a0(1)-release (powerpc-app,e-darwin6.0). Is there a way to 
turn off SIGPIPEs? Could be turned off by mistake here...

Ciao,
Dscho
