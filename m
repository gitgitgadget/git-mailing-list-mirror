From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] git commit --branch
Date: Mon, 29 May 2006 23:58:10 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605292357260.18328@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060529202851.GE14325@admingilde.org>
 <Pine.LNX.4.63.0605292310280.17412@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060529213704.GG14325@admingilde.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 23:58:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkpkc-0003jf-Jz
	for gcvg-git@gmane.org; Mon, 29 May 2006 23:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWE2V6M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 17:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbWE2V6L
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 17:58:11 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:19857 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751403AbWE2V6K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 17:58:10 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 217AC23F9;
	Mon, 29 May 2006 23:58:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 158D223F7;
	Mon, 29 May 2006 23:58:10 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id EDA931CA7;
	Mon, 29 May 2006 23:58:09 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060529213704.GG14325@admingilde.org>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20982>

Hi,

On Mon, 29 May 2006, Martin Waitz wrote:

> I'm doing two commits, one to HEAD and one to the other branch.
> It is more like:
> 
> 	git commit
> 	git checkout otherbranch
> 	git rebase --onto otherbranch master^ master   <-- first
> 	git checkout master
> 	git merge msg master otherbranch               <-- second

Wouldn't this merit a different option name, such as "--also-onto" instead 
of "--branch"?

Ciao,
Dscho
