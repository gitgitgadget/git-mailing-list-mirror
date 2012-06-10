From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCH v7 5/5] Implement line-history search (git log -L)
Date: Sun, 10 Jun 2012 11:38:14 +0200
Message-ID: <4FD46B06.4050609@in.waw.pl>
References: <cover.1339063659.git.trast@student.ethz.ch> <61a797a048c43d64352ef86a1b224f017e7161ae.1339063659.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Bo Yang <struggleyb.nku@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jun 10 11:38:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdebN-0005R9-07
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 11:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960Ab2FJJiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 05:38:24 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:38242 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752139Ab2FJJiX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 05:38:23 -0400
Received: from ip-78-30-108-114.free.aero2.net.pl ([78.30.108.114])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1SdebG-0007mH-6N; Sun, 10 Jun 2012 11:38:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <61a797a048c43d64352ef86a1b224f017e7161ae.1339063659.git.trast@student.ethz.ch>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199580>

On 06/07/2012 12:23 PM, Thomas Rast wrote:
> The algorithm is then simply to process history in topological order
> from newest to oldest, computing ranges and (partial) diffs.  At
> branch points, we need to merge the ranges we are watching.  We will
> find that many commits do not affect the chosen ranges, and mark them
> TREESAME (in addition to those already filtered by pathspec limiting).
> Another pass of history simplification then gets rid of such commits.

Hi,

this is absolutely great.

When I run your example invocations, nothing is displayed for a very
long time. I understand that this is because of the extra
'simplification pass', which means that whole results need to be ready
before anything is displayed. Adding something like '-10' doesn't seem
to have any effect, so I guess it is ignored. I hope that making '-<n>'
work would not be to complicated, but more important would be getting
incremental results. Will it be possible?

Zbyszek
