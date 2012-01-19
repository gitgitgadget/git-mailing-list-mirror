From: Mathieu CLAVEL <math.clavel@gmail.com>
Subject: Re: [BUG ?] completion of stash name with git stash
Date: Thu, 19 Jan 2012 16:34:05 +0000 (UTC)
Message-ID: <loom.20120119T172954-563@post.gmane.org>
References: <loom.20120119T141601-606@post.gmane.org> <87lip3mzsz.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 17:34:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnuwT-0005y1-0z
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 17:34:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821Ab2ASQeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 11:34:21 -0500
Received: from lo.gmane.org ([80.91.229.12]:41098 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751033Ab2ASQeU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 11:34:20 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RnuwM-0005uz-NQ
	for git@vger.kernel.org; Thu, 19 Jan 2012 17:34:18 +0100
Received: from 249-137-167-83.reverse.alphalink.fr ([83.167.137.249])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 17:34:18 +0100
Received: from math.clavel by 249-137-167-83.reverse.alphalink.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 17:34:18 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.167.137.249 (Mozilla/5.0 (Windows NT 5.1; rv:9.0.1) Gecko/20100101 Firefox/9.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188819>

Thomas Rast <trast <at> student.ethz.ch> writes:

> This works for me using git completion as shipped with v1.7.9-rc2 and
> bash 4.2.10.  Double-tabbing at 'git stash drop ' prints a list of
> stashes as expected.  Which bash version are you using?


$ bash --version
GNU bash, version 3.1.0(1)-release (i686-pc-msys)
Copyright (C) 2005 Free Software Foundation, Inc.

It's the version ship with the last version of msysGit.
I'm not sure I can update bash on Windows without any risk to break something.
So, do you think it's coming from the bash version ?
