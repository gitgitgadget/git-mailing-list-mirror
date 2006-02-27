From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: the war on trailing whitespace
Date: Mon, 27 Feb 2006 15:40:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602271539160.4371@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>
 <20060226103604.2d97696c.akpm@osdl.org> <Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>
 <20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer>
 <Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de>
 <94fc236b0602270326s3079d737l102d5728d59f0c98@mail.gmail.com>
 <4402E56D.4010606@op5.se> <20060227133124.GA8794@informatik.uni-freiburg.de>
 <4403086F.5040704@op5.se> <20060227143147.GA12196@brainysmurf.cs.umu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 15:41:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDjYX-0003C6-Ky
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 15:40:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbWB0Oky (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 09:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWB0Okx
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 09:40:53 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:50570 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751310AbWB0Okx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 09:40:53 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id 0636D1C87;
	Mon, 27 Feb 2006 15:40:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id ED12C5F5E;
	Mon, 27 Feb 2006 15:40:51 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id C54FF1D31;
	Mon, 27 Feb 2006 15:40:51 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Peter Hagervall <hager@cs.umu.se>
In-Reply-To: <20060227143147.GA12196@brainysmurf.cs.umu.se>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16848>

Hi,

On Mon, 27 Feb 2006, Peter Hagervall wrote:

> On Mon, Feb 27, 2006 at 03:10:55PM +0100, Andreas Ericsson wrote:
> > So in essence, a multi-line statement is closed when a completely empty 
> > line is found, which means that making git internals recognize and strip 
> > such lines will result in Python code never being manageable by git.
> > 
> 
> I believe completely empty lines are to be left untouched. The war is on
> trailing whitespace.

Exactly. That is what Andreas is saying: if you change a line which 
consists only of trailing whitespace to an empty line, it breaks python 
(or formatting).

Hth,
Dscho
