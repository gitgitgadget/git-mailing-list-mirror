From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-tree ---stdin -s -p broken
Date: Wed, 25 May 2005 11:14:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505251111300.2307@ppc970.osdl.org>
References: <20050525121738.GC24325@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 25 20:12:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Db0LC-0001j5-2a
	for gcvg-git@gmane.org; Wed, 25 May 2005 20:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVEYSMf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 May 2005 14:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVEYSMf
	(ORCPT <rfc822;git-outgoing>); Wed, 25 May 2005 14:12:35 -0400
Received: from fire.osdl.org ([65.172.181.4]:41640 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261503AbVEYSMc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2005 14:12:32 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4PICSjA012687
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 25 May 2005 11:12:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4PICRKP007583;
	Wed, 25 May 2005 11:12:27 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050525121738.GC24325@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 25 May 2005, Thomas Glanzmann wrote:
>
> this doesn't produce any output for me:

I think you're hitting the bug where "-s" was broken for a while
yesterday, and was a bit _too_ silent.

It was fixed by the

  "Use DIFF_FORMAT_NO_OUTPUT to implement diff-tree -s option"

commit. So update your git repo, you should be ok.

		Linus
