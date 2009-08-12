From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT PATCH] Provide a more JavaBeans-style 'getName' accessor for the id Signed-off-by: Alex Blewitt <alex.blewitt@gmail.com>
Date: Wed, 12 Aug 2009 21:09:29 +0200
Message-ID: <200908122109.29560.robin.rosenberg.lists@dewire.com>
References: <1241909854-11498-1-git-send-email-alex.blewitt@gmail.com> <8ACC6C83-75FD-477C-9083-96CA426FC069@gmail.com> <20090812142049.GA1033@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Alex Blewitt <alex.blewitt@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 12 21:09:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbJCf-0001qe-Nn
	for gcvg-git-2@gmane.org; Wed, 12 Aug 2009 21:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753553AbZHLTJb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2009 15:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753540AbZHLTJb
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Aug 2009 15:09:31 -0400
Received: from mail.dewire.com ([83.140.172.130]:26132 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753429AbZHLTJa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2009 15:09:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id CDAA71434E83;
	Wed, 12 Aug 2009 21:09:30 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lmWzCb4Fyy93; Wed, 12 Aug 2009 21:09:30 +0200 (CEST)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 1F4B51434E81;
	Wed, 12 Aug 2009 21:09:30 +0200 (CEST)
User-Agent: KMail/1.11.2 (Linux/2.6.28-11-generic; KDE/4.2.2; i686; ; )
In-Reply-To: <20090812142049.GA1033@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125726>

onsdag 12 augusti 2009 16:20:49 skrev "Shawn O. Pearce" <spearce@spearce.org>:
> Alex Blewitt <alex.blewitt@gmail.com> wrote:
> > On 10 Aug 2009, at 21:59, "Shawn O." <spearce@spearce.org> wrote:
> >>
> >>>> ./org/spearce/jgit/revwalk/RevTag.java:206: getName() in
> >>>> org.spearce.jgit.revwalk.RevTag cannot override getName() in
> >>>> org.spearce.jgit.lib.AnyObjectId; overridden method is final
> >>
> >> I can't apply this patch because getName() on RevTag is already
> >> defined with a different meaning.  :-(
> >
> > That sounds dangerous. We now have a .name() and a .getName() with  
> > different semantics. Can we not change the RevTag method name to  
> > something else so that we dont have an inconsistency?
> 
> Good point.  We didn't think that RevTag.getName method through
> very well.  Rename it to getTagName() ?

Ok with me.

-- robin
