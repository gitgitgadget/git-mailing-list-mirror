From: Adam Spiers <git@adamspiers.org>
Subject: tools for making upstreaming / backporting easier in git
Date: Sat, 21 Sep 2013 18:25:19 +0100
Message-ID: <20130921172519.GB20610@pacific.linksys.moosehall>
References: <20130427132118.GA25295@pacific.linksys.moosehall>
 <20130429133205.GA4672@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 21 19:25:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNQvz-0006ct-1V
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 19:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753252Ab3IURZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 13:25:24 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:47983 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236Ab3IURZV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 13:25:21 -0400
Received: from localhost (5.1.a.c.3.5.0.d.1.6.3.6.d.0.0.1.0.d.3.7.6.a.1.1.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:11a6:73d0:100d:6361:d053:ca15])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 9343A2E4EA
	for <git@vger.kernel.org>; Sat, 21 Sep 2013 18:25:19 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130429133205.GA4672@pacific.linksys.moosehall>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235131>

Hi all,

Back in April, I announced a couple of scripts I'd written to wrap
around git-cherry and git-notes, which help when you have more than a
trivial number of commits to upstream / backport from one branch to
another.  Since then I've improved these scripts, and also written a
higher-level CLI which should make the whole process pretty easy.

Yesterday I finally finished a blog post with all the details:

  http://blog.adamspiers.org/2013/09/19/easier-upstreaming-with-git/

These tools worked pretty well for me and my team, but no doubt some
people will have ideas how to improve them, or have different
techniques for tackling the problem.  Either way, I hope this is of
interest, and I'd be very interested to hear what people think!

Cheers,
Adam
