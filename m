From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git show <tree>: show mode and hash, and handle -r
Date: Wed, 29 Oct 2008 08:20:04 +0100
Message-ID: <49080EA4.9080404@viscovery.net>
References: <alpine.DEB.1.00.0810290207330.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, schacon@gmail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 29 08:21:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kv5Mv-0005BU-7J
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 08:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbYJ2HUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 03:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752561AbYJ2HUL
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 03:20:11 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:11191 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752539AbYJ2HUK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 03:20:10 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kv5LZ-00010h-8K; Wed, 29 Oct 2008 08:20:05 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D83DD4FB; Wed, 29 Oct 2008 08:20:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.DEB.1.00.0810290207330.22125@pacific.mpi-cbg.de.mpi-cbg.de>
X-Spam-Score: -0.8 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_60=1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99349>

Johannes Schindelin schrieb:
> Now, git show <tree> shows some more information, and with the -r option,
> it recurses into subdirectories.
> 
> Requested by Scott Chacon.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> 	The only quirk is the command line parsing for -r: we cannot use 
> 	DIFF_OPT_TST(&rev.diffopt, RECURSIVE), because that is switched 
> 	on not only by cmd_log_init(), but implicitly by 
> 	diff_setup_done(), because FORMAT_PATCH is selected by git-show.

This comment should for sure go into the commit message.

-- Hannes
