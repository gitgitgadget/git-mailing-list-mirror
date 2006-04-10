From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git log [diff-tree options]...
Date: Mon, 10 Apr 2006 10:10:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604101010001.31612@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604090950590.9504@g5.osdl.org> <7vbqvabn8f.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604091158310.9504@g5.osdl.org>
 <Pine.LNX.4.63.0604092312340.29136@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.63.0604100000430.30000@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060410012258.589f1581.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Apr 10 10:10:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSrTy-00054Z-9K
	for gcvg-git@gmane.org; Mon, 10 Apr 2006 10:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751039AbWDJIKn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 04:10:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWDJIKn
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 04:10:43 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:19394 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751038AbWDJIKn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 04:10:43 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id DF9CB1FF5;
	Mon, 10 Apr 2006 10:10:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id D3FE11FF4;
	Mon, 10 Apr 2006 10:10:41 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id B8C0F1FEC;
	Mon, 10 Apr 2006 10:10:41 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060410012258.589f1581.tihirvon@gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18584>

Hi,

On Mon, 10 Apr 2006, Timo Hirvonen wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > +static int cmd_whatchanged(int argc, const char **argv, char **envp)
> > +{
> > +	memmove(argv + 2, argv + 1, argc - 1);
> 
> Shouldn't the size be sizeof(char *) * argc (NULL terminated array)?
> There's also overflow...

Yeah, this was some useless late-night coding. But you get the idea.

Ciao,
Dscho
