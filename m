From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Sanity check of git-commit patch, was Re: [PATCH] Making CFLAGS
 compilant with GNU Coding Standards
Date: Tue, 9 Aug 2005 16:19:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508091618320.7995@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <1123306575.7588.17.camel@dv.roinet.com> <7vy87c2lrv.fsf@assigned-by-dhcp.cox.net>
 <20050808231036.GA22778@mythryan2.michonline.com>
 <Pine.LNX.4.63.0508090140100.3695@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vpssnyge0.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508091212170.6752@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vu0hzw9sx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 16:21:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2UxS-00044m-PG
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 16:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932551AbVHIOTQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 10:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbVHIOTP
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 10:19:15 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:44460 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932551AbVHIOTO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2005 10:19:14 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7B436E3235; Tue,  9 Aug 2005 16:19:13 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6002EAC8F0; Tue,  9 Aug 2005 16:19:13 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 44FE0AC8C4; Tue,  9 Aug 2005 16:19:13 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 145E0E3235; Tue,  9 Aug 2005 16:19:13 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0hzw9sx.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 9 Aug 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > - I don't like the GNU way to abbreviate long options too much...
> 
> True.  My bad old habit.

An elegant method to do that:

case --some-long-option in "$1"*) ..; esac

Ciao,
Dscho
