From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2 0/8] docs: use metavariables consistently
Date: Sat, 18 Dec 2010 02:49:08 -0600
Message-ID: <20101218084908.GE6187@burratino>
References: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 18 09:50:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTsVG-0001Uf-4w
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 09:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751528Ab0LRItP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 03:49:15 -0500
Received: from mail-gx0-f180.google.com ([209.85.161.180]:48917 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab0LRItP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 03:49:15 -0500
Received: by gxk19 with SMTP id 19so831839gxk.11
        for <git@vger.kernel.org>; Sat, 18 Dec 2010 00:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8Ntu/9SnzDM7BaofyBl8T6suyAKPEuJLBh1YiluRzz8=;
        b=Pe4gtAf6Wj3CFYWfRa3iEV7iN8mBiXXd3Fhgmx0/c+wNiGZTVYAvtmNHdYgiPxXvmA
         37CDdJRZ6pI7BD9Wbs8drrPIpA09XZqIIAHkKQ75XzrIdlqNnI4w4J93wiMlNASmcQ3z
         sS1mmCosbJzQ6xz+0SPsFhjw/2t52mmQpzoUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KNbTi/Pj85vSZ7B4B8LYELqQxUZ0tLReidqLMqezGkKVmtmR96GC6X+qPKvI59OQnR
         di6gDVUKTO0u1q2iOBNcpWclkNoguzlgIXKOf6w0KCIl09WtNLBnR9/6EBbBQlLoVQd6
         WMCOtppgXSe3RDLCla5ptTTBMwj/tBzZ+lQpU=
Received: by 10.91.33.1 with SMTP id l1mr3190296agj.186.1292662153874;
        Sat, 18 Dec 2010 00:49:13 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id 37sm5373076anr.24.2010.12.18.00.49.11
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 18 Dec 2010 00:49:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163911>

Mark Lodato wrote:

>                               The biggest change is to drop the <tree-ish> and
> <commit-ish> (or <committish>) notation and just use <tree> or <commit>, since
> every command but commit-tree accepts tree-ishes and commit-ishes.

Thanks.  I think this will encourage UI consistency ("where you accept
a tree, accepts commits and tags, too") as a side effect.

> This is a rework of my earlier patch set from March [1], with the following
> differences:
>
> - Drop the patch to commit-tree that makes it accept a tree-ish.

Ah, missed this before.  It is not clear to me why this difference ---
is it just to be conservative about changing behavior?

> [1] http://kerneltrap.org/mailarchive/git/2010/3/13/25484
http://thread.gmane.org/gmane.comp.version-control.git/142078
