From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: how to get 'git diff' to output patch to file
Date: Thu, 14 May 2009 14:03:59 +0200
Message-ID: <81b0412b0905140503n527d6a3ah34f4cdb72b0ce4c@mail.gmail.com>
References: <93C432AD0B8F4D25A19E0D67C535376A@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@googlemail.com>
X-From: git-owner@vger.kernel.org Thu May 14 14:04:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4ZfY-0005dL-7e
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 14:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022AbZENMEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 08:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755086AbZENMEA
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 08:04:00 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:40637 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892AbZENMD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 08:03:59 -0400
Received: by fxm2 with SMTP id 2so1252828fxm.37
        for <git@vger.kernel.org>; Thu, 14 May 2009 05:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PVP+ZhS2B4/rS6qj7bJurPrP8e6vKNFiBuzB7An0WOY=;
        b=oM5LC/RMYLB9LN4JDxhw4CUGitquuu/bMEHodBouOTO7bbecZClVVB0dV9RqUH5Dro
         F/3zes+afStkxXKCp7EmZoYlwWkeasR9goF/GgHpsa0DLfJncofVInpIO02ZL2sXAgzk
         YgIRyswodRgLPw4mW1pGYCa7ZPjrOluF3/0hE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xcI56tBLCsQtx193cEVa9jma7d9SWXAvgHbR2WtLVUBCoCdzFC2uqbjfaBnQVBxDW8
         utTa+sevNv6L5o41mlR9mU6mVYJ+qZ+BfDy7/56nXq4M+0kanTbKLEj/6FfyywfK8QF2
         Grzupp325SJ04lOn2cWh8CtAZkwZ8h2WDSWM4=
Received: by 10.204.72.129 with SMTP id m1mr2076398bkj.61.1242302639812; Thu, 
	14 May 2009 05:03:59 -0700 (PDT)
In-Reply-To: <93C432AD0B8F4D25A19E0D67C535376A@HPLAPTOP>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119183>

2009/5/14 Aaron Gray <aaronngray.lists@googlemail.com>:
> How do I get 'git diff -u' to output to a file or standard out instead of
> its viewer ?
>
  git diff -u > file
  GIT_PAGER=: git diff -u (stdout)

or, depending on how old your Git is

  git --no-pager diff -u
