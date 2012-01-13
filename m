From: Yves Goergen <nospam.list@unclassified.de>
Subject: Re: Bug! Git merge also fails with a wrong error message
Date: Fri, 13 Jan 2012 20:05:56 +0100
Message-ID: <4F108094.5080705@unclassified.de>
References: <loom.20120112T193624-86@post.gmane.org> <loom.20120113T181805-423@post.gmane.org> <20120113175040.GC9373@sigill.intra.peff.net> <4F107CAD.1020103@unclassified.de> <20120113185436.GA13522@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 13 20:06:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlmRu-0006bW-NO
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 20:06:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758859Ab2AMTF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jan 2012 14:05:58 -0500
Received: from dotforward.de ([178.63.102.138]:56903 "EHLO dotforward.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758811Ab2AMTF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 14:05:58 -0500
Received: from dsl01.83.171.159.183.ip-pool.nefkom.net ([83.171.159.183] helo=[192.168.1.13])
	by dotforward.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <nospam.list@unclassified.de>)
	id 1RlmRo-0002i4-PR; Fri, 13 Jan 2012 20:05:56 +0100
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <20120113185436.GA13522@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188528>

On 13.01.2012 19:54 CE(S)T, Jeff King wrote:
> Whether you realize it or not, git is using the index to store state.
> When you "git add", "git rm", or "git mv", it is updating the index.

I'm using TortoiseGit most of the time and that doesn't expose the
concept of an "index". I edit files as usual, then select "commit" and
get the commit dialogue. In there I enter the commit message and select
all files to commit. I can add new files right there. There is no
two-step procedure.

> I notice that in your first mail, you mentioned a problem with
> "checkout", and in the second one, a problem with "merge". Do you still
> have the repo around with the "checkout" problem? If so, is the file
> also in your "git ls-files" output in that repo?

Yes, I have made a backup of the repo right after the initial problem
arose. And the git ls-files output is the same regarding that file.

> Which version of git are you using? There were many bugs fixed around
> this area of merge around the v1.7.7 timeframe.

msysGit 1.7.8 on Windows XP SP3. It's a "preview" but since Git is so
old now and there's been nothing but "previews", I consider msysGit's
meaning of the word "preview" as "stable".

-- 
Yves Goergen "LonelyPixel" <nospam.list@unclassified.de>
Visit my web laboratory at http://beta.unclassified.de
