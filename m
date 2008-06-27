From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] commit-tree: lift completely arbitrary limit of 16 parents
Date: Fri, 27 Jun 2008 15:00:34 +0200
Message-ID: <4864E472.3070301@viscovery.net>
References: <alpine.LFD.1.10.0806262243130.2988@localhost.localdomain> <alpine.DEB.1.00.0806271259440.9925@racer> <alpine.DEB.1.00.0806271324010.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Len Brown <lenb@kernel.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 27 15:01:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCDa2-0004e7-Jm
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 15:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161AbYF0NAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 09:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753652AbYF0NAh
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 09:00:37 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:57142 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753422AbYF0NAg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 09:00:36 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KCDZ4-0006mF-NT; Fri, 27 Jun 2008 15:00:34 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6E9C054D; Fri, 27 Jun 2008 15:00:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.DEB.1.00.0806271324010.9925@racer>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86551>

Johannes Schindelin schrieb:
> @@ -69,18 +63,16 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
>  
>  	check_valid(tree_sha1, OBJ_TREE);
>  	for (i = 2; i < argc; i += 2) {
> +		unsigned char sha1[40];

		unsigned char sha1[20];

is sufficient here, /me thinks.

-- Hannes
