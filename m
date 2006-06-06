From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git (part #2)
Date: Tue, 6 Jun 2006 10:19:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606061016150.11478@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v64jli66m.fsf@assigned-by-dhcp.cox.net> <20060602023545.GA5039@spearce.org>
 <7v3beodpqs.fsf@assigned-by-dhcp.cox.net> <20060606053905.GA9797@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 10:19:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnWms-0004jk-WE
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 10:19:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWFFITk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 04:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbWFFITk
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 04:19:40 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:48029 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750876AbWFFITj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 04:19:39 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id B832D2CA4;
	Tue,  6 Jun 2006 10:19:38 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id AC88B2CA2;
	Tue,  6 Jun 2006 10:19:38 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 55714D68;
	Tue,  6 Jun 2006 10:19:38 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060606053905.GA9797@spearce.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21368>

Hi,

On Tue, 6 Jun 2006, Shawn Pearce wrote:

> *1* Generating a simple pack with only deflate compression on the
> objects should be trivial.  Since this is 100% pure Java code nobody
> should be expecting great performance out of it from day 1 anyway.

If you use jzlib (http://www.jcraft.com/jzlib/) it should not be slow. 
IMHO the I/O will be the bottleneck, but I would be happy to be 
contradicted by the facts.

Ciao,
Dscho
