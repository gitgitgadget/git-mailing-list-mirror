From: Pazu <pazu@pazu.com.br>
Subject: Re: git-svn fetch fails when a file is renamed changing only case
Date: Tue, 10 Oct 2006 14:57:14 -0300
Message-ID: <eggmun$1gf$1@sea.gmane.org>
References: <ege016$vrb$1@sea.gmane.org> <m2psd1rwb0.fsf@ziti.local> <egevhe$d15$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 10 19:58:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXLry-0006Ul-Fm
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 19:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWJJR6K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 13:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWJJR6K
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 13:58:10 -0400
Received: from main.gmane.org ([80.91.229.2]:16050 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964911AbWJJR6H (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 13:58:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GXLrV-0006QS-Ih
	for git@vger.kernel.org; Tue, 10 Oct 2006 19:57:54 +0200
Received: from 201.37.98.50 ([201.37.98.50])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Oct 2006 19:57:53 +0200
Received: from pazu by 201.37.98.50 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 10 Oct 2006 19:57:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 201.37.98.50
User-Agent: Thunderbird 1.5.0.7 (Macintosh/20060909)
In-Reply-To: <egevhe$d15$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28646>

Pazu wrote:

> Well, I'll keep browsing the git-svn source code, and try to make some 
> sense out of it...

While doing that I noticed the error happens in a code path that only 
gets executed when SVN::Core isn't available. So I decided to go through 
the trouble of manually building and installing the subversion perl 
bindings, and to my delight, git-svn is working flawlessly now.

Since svn binaries *use* the svn libraries, I still don't think this was 
subversion's fault, but probably some bug in git-svn parsing svn output. 
Oh well, using SVN::Core fixed, and git-svn is a lot faster to boot.

-- Marcus
