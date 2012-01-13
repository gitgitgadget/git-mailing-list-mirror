From: Yves Goergen <nospam.list@unclassified.de>
Subject: Re: Bug! Git merge also fails with a wrong error message
Date: Fri, 13 Jan 2012 19:49:17 +0100
Message-ID: <4F107CAD.1020103@unclassified.de>
References: <loom.20120112T193624-86@post.gmane.org> <loom.20120113T181805-423@post.gmane.org> <20120113175040.GC9373@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 13 19:49:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlmC6-0007RE-EK
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 19:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758807Ab2AMSt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 13:49:28 -0500
Received: from dotforward.de ([178.63.102.138]:55742 "EHLO dotforward.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758801Ab2AMStX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 13:49:23 -0500
Received: from dsl01.83.171.159.183.ip-pool.nefkom.net ([83.171.159.183] helo=[192.168.1.13])
	by dotforward.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <nospam.list@unclassified.de>)
	id 1RlmBi-0002LG-Fe; Fri, 13 Jan 2012 19:49:18 +0100
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20120113175040.GC9373@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188524>

On 13.01.2012 18:50 CE(S)T, Jeff King wrote:
> Whether a file in the working tree is tracked or not does not have to do
> with the history, but rather with whether it is mentioned in the index.

I'm not using the index. In fact I don't even know how that what I have
read about it can be useful.

> Does the file appear in "git ls-files"?

Yes, it's in the list along with all other files.

> It sounds like you are perhaps making changes in the working tree and
> index, and then trying to checkout/merge on top of that. In that case
> "git status" would report the file as renamed, but it's possible the
> file is still in the working tree. From git's perspective the file is no
> longer tracked, but the operations you are requesting would overwrite
> the new contents (and git is being safe by refusing to do so).

Here's the git status output:
# On branch master
nothing to commit (working directory clean)

I have switched to master and the very next action was trying the merge.
There's no change in the working directory, and nothing uncommitted.

-- 
Yves Goergen "LonelyPixel" <nospam.list@unclassified.de>
Visit my web laboratory at http://beta.unclassified.de
