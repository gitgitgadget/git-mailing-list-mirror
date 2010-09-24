From: Tait <git.git@t41t.com>
Subject: Minimum Perl version?
Date: Fri, 24 Sep 2010 03:00:19 -0700
Message-ID: <20100924100019.GT23563@ece.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 12:13:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz5HL-000604-F1
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 12:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431Ab0IXKNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 06:13:06 -0400
Received: from ehlo.cat.pdx.edu ([131.252.208.106]:51097 "EHLO
	ehlo.cat.pdx.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab0IXKNF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 06:13:05 -0400
X-Greylist: delayed 762 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Sep 2010 06:13:05 EDT
Received: from nemo.ece.pdx.edu (root@nemo.ece.pdx.edu [131.252.209.162])
	by ehlo.cat.pdx.edu (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id o8OA0KSe008668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 24 Sep 2010 03:00:20 -0700
Received: from nemo.ece.pdx.edu (tait@localhost [127.0.0.1])
	by nemo.ece.pdx.edu (8.13.6/8.13.1) with ESMTP id o8OA0JCN029396
	for <git@vger.kernel.org>; Fri, 24 Sep 2010 03:00:19 -0700 (PDT)
Received: (from tait@localhost)
	by nemo.ece.pdx.edu (8.13.6/8.12.6/Submit) id o8OA0JmW029378
	for git@vger.kernel.org; Fri, 24 Sep 2010 03:00:19 -0700 (PDT)
X-Authentication-Warning: nemo.ece.pdx.edu: tait set sender to git.git@t41t.com using -f
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.4 (ehlo.cat.pdx.edu [131.252.208.106]); Fri, 24 Sep 2010 03:00:20 -0700 (PDT)
X-Spam-Status: No, score=0.0 required=6.0 tests=none autolearn=unavailable
	version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on ehlo.cat.pdx.edu
X-Virus-Scanned: clamav-milter 0.96.1 at ehlo
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156967>


What is the minimum Perl version git expects to support?

I ask, because f922df8... seems to have introduced a open() syntax that
is not compatible with some older Perl versions.
