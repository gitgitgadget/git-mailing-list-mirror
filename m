From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GIT 0.99.9e
Date: Mon, 7 Nov 2005 12:43:44 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511071242130.27907@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v64r5t3m0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751341AbVKGLnr@vger.kernel.org Mon Nov 07 12:45:22 2005
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751341AbVKGLnr@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZ5Q7-0005Bd-LJ
	for glk-linux-kernel-3@gmane.org; Mon, 07 Nov 2005 12:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbVKGLnr (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 7 Nov 2005 06:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbVKGLnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 06:43:46 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:47338 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751341AbVKGLnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 06:43:45 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 808D513F3AD; Mon,  7 Nov 2005 12:43:44 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 609A0B50C3; Mon,  7 Nov 2005 12:43:44 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 36C8FB50C6; Mon,  7 Nov 2005 12:43:44 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 03EC513F348; Mon,  7 Nov 2005 12:43:44 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64r5t3m0.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11261>

Hi,

On Sun, 6 Nov 2005, Junio C Hamano wrote:

>  - http-push seems to still have a bug or two but that is to be
>    expected for any new code, and I am reasonably sure it can be
>    ironed out; preferably before 1.0 but it is not a
>    showstopper.

I am reasonably sure that a run with valgrind will show the way to a 
stable http-push. It is just a little memory corruption: the rest works 
wonderfully.

Ciao,
Dscho
