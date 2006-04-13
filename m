From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: Test fails on ubuntu breezy
Date: Thu, 13 Apr 2006 12:20:01 +0200
Message-ID: <20060413102001.GA3185@bohr.gbar.dtu.dk>
References: <cc723f590604130053k6896c0cfkd8ea648e91d50d0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Apr 13 12:20:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTyvq-0008MC-Un
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 12:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWDMKUG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 06:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWDMKUG
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 06:20:06 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:21675 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S964872AbWDMKUF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Apr 2006 06:20:05 -0400
Received: (qmail 3306 invoked by uid 5842); 13 Apr 2006 12:20:01 +0200
To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cc723f590604130053k6896c0cfkd8ea648e91d50d0e@mail.gmail.com>
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18658>

On Thu, Apr 13, 2006 at 01:23:07PM +0530, Aneesh Kumar wrote:
> kvaneesh@home:~/git-work/git.build/t$ ./t3600-rm.sh
> Committing initial tree e5c556e46aae6124ff4a2a466c95004e92d9a2e4
> *   ok 1: Pre-check that foo exists and is in index before git-rm foo
> *   ok 2: Test that git-rm foo succeeds
> *   ok 3: Post-check that foo exists but is not in index after git-rm foo
> *   ok 4: Pre-check that bar exists and is in index before "git-rm -f bar"
> *   ok 5: Test that "git-rm -f bar" succeeds
> *   ok 6: Post-check that bar does not exist and is not in index after
> "git-rm -f bar"
> *   ok 7: Test that "git-rm -- -q" succeeds (remove a file that looks
> like an option)
> *   ok 8: Test that "git-rm -f" succeeds with embedded space, tab, or
> newline characters.
> * FAIL 9: Test that "git-rm -f" fails if its rm fails
>         git-rm -f baz
> *   ok 10: When the rm in "git-rm -f" fails, it should not remove the
> file from the index
> * failed 1 among 10 test(s)
> kvaneesh@home:~/git-work/git.build/t$

On solaris 10 too, only test 5 also fails.

Peter
