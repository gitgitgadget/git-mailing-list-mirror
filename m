From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Can't use gitk.
Date: Mon, 14 Nov 2005 14:45:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511141442310.8531@wbgn013.biozentrum.uni-wuerzburg.de>
References: <cda58cb80511140253s92f28e2g@mail.gmail.com>  <437870AF.8060607@op5.se>
  <cda58cb80511140322v686e4ee0g@mail.gmail.com>  <43787831.3030404@op5.se>
 <cda58cb80511140355q1add0ba5n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 14:47:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbeeD-0004cg-ME
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 14:45:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbVKNNpU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 08:45:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbVKNNpU
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 08:45:20 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:36065 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751123AbVKNNpT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 08:45:19 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5171E13F3DC; Mon, 14 Nov 2005 14:45:16 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 383859F2C2; Mon, 14 Nov 2005 14:45:16 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 25519907C8; Mon, 14 Nov 2005 14:45:16 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D36F913F43C; Mon, 14 Nov 2005 14:45:11 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <cda58cb80511140355q1add0ba5n@mail.gmail.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11797>

Hi,

On Mon, 14 Nov 2005, Franck wrote:

> nope every commands I'm running are not run as root. $HOME/bin is in my 
> path.

Is it possible that your wish is stripping away $HOME/bin from your PATH? 
Could you try the following?

	$ wish
	% git-rev-list

(If a lot of SHA1s are whizzing by, you can Ctrl-C it, and I am wrong.)

Hth,
Dscho
