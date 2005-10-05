From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: cvsimport using proxy?
Date: Wed, 5 Oct 2005 15:55:55 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510051554310.14244@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v4q7xc62d.fsf@assigned-by-dhcp.cox.net>
 <46a038f90510050309t1d075d7fj37c60a6052ec62f3@mail.gmail.com>
 <20051005125055.GF4682@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin@ng.eduforge.org>,
	Sven Verdoolaege <skimo@kotnet.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 15:58:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EN9kd-0003gM-LG
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 15:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965178AbVJEN4D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 09:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965177AbVJEN4C
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 09:56:02 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:3739 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965178AbVJEN4A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 09:56:00 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7BFA813EBDF; Wed,  5 Oct 2005 15:55:57 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5F3A69DB9F; Wed,  5 Oct 2005 15:55:57 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3831C9DBB6; Wed,  5 Oct 2005 15:55:57 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 005AF13EBDF; Wed,  5 Oct 2005 15:55:56 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20051005125055.GF4682@kiste.smurf.noris.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9707>

Hi,

On Wed, 5 Oct 2005, Matthias Urlichs wrote:

> HTTP proxies are quite simple, you say 
> 
>    1. Connect to Proxy Server.
>    2. Issue CONNECT Host:Port HTTP/1.1<CR><LF>.
>    3. Issue <CR><LF>.
>    4. Wait for a line of response.
>       If it contains HTTP/1.X 200 , the connection is successful.
>    5. Read further lines of response until you receive an empty line.
>    6. Now, you are connected to outside world through a proxy.
>       Do any data exchange you want.

Even simpler is to use transconnect, which transparently uses the proxy by 
intercepting the connect method using LD_PRELOAD.

Ciao,
Dscho
