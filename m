From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvsimport - streamline temp index file creation and
 avoid creating empty tmpfiles
Date: Sat, 24 Jun 2006 21:05:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606242105160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606231811200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <11511257501323-git-send-email-martin@catalyst.net.nz>
 <Pine.LNX.4.63.0606241145280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vslluyika.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Jun 24 21:06:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuDSN-0005PD-LZ
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 21:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWFXTGB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 15:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWFXTGA
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 15:06:00 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:64671 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751041AbWFXTGA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 15:06:00 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id E33EF1453;
	Sat, 24 Jun 2006 21:05:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id D5DDCDE0;
	Sat, 24 Jun 2006 21:05:58 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id C6330C4C;
	Sat, 24 Jun 2006 21:05:57 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslluyika.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22537>

Hi,

On Sat, 24 Jun 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I would not care too strongly about that. Eventually, I really would like 
> > this file to reside in $GIT_DIR, not /tmp, but whatever. That is not my 
> > biggest concern right now. That I cannot update since June 18th, however, 
> > is.
> 
> Would reverting 8f732649 in the meantime be an option for you?

I think it is worth fixing instead of working around.

Ciao,
Dscho
