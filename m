From: Steven Walter <stevenrwalter@gmail.com>
Subject: Re: Strange behavior with git rebase (-i)
Date: Sat, 2 Feb 2008 11:25:24 -0500
Message-ID: <20080202162524.GB25945@dervierte>
References: <47A44974.7050907@samba.org> <alpine.LSU.1.00.0802021538300.7372@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 02 17:26:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLLBr-0007oQ-Dr
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 17:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbYBBQZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 11:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbYBBQZa
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 11:25:30 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:7351 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbYBBQZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 11:25:29 -0500
Received: by an-out-0708.google.com with SMTP id d31so369853and.103
        for <git@vger.kernel.org>; Sat, 02 Feb 2008 08:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=kzmQ36O0ticxzakECNONkcA8rPNkMb86aRRDbzmPk+Y=;
        b=IMy7rz7kMz86M1NATXtC4ZW4iOSPKjAHcJ/ZDwWQHvlVk043SmkaE2oCLLPJOaNDR6qnJ+qbLJQRfWOZxXijNyDO1qsox89Tmw9zQzA+vHvBHrySlIaze25xfpMcXaGtmEi6EpRACPDF8zOVNk/ZZFM82C4xAQKAnNfA4iWtRCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=NRjw+eJ1DU8omyM9wiZuBVSDvs4/sBt37cXW5lLyNlY4zmizRpkZFaitxasW5K8n+DLejqO6EYI9BGlS/I/+JYbx5bOqMOsok0kxhSBXBsN24F7vt6h+flnuFEBcpT+Xz40X0fOABi+7nk2mIyY0jFK7z1JjlwW30DMOQUwcJ8M=
Received: by 10.100.201.16 with SMTP id y16mr10328143anf.30.1201969527004;
        Sat, 02 Feb 2008 08:25:27 -0800 (PST)
Received: from dasbrennen.isa-geek.org ( [76.177.39.93])
        by mx.google.com with ESMTPS id 36sm1847321aga.17.2008.02.02.08.25.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Feb 2008 08:25:26 -0800 (PST)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id E946E6410C; Sat,  2 Feb 2008 11:25:24 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802021538300.7372@racer.site>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72286>

On Sat, Feb 02, 2008 at 03:42:06PM +0000, Johannes Schindelin wrote:
> I don't believe it.  "git branch" would have shown "* (no branch)" as 
> current branch, unless the rebase is finalized.
> 
> git rebase -i works on a _detached_ HEAD, for two reasons:

> On Sat, 2 Feb 2008, Stefan (metze) Metzmacher wrote:
> > I was using git 1.5.3.2

Did rebase -i in git 1.5.3.2 use a detached head?  I thought that was
new in 1.5.4.
-- 
-Steven Walter <stevenrwalter@gmail.com>
Freedom is the freedom to say that 2 + 2 = 4
B2F1 0ECC E605 7321 E818  7A65 FC81 9777 DC28 9E8F 
