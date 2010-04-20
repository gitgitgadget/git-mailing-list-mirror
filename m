From: Jeff King <peff@peff.net>
Subject: Re: ghost refs
Date: Tue, 20 Apr 2010 10:24:44 -0400
Message-ID: <20100420142444.GA8851@coredump.intra.peff.net>
References: <89030B4A18ECCD45978A3A6B639D1F24032A074E1C@FL01EXMB01.trad.tradestation.com>
 <r2h32541b131004070958pa66bb7a3g6a1ecfaea0419965@mail.gmail.com>
 <20100407210010.GB27012@coredump.intra.peff.net>
 <loom.20100420T085842-887@post.gmane.org>
 <20100420115124.GB22907@coredump.intra.peff.net>
 <s2m76718491004200633la1cb07a6n8bc0d8d8e71b4e92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yann Dirson <yann.dirson@bertin.fr>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 20 16:25:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4EOA-0000Cc-3r
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 16:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795Ab0DTOZQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 10:25:16 -0400
Received: from peff.net ([208.65.91.99]:35086 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754791Ab0DTOZO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 10:25:14 -0400
Received: (qmail 3080 invoked by uid 107); 20 Apr 2010 14:25:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 20 Apr 2010 10:25:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Apr 2010 10:24:44 -0400
Content-Disposition: inline
In-Reply-To: <s2m76718491004200633la1cb07a6n8bc0d8d8e71b4e92@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145377>

On Tue, Apr 20, 2010 at 09:33:42AM -0400, Jay Soffian wrote:

> 4. Just append to the existing reflog? Given:
> 
> $ git checkout -b topic origin/master # 1
> $ git add; git commit ...
> $ git checkout master
> $ git merge topic
> $ git branch -d topic
> $ git checkout -b topic origin/master # 2

I like how the user would interact with that, but what happens with:

  git checkout -b topic/subtopic

The reflog of the deleted branch is in the way.

-Peff
