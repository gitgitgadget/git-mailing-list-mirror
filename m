From: Abhijit Menon-Sen <ams@toroid.org>
Subject: Re: export one commit id from a repository
Date: Sat, 22 May 2010 19:20:47 +0530
Message-ID: <20100522135047.GA10999@toroid.org>
References: <ht8mu6$hjo$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gelonida <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 22 16:00:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFpFF-0002FQ-W8
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 16:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758Ab0EVN76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 09:59:58 -0400
Received: from fugue.toroid.org ([85.10.196.113]:59143 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753304Ab0EVN76 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 09:59:58 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 May 2010 09:59:57 EDT
Received: from penne.toroid.org (unknown [10.8.0.10])
	by fugue.toroid.org (Postfix) with ESMTP id D8ED4558107;
	Sat, 22 May 2010 15:50:48 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id D46B420348; Sat, 22 May 2010 19:20:47 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <ht8mu6$hjo$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147526>

At 2010-05-22 15:41:26 +0200, gelonida@gmail.com wrote:
>
> I'd like to be able to concurrently (multiuser) create tar files from
> certain commmit ids.

git archive --prefix=foo/ $sha1 | gzip > foo.tar.gz

See git-archive(1).

-- ams
