From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git clone downloads objects that are in GIT_OBJECT_DIRECTORY
Date: Mon, 6 Mar 2006 10:20:18 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603061019070.1422@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060306010825.GF20768@kvack.org> <20060306014253.GD25790@spearce.org>
 <7vfylwcncn.fsf@assigned-by-dhcp.cox.net> <20060306025702.GH25790@spearce.org>
 <BAYC1-PASMTP05F90E7F1807F05A274507AEE90@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Shawn Pearce <spearce@spearce.org>, junkio@cox.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 10:20:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGBtT-00041j-4S
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 10:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbWCFJUV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 04:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbWCFJUV
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 04:20:21 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:30381 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1752328AbWCFJUU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 04:20:20 -0500
Received: from virusscan.mail (mail03.mail [172.25.1.102])
	by mailrelay.mail (Postfix) with ESMTP id 61B7B132E;
	Mon,  6 Mar 2006 10:20:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 54EC9A90;
	Mon,  6 Mar 2006 10:20:19 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 9A635A84;
	Mon,  6 Mar 2006 10:20:18 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP05F90E7F1807F05A274507AEE90@CEZ.ICE>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17289>

Hi,

On Sun, 5 Mar 2006, sean wrote:

> However, it might be nice to have a command that allows you to 
> change origin information for a repo without needing to know git
> internals; maybe something like:
> 
> $ git set-origin <URL>
> 
> Or maybe better:
> 
> $ git set-remote --pull master:origin origin <URL>

FWIW, I once sent patches to make this easier by placing this information 
into the config file, but for reasons I did not understand, they were 
rejected. Sigh!

Ciao,
Dscho
