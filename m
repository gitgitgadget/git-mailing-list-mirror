From: mimimimi <mimimimimimi159@hotmail.com>
Subject: Re: [RFC/PATCH] avoid SIGPIPE warnings for aliases
Date: Sun, 20 Jul 2014 23:45:31 -0700 (PDT)
Message-ID: <1405925131451-7615524.post@n2.nabble.com>
References: <20130104124756.GA402@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 08:45:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X97Ly-0005kT-B6
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 08:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251AbaGUGpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 02:45:34 -0400
Received: from sam.nabble.com ([216.139.236.26]:47030 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbaGUGpc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 02:45:32 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <mimimimimimi159@hotmail.com>)
	id 1X97Ln-0001ba-FJ
	for git@vger.kernel.org; Sun, 20 Jul 2014 23:45:31 -0700
In-Reply-To: <20130104124756.GA402@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253943>

I set up a git alias like this:

git config --global alias.popmerge '!git stash pop && git merge master'

Then I call it, like this:

git popmerge

The "git stash pop" is executed, but the "git merge master" is ignored.

If I run "git merge master" right after the "git popmerge"... it sumply runs
as expected, performing the merge.

I have other aliases with long sequences of commands... and they run
flawlessly. It seems something at "git stash pop" makes the alias process to
halt... Is it possible to avoid this behavior? How?

Thanks.
code 128
<http://www.keepdynamic.com/barcoding/asp-net-barcode-generator.shtml>  







--
View this message in context: http://git.661346.n2.nabble.com/RFC-PATCH-avoid-SIGPIPE-warnings-for-aliases-tp7574160p7615524.html
Sent from the git mailing list archive at Nabble.com.
