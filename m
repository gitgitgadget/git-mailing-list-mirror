From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 6/9] fetch: Check if all objects exist after fetching
Date: Thu, 18 Mar 2010 12:08:16 -0700
Message-ID: <20100318190816.GE10981@spearce.org>
References: <cover.1268913163.git.agruen@suse.de> <f2bf11648d2cfb58e348d2c8caffa841012fd994.1268913163.git.agruen@suse.de> <f747d7538f2a2bbdb48c9902298fa87691097eba.1268913163.git.agruen@suse.de> <b7762c1e05412618584e38b868bcc870676f6e62.1268913163.git.agruen@suse.de> <672662f82e19ab268bd83f2b48980f43f126c089.1268913163.git.agruen@suse.de> <dbb0f92deca35a16c898af697dc41affc377ae0b.1268913163.git.agruen@suse.de> <d3c00e2a27003dca196d5480007544610cc1e5b8.1268913163.git.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Thu Mar 18 20:08:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsL4y-0005Hg-Uh
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 20:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335Ab0CRTIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 15:08:20 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44106 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab0CRTIT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 15:08:19 -0400
Received: by pwi5 with SMTP id 5so814323pwi.19
        for <git@vger.kernel.org>; Thu, 18 Mar 2010 12:08:19 -0700 (PDT)
Received: by 10.115.38.6 with SMTP id q6mr77255waj.207.1268939299148;
        Thu, 18 Mar 2010 12:08:19 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm182496iwn.15.2010.03.18.12.08.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 18 Mar 2010 12:08:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <d3c00e2a27003dca196d5480007544610cc1e5b8.1268913163.git.agruen@suse.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142495>

Andreas Gruenbacher <agruen@suse.de> wrote:
> Check if all objects reachable from the fetched refs exist after
> fetching instead of before: this allows us to distinguish between a
> repository which is not up to date and a corrupted repository, and to
> ensure that the repository is up to date and complete after the fetch.

I'm against this particular change because it looks like it breaks
the idea of "quickfetch", which we introduced to support faster
fetches from the parent repository into a shared clone on the
same disk.
 
-- 
Shawn.
