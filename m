From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] rebase: allow --merge option to handle patches merged
 upstream
Date: Sun, 25 Jun 2006 04:04:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606250401490.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060622110941.GA32261@hand.yhbt.net>
 <11511989902239-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 04:05:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJzn-0000WD-Jc
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 04:05:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWFYCEu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 22:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbWFYCEu
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 22:04:50 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:51849 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964896AbWFYCEu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 22:04:50 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id EE0FBC6C;
	Sun, 25 Jun 2006 04:04:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id E19CDC62;
	Sun, 25 Jun 2006 04:04:48 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id B6065A72;
	Sun, 25 Jun 2006 04:04:48 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <11511989902239-git-send-email-normalperson@yhbt.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22578>

Hi,

On Sat, 24 Jun 2006, Eric Wong wrote:

> +		if test -n "`git-diff-index HEAD`"

This is not a sufficient test if the patch was already merged to upstream. 
For example, you can have two patches which touched the same file, and one 
of them was applied to upstream, the other not. The test fails to see 
that. Or am I missing something?

Ciao,
Dscho
