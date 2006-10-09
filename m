From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git-svn fetch fails when a file is renamed changing only case
Date: Mon, 09 Oct 2006 14:52:51 -0700
Message-ID: <m2psd1rwb0.fsf@ziti.local>
References: <ege016$vrb$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Oct 09 23:53:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX33T-0007B5-2g
	for gcvg-git@gmane.org; Mon, 09 Oct 2006 23:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbWJIVw4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 17:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbWJIVwz
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 17:52:55 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:57692 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964888AbWJIVwz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 17:52:55 -0400
Received: by py-out-1112.google.com with SMTP id z74so2147543pyg
        for <git@vger.kernel.org>; Mon, 09 Oct 2006 14:52:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=I04UpTmNcK7Vln/f3iJDaZr6vxrIqy0GPGBP3NuM7Ua0PZzkwS85aWC0RDjKtCNHX9S0zoaMDOqjIwgNBbhb+Rx4oF754RaMP2gFucnLNzRPvsypMBmGi2PAH8elvHnkmo7a/R120hvoR/VvR/AnQ4fCF6b4EmMOGj89zgctEI0=
Received: by 10.35.9.15 with SMTP id m15mr13717389pyi;
        Mon, 09 Oct 2006 14:52:54 -0700 (PDT)
Received: from ziti.local ( [140.107.181.122])
        by mx.google.com with ESMTP id n80sm233023pye.2006.10.09.14.52.52;
        Mon, 09 Oct 2006 14:52:53 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <ege016$vrb$1@sea.gmane.org> (pazu@pazu.com.br's message of "Mon, 09 Oct 2006 14:13:51 -0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28579>

Pazu <pazu@pazu.com.br> writes:

> For example, if you had a file named TestFile and it's renamed to
> TESTFILE, git-svn fails to fetch revisions after the rename.

Does this work for you via svn?  

On OS X, the default is a non case-sensitive filesystem.  I use OS X
and have encountered issues with case-change-only commits in svn.

IOW, are you sure this is an issue in git-svn and not an issue in
filesystem + svn?  For example, I think you will also have problems
with a repository that contains in the same dir TESTFILE and TestFile
:-\

+ seth
