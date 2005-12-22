From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce core.sharedrepository
Date: Fri, 23 Dec 2005 00:04:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512230003560.12795@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0512222313070.12044@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vaceshi18.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0512222356540.12681@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 23 00:04:46 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpZUK-0001JZ-Sv
	for gcvg-git@gmane.org; Fri, 23 Dec 2005 00:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355AbVLVXEm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Dec 2005 18:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030356AbVLVXEm
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Dec 2005 18:04:42 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:31936 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030355AbVLVXEl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Dec 2005 18:04:41 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B4C6813F951; Fri, 23 Dec 2005 00:04:40 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9CB729E3C9; Fri, 23 Dec 2005 00:04:40 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 88D099E231; Fri, 23 Dec 2005 00:04:40 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6B11F13F951; Fri, 23 Dec 2005 00:04:40 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0512222356540.12681@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13979>

Hi,

On Thu, 22 Dec 2005, Johannes Schindelin wrote:

>                 if (mkdir(path, 0777) < 0)
>                         if (errno != EEXIST) {
>                                 *pos = '/';
>                                 return -1;
>                         }
>                 else if (shared_repository && make_group_writable(path)) {
>                         *pos = '/';
>                         return -2;
>                 }

D'oh! Time to head to bed now:

                if (mkdir(path, 0777) < 0) {
                        if (errno != EEXIST) {
                                *pos = '/';
                                return -1;
                        }
                } else if (shared_repository && make_group_writable(path)) {
                        *pos = '/';
                        return -2;
                }

Ciao,
Dscho
