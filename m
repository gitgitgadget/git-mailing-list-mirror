From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: how do i revert to a previous version, keeping the history
Date: Wed, 02 Apr 2008 08:57:42 +0200
Message-ID: <47F32E66.1010705@viscovery.net>
References: <47F32CBE.2040305@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ittay Dror <ittayd@tikalk.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 08:58:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgwvU-0007Cv-Jl
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 08:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813AbYDBG5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2008 02:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbYDBG5q
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Apr 2008 02:57:46 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:22315 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbYDBG5q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2008 02:57:46 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jgwto-0003pN-B8; Wed, 02 Apr 2008 08:56:44 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id E4F8BAFCC; Wed,  2 Apr 2008 08:57:42 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <47F32CBE.2040305@tikalk.com>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78685>

Ittay Dror schrieb:
> I have this revision history: A-B
> I want to go back to the code in A, but keep B in the history: A-B-A
> 
> How do I do that?

git revert HEAD

-- Hannes
