From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: GSoC status report
Date: Sat, 21 Jul 2007 03:12:10 +0200
Message-ID: <200707210312.11745.jnareb@gmail.com>
References: <200707201024.35605.jnareb@gmail.com> <Pine.LNX.4.64.0707201118550.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 21 03:05:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC3Pc-000680-AW
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 03:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763386AbXGUBFc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 21:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763168AbXGUBFc
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 21:05:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:7163 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759508AbXGUBFb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 21:05:31 -0400
Received: by nf-out-0910.google.com with SMTP id g13so70139nfb
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 18:05:29 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pTWrCsk8zvKYk0HHxj989Co9YhCL5FxT0KYWOHBCH+da6HjUGpG+gZ9iiTzUAWUnML6ydLk85UHnd726cdC+OKBc6Jbz4CFswlucVC9W1Vhut/Iy5oM8CMwM6KS3U0JK+OA6lg9p/ifKatcR7+MZ7tXTO5mVuvIsNxKvjqcbb/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CR2RrZ+pyERPEVJLFNuX1UgPG5gCNhVCqWG2+t1wenl28WJ4sNWTKKbnPMzzY0DMPTXXIENyEwiI7yTsQZr4twAA6b6IDd+Xgi2NMRDMtclctso5iFGIJkUlvnf5TxwrHgsg9f5AjWWXOkTkPqzh22lpUQlSIg4RKE93gaLQcoY=
Received: by 10.86.77.5 with SMTP id z5mr736224fga.1184979929580;
        Fri, 20 Jul 2007 18:05:29 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id v23sm8270079fkd.2007.07.20.18.05.27
        (version=SSLv3 cipher=OTHER);
        Fri, 20 Jul 2007 18:05:27 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0707201118550.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53128>

Johannes Schindelin wrote:

> FWIW this is the list of scripts that I would like to see converted by the 
> end of the year (feel free to object), ordered by their size:
> 
> verify-tag, reset, repack, tag, checkout, rebase, bisect, 
> rebase--interactive, am, commit.

I thought that verify-tag would be put into git-tag, with git-verify-tag
being alias to "git tag --verify" or something like that.

What about git-revert and git-cherry-pick (it is one script)? Or are you
simply concentrating on the tools you need most in common workflow?


Thanks for the reply
-- 
Jakub Narebski
Poland
