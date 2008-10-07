From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [xfs-masters] git://oss.sgi.com broke
Date: Tue, 7 Oct 2008 10:39:56 -0700
Message-ID: <20081007103956.1f7a6cd6.akpm@linux-foundation.org>
References: <20081003121903.6c9a7ebc.akpm@linux-foundation.org>
	<48EA4B22.2050900@thebarn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: xfs-masters@oss.sgi.com, git@vger.kernel.org
To: Russell Cattelan <cattelan@thebarn.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 19:42:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnGYi-0003oa-KL
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 19:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbYJGRkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 13:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbYJGRkJ
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 13:40:09 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54957 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751951AbYJGRkI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Oct 2008 13:40:08 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m97HduO5002699
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 7 Oct 2008 10:39:57 -0700
Received: from y.localdomain (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id m97Hduwc022972;
	Tue, 7 Oct 2008 10:39:56 -0700
In-Reply-To: <48EA4B22.2050900@thebarn.com>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; x86_64-redhat-linux-gnu)
X-Spam-Status: No, hits=-2.825 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,WEIRD_PORT
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97736>

On Mon, 06 Oct 2008 12:30:10 -0500 Russell Cattelan <cattelan@thebarn.com> wrote:

> Andrew Morton wrote:
> > y:/usr/src/git26> git --version
> > git version 1.5.6.rc0
> >
> > y:/usr/src/git26> cat .git/branches/git-xfs
> > git://oss.sgi.com:8090/xfs/xfs-2.6.git#master
> >
> > y:/usr/src/git26> git-fetch git-xfs        
> > remote: usage: git-pack-objects [{ -q | --progress | --all-progress }] 
> > remote:         [--max-pack-size=N] [--local] [--incremental] 
> > remote:         [--window=N] [-remote: -window-memory=N] [--depth=N] 
> > remote:         [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] 
> > remote:         [--threads=N] [--non-empty] [--reremote: vs [--unpacked | --all]*] [--reflog] 
> > remote:         [--stdout | base-name] [--keep-unreachable] [<ref-list | <object-list]
> > remote: aborting due to possible repository corruption on the remote side.
> > fatal: protocol error: bad pack header
> >
> > It was OK yesterday.
> >
> > (cc'ing the git list in case this is an faq?)
> >
> > The last two error messages there look wrong/misleading?
> >
> >   
> Ok not sure exactly what was wrong but it looks like there was some 
> confusion
> with older git bits still install on oss.
> 
> I manually cleaned everything from the system and reinstalled git from a 
> fresh "make rpm" rpm.
> 
> Please try your pull again and see if the problem is resolved.
> 

It seems OK now, thanks.
