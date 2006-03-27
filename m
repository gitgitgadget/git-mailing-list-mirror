From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Following renames
Date: Mon, 27 Mar 2006 13:30:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0603271326540.19568@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060326014946.GB18185@pasky.or.cz>  <7virq1sywj.fsf@assigned-by-dhcp.cox.net>
 <e06fl8$p9f$1@sea.gmane.org>  <Pine.LNX.4.64.0603260843250.15714@g5.osdl.org>
  <e06hts$1ne$1@sea.gmane.org>  <Pine.LNX.4.64.0603260947100.15714@g5.osdl.org>
  <e5bfff550603261122m5e680c62ye1290f3e601e947e@mail.gmail.com> 
 <Pine.LNX.4.64.0603261422280.15714@g5.osdl.org> 
 <e5bfff550603262147t3aec8da6p6bf2a333e2d35f1d@mail.gmail.com> 
 <Pine.LNX.4.64.0603270005330.15714@g5.osdl.org>
 <e5bfff550603270319w20796918wc8f8fe30a6c5627@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 27 13:30:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNpvh-0004BC-NW
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 13:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbWC0Lae (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 06:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbWC0Lae
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 06:30:34 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:17608 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750905AbWC0Lad (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Mar 2006 06:30:33 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id 8A5AF106B;
	Mon, 27 Mar 2006 13:30:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 7D5DD5EBE;
	Mon, 27 Mar 2006 13:30:32 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 55D8511C3;
	Mon, 27 Mar 2006 13:30:32 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550603270319w20796918wc8f8fe30a6c5627@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18081>

Hi,

On Mon, 27 Mar 2006, Marco Costalba wrote:

> I still think the problem with annotation is that you don't see
> patches that _remove_ lines of code, you need the whole diff for this.

Interesting. You'd need a "git-emalb" (blame, but reverse), and you'd need 
to tell it a range "rev1..rev2" which is *not* to be interpreted as "^rev1 
rev2" but as a direct path from rev1 to rev2.

Ciao,
Dscho
