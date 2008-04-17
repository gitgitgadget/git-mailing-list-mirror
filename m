From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Maintaining commit.template config through clones
Date: Thu, 17 Apr 2008 12:20:08 +0200
Message-ID: <48072458.70005@viscovery.net>
References: <48070EA4.2050503@rea-group.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Toby Corkindale <toby.corkindale@rea-group.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 12:21:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmREn-0001Sp-CA
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 12:21:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761386AbYDQKUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 06:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbYDQKUO
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 06:20:14 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:40646 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761386AbYDQKUN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 06:20:13 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JmRDt-0002XI-An; Thu, 17 Apr 2008 12:20:09 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1A1AE6D9; Thu, 17 Apr 2008 12:20:09 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <48070EA4.2050503@rea-group.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79783>

Toby Corkindale schrieb:
> I'm attempting to implement Git at our company, and we currently use a
> commit template for CVS. I can convert this to a Git-formatted template,
> and set it for use with git-config commit.template ....
> 
> However, once the repository is cloned, this configuration option
> vanishes from .git/config
> 
> Is there a way to make configuration options sticky?

Create or edit $prefix/share/git-core/templates/config.

-- Hannes
