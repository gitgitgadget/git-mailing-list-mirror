From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to tell if a file was renamed between two commits
Date: Tue, 2 Feb 2010 18:32:19 -0800
Message-ID: <20100203023219.GA13092@spearce.org>
References: <ron1-2EA926.18292002022010@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ron Garret <ron1@flownet.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 03:32:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcV2Z-0000mA-Ng
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 03:32:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881Ab0BCCcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 21:32:23 -0500
Received: from mail-yx0-f189.google.com ([209.85.210.189]:62664 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131Ab0BCCcW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 21:32:22 -0500
Received: by yxe27 with SMTP id 27so737400yxe.4
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 18:32:21 -0800 (PST)
Received: by 10.101.147.24 with SMTP id z24mr9018241ann.150.1265164341854;
        Tue, 02 Feb 2010 18:32:21 -0800 (PST)
Received: from localhost ([209.20.77.23])
        by mx.google.com with ESMTPS id 20sm2374266ywh.47.2010.02.02.18.32.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Feb 2010 18:32:20 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ron1-2EA926.18292002022010@news.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138801>

Ron Garret <ron1@flownet.com> wrote:
> I'm trying to write a little utility that will extract all the revisions 
> of a particular file.  I start with a git rev-list HEAD -- filename, get 
> the tree objects with git cat-file commit, the file objects with git 
> ls-tree, and finally the file contents themselves with git cat-file 
> blob.  It works, except in the case where the file name was changed.  
> git rev-list is smart enough to track those name changes, but my little 
> revision tracker isn't.  It dies when suddenly there is no file with the 
> right name in the tree.
> 
> So... is there an easy way to work around this?  Is there a way to get, 
> say, rev-list to tell me when the file it is tracking changed names?  Or 
> a git-diff incantation?  I just need something that will tell me given 
> two commits and a file name whether the file was renamed between those 
> two commits and if so what its new name is.  There must be an easy way 
> to do this, but I can't figure out what it is.

Maybe use the -M flag to git log, or the --follow flag to
log/rev-list?

-- 
Shawn.
