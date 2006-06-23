From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Rework diff options
Date: Sat, 24 Jun 2006 00:28:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606240024460.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060624011538.9bb179e7.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 00:28:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftu8t-0005sI-Ds
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 00:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752135AbWFWW2p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 18:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbWFWW2o
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 18:28:44 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:33741 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1752135AbWFWW2o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 18:28:44 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 55E85C64;
	Sat, 24 Jun 2006 00:28:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 496D6BDA;
	Sat, 24 Jun 2006 00:28:43 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 05D49B76;
	Sat, 24 Jun 2006 00:28:43 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060624011538.9bb179e7.tihirvon@gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22448>

Hi,

On Sat, 24 Jun 2006, Timo Hirvonen wrote:

> This patch series cleans up diff output format options.

Very good.

Although I understand that to convert all users to the new convention, it 
is sensible to rename the constants, I think it is not good to change 
something as DIFF_FORMAT_RAW to OUTPUT_FMT_RAW in the resulting patch.

IMHO it is an unnecessary change, and accounts for a lot of the diffstat.

Ciao,
Dscho
