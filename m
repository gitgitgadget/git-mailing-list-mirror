From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Move "-include config.mak" to end of configuration
 section
Date: Thu, 1 Dec 2005 01:46:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0512010144050.11941@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20051201012333.44bd81f2.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Dec 01 01:48:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehcb0-0001wJ-Fr
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 01:46:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbVLAAqm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 19:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbVLAAqm
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 19:46:42 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:16603 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751404AbVLAAqm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 19:46:42 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5597613F7EA; Thu,  1 Dec 2005 01:46:41 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 302AEB53A3; Thu,  1 Dec 2005 01:46:41 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 11659593E7; Thu,  1 Dec 2005 01:46:41 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D055313F7EA; Thu,  1 Dec 2005 01:46:40 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20051201012333.44bd81f2.tihirvon@gmail.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13033>

Hi,

On Thu, 1 Dec 2005, Timo Hirvonen wrote:

> This makes it possible to define WITH_SEND_EMAIL etc. in config.mak.

... but it breaks setups where config.mak overrides platform 
dependent settings...

Hth,
Dscho
