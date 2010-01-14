From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Removal of post-upload-hook
Date: Thu, 14 Jan 2010 11:41:07 -0800
Message-ID: <20100114194107.GA20033@spearce.org>
References: <6f8b45101001141001q40d8b746v8385bc6ae37a6af4@mail.gmail.com> <20100114193607.GB25863@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arun Raghavan <ford_prefect@gentoo.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 14 20:41:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVVZK-0001dl-UB
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 20:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757535Ab0ANTlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 14:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757520Ab0ANTlS
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 14:41:18 -0500
Received: from qw-out-2122.google.com ([74.125.92.25]:8776 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757513Ab0ANTlS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 14:41:18 -0500
Received: by qw-out-2122.google.com with SMTP id 9so531248qwb.37
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 11:41:17 -0800 (PST)
Received: by 10.224.113.87 with SMTP id z23mr1329144qap.58.1263498071202;
        Thu, 14 Jan 2010 11:41:11 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 15sm95850yxh.4.2010.01.14.11.41.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 14 Jan 2010 11:41:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100114193607.GB25863@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137015>

Jeff King <peff@peff.net> wrote:
> On Thu, Jan 14, 2010 at 11:31:57PM +0530, Arun Raghavan wrote:
> > [I'm not on the list, so please CC me on replies]
> > 
> > Hello,
> > I noticed that the post-upload hook had been removed in commit
> > 1456b043fc0f0a395c35d6b5e55b0dad1b6e7acc. The commit message states:
> > 
> >     This hook runs after "git fetch" in the repository the objects are
> >     fetched from as the user who fetched, and has security implications.
> > 
> > I was wondering if someone could shed some light (or links) on what
> > security implications this hook has?
> 
> Because receive-pack runs as the user who is pushing, not as the
> repository owner. So by convincing you to push to my repository in a
> multi-user environment, I convince you to run some arbitrary code of
> mine.

Uhhh, this was in fetch/upload-pack Peff, not push/receive-pack.

Same issue though.

-- 
Shawn.
