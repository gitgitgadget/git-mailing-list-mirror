From: Karl Wiberg <kha@treskal.com>
Subject: Re: [StGit PATCH] Add import -p option
Date: Wed, 9 Sep 2009 00:37:14 +0200
Message-ID: <20090908223714.GA6364@diana.vm.bytemark.co.uk>
References: <b0943d9e0909081443g47978cb7mee241d74dc52adf7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gustav =?iso-8859-1?Q?H=E5llberg?= <gustav@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 01:09:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml9o8-00082g-3F
	for gcvg-git-2@lo.gmane.org; Wed, 09 Sep 2009 01:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752681AbZIHXH7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 19:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752625AbZIHXH7
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 19:07:59 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:37884 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbZIHXH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 19:07:59 -0400
X-Greylist: delayed 1832 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Sep 2009 19:07:59 EDT
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Ml9JK-0001fW-00; Tue, 08 Sep 2009 23:37:14 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0909081443g47978cb7mee241d74dc52adf7@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128047>

On 2009-09-08 22:43:39 +0100, Catalin Marinas wrote:

> This patch renames some of the existing import options and adds the
> -p (--strip) option which allows stripping the leading slashes of
> the diff paths.

Looks good (and the intent is very good). The import test should
probably be augmented with a test case for -pN, though. (And since you
didn't have to change the test in this patch, presumably the two
options you renamed weren't tested either.)

> +    if strip:
> +        cmd += ['-p', strip]

This test should probably be "if strip != None". It doesn't _really_
matter, technically, since -p0 is the default, but still ...

-- 
Karl Wiberg, kha@treskal.com
    www.treskal.com/kalle
