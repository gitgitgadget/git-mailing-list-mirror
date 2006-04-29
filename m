From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] Extended SHA1 -- "rev^#" syntax to mean "all parents"
Date: Sat, 29 Apr 2006 17:38:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604291737390.25093@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7virosalxb.fsf@assigned-by-dhcp.cox.net> <7vaca490ln.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 29 17:39:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZrXB-0003KA-Er
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 17:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWD2Pi6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 11:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWD2Pi6
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 11:38:58 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:40368 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750747AbWD2Pi5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Apr 2006 11:38:57 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id AA0AA1B0F;
	Sat, 29 Apr 2006 17:38:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 9D8AB1B45;
	Sat, 29 Apr 2006 17:38:56 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 75F741B0F;
	Sat, 29 Apr 2006 17:38:56 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vaca490ln.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19306>

Hi,

On Sat, 29 Apr 2006, Junio C Hamano wrote:

> A short-hand "rev^#" is understood to be "all parents of the
> named commit" with this patch.

Just my 2/100: Why not "rev^*"? I could remember that more easily.

Ciao,
Dscho
