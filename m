From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git clone error
Date: Thu, 28 Aug 2008 16:11:47 +0200
Message-ID: <48B6B223.2040607@op5.se>
References: <19199973.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "srinivasan.malligarjunan" <formypersonnel@yahoo.co.in>
X-From: git-owner@vger.kernel.org Thu Aug 28 16:17:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYiF2-0001la-Tq
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 16:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbYH1OLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 10:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752516AbYH1OLs
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 10:11:48 -0400
Received: from mail.op5.se ([193.201.96.20]:42061 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420AbYH1OLr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 10:11:47 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id F2F4B1B80089;
	Thu, 28 Aug 2008 16:16:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gFvtB2efOtUC; Thu, 28 Aug 2008 16:16:35 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.184])
	by mail.op5.se (Postfix) with ESMTP id 72ED51B80087;
	Thu, 28 Aug 2008 16:16:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <19199973.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94059>

srinivasan.malligarjunan wrote:
> [root@aspire038 git-1.5.6]# git clone git@github.com:/ayyanar/adva_cms.git
> Initialize adva_cms/.git
> Initialized empty Git repository in /root/Desktop/git-1.5.6/adva_cms/.git/
> The authenticity of host 'github.com (65.74.177.129)' can't be established.
> RSA key fingerprint is 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48.
> Are you sure you want to continue connecting (yes/no)? yes
> Warning: Permanently added 'github.com,65.74.177.129' (RSA) to the list of
> known hosts.
> Permission denied (publickey).
> fatal: The remote end hung up unexpectedly
> [root@aspire038 git-1.5.6]# git clone
> git@github.com:/karthikeyan7585/adva_cms.git
> Initialize adva_cms/.git
> Initialized empty Git repository in /root/Desktop/git-1.5.6/adva_cms/.git/
> Permission denied (publickey).
> fatal: The remote end hung up unexpectedly
> [root@aspire038 git-1.5.6]# 
> 
> 
> 
> The permission denied error is comming . Please help me.

You're trying to clone over ssh as the user "git", but your key doesn't
check out. You probably want to run the command

    git clone git://github.com/karthikeyan7585/adva_cms.git

which works just fine for me.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
