From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [SoC RFC] about "restartable clone"
Date: Mon, 16 Feb 2009 08:00:01 -0800
Message-ID: <20090216160001.GC18525@spearce.org>
References: <1dacb48d0902131838i3a717ec9r96d8ae8224f7bc66@mail.gmail.com> <20090215203714.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Henry Huang <henry.s.huang@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 17:02:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ5uW-00023h-7k
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 17:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123AbZBPQAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 11:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbZBPQAE
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 11:00:04 -0500
Received: from george.spearce.org ([209.20.77.23]:43280 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbZBPQAD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 11:00:03 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3C46A38215; Mon, 16 Feb 2009 16:00:01 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090215203714.6117@nanako3.lavabit.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110198>

Nanako Shiraishi <nanako3@lavabit.com> wrote:
> Quoting Henry Huang <henry.s.huang@gmail.com>:
> 
> > Now i have several problems:
> >
> > 1) Less familiar with git source code
> > 2) Less experience in Open Source Development
> > 3) No proposal for this project
> >
> > My questions:
> >
> > 1) Are there any documents for git's internals ?-- (.git/ structure,
> > data structures: DAG of objects,
> > branches, tags, index etc.) and workflow of main operations
> >
> > 2) Could anyone give me some hints -- where to begin with this project?
> 
> A good starting point would be to download the source and look at the files in Documentation directory, including its technical subdirectory. The information in these files would answer large part of your questions in 1).

Also, the Git Community Book (http://book.git-scm.com/) chapter
7 "Internals and Plumbing" has some really nice detail on this.
I'm not sure it fully covers the algorithms used to generate a
pack file, but it does cover the data structures involved in
detail, with pretty graphics to help explain it.  Scott has done
a wonderful job editing this text.

-- 
Shawn.
