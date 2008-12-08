From: Alexey Borzenkov <snaury@gmail.com>
Subject: Re: [PATCH] Define linkgit macro in [macros] section
Date: Mon, 8 Dec 2008 20:13:06 +0000 (UTC)
Message-ID: <loom.20081208T201048-954@post.gmane.org>
References: <e2480c70812081029s36eac963t76092c09af990ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 08 21:16:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9mWo-0001tU-DI
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 21:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834AbYLHUPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2008 15:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbYLHUPI
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 15:15:08 -0500
Received: from main.gmane.org ([80.91.229.2]:39531 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751468AbYLHUPH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2008 15:15:07 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1L9mVT-0006ON-4t
	for git@vger.kernel.org; Mon, 08 Dec 2008 20:15:03 +0000
Received: from 80.252.153.11 ([80.252.153.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Dec 2008 20:15:03 +0000
Received: from snaury by 80.252.153.11 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 08 Dec 2008 20:15:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.252.153.11 (Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.0.4) Gecko/2008102920 Firefox/3.0.4 (.NET CLR 3.5.30729))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102580>

Alexey Borzenkov <snaury <at> gmail.com> writes:

> I'm not sure whether undefined linkgit macro was working by pure chance
> or it is a regression in asciidoc 8.3.0,

I now found that the change in question was made in
http://hg.sharesource.org/asciidoc/rev/82bdfd1a3674 and "catchall" macro is now
commented out by default, all the more reason for git to define linkgit macro
properly.
