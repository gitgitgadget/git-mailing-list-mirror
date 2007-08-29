From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: repo.or.cz wishes?
Date: Thu, 30 Aug 2007 01:12:51 +0200
Message-ID: <200708300112.51666.jnareb@gmail.com>
References: <20070826235944.GM1219@pasky.or.cz> <200708282356.10605.jnareb@gmail.com> <20070829073212.GQ1976MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Thu Aug 30 01:13:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQWiq-0004fx-8D
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 01:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757030AbXH2XM5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 19:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755639AbXH2XM4
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 19:12:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:56230 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbXH2XM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 19:12:56 -0400
Received: by nf-out-0910.google.com with SMTP id g13so315164nfb
        for <git@vger.kernel.org>; Wed, 29 Aug 2007 16:12:54 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=U/zsVdL0i7TjAHaia04RNYOWd9CY4IiOSRMyv287KQLkxZrKxYPf5TdVVqym8wh65l5JZG3solg/XruLiJfpNLp0GCGbxO4bzqPf6/Hg/Mo53oTTdIMucxB1SwunO8X8zg47Nqr7SMxDqTj/CBwxfTmhKO7O2CtvPcVtpeuId88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LDWrW6KpfggamBgE/OjPC/DfncCsQyR2PfoQAcw8/3oMAKNPWKqmcdT7c3XiVTRJzIMTErKBsU0mbtO3nyfvCZKJznUDHSJhfwbVR6HdenFMNqvjb9sZqIxCMr++mDWFhJCewJq96CbxSG/tRzTdV7XxmbEIAUq8wBNmBhkIJCI=
Received: by 10.86.97.7 with SMTP id u7mr895472fgb.1188429174145;
        Wed, 29 Aug 2007 16:12:54 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id 13sm10091631fks.2007.08.29.16.12.50
        (version=SSLv3 cipher=OTHER);
        Wed, 29 Aug 2007 16:12:51 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070829073212.GQ1976MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56989>

On Wed, Aug 29, 2007, Sven Verdoolaege wrote:
> On Tue, Aug 28, 2007 at 11:56:10PM +0200, Jakub Narebski wrote:
>> On Tue, 28 August 2007, Sven Verdoolaege wrote:
>>> On Mon, Aug 27, 2007 at 11:58:42PM +0200, Jakub Narebski wrote:
>>>>
>>>> The problem is that repo.or.cz needs support for that in gitweb, while
>>>> gitweb in turn needs support for that in git. This needs git consensus
>>>> on how to specify object database location (or just gitdir) for
>>>> submodules, to have later submodule support in gitweb.
>>> 
>>> What would be the use of that (outside of gitweb) ?
>> 
>> For the hypothetical (planned?) future '--recurse-submodules' option
>> to git-diff family, git-ls-tree and git-ls-files, git-fetch and git-push
>> (but I think not git-pull), perhaps git-log (besides what it supports
>> by the way of git-diff-tree), maybe even git-status and git-commit.
> 
> Ah... you're talking about bare repositories, right?
> For non-bare repos, I'd assume you would only recurse for those
> submodules that you have actually checked out in your working tree.

For bare repositories, and for repositories which move around (at least
once change path). Gitweb uses repository like it is bare...

-- 
Jakub Narebski
Poland
