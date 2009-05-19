From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: auto-merge after push?
Date: Tue, 19 May 2009 12:36:18 +0300
Message-ID: <20090519093618.GA29601@redhat.com>
References: <20090511142326.GA18260@redhat.com> <alpine.DEB.1.00.0905111714250.4973@intel-tinevez-2-302> <20090511201705.GA21045@redhat.com> <alpine.DEB.1.00.0905112302130.27348@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 19 11:37:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6LlK-00060E-Li
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 11:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbZESJhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 05:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbZESJhR
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 05:37:17 -0400
Received: from mx2.redhat.com ([66.187.237.31]:47415 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070AbZESJhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 05:37:16 -0400
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id n4J9bG2h023641;
	Tue, 19 May 2009 05:37:16 -0400
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id n4J9bFhh025680;
	Tue, 19 May 2009 05:37:16 -0400
Received: from redhat.com (dhcp-0-223.tlv.redhat.com [10.35.0.223])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id n4J9bE6d031523;
	Tue, 19 May 2009 05:37:14 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0905112302130.27348@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119510>

On Mon, May 11, 2009 at 11:03:27PM +0200, Johannes Schindelin wrote:
> Hi,
> 
> On Mon, 11 May 2009, Michael S. Tsirkin wrote:
> 
> > On Mon, May 11, 2009 at 05:18:06PM +0200, Johannes Schindelin wrote:
> > > The thing is, a merge can fail.  And then you already need direct access 
> > > to the working directory in question.
> > > 
> > > If you were actually talking about fast-forward pushes (because you did 
> > > the merge locally already), this might help you:
> > > 
> > > 	http://thread.gmane.org/gmane.comp.version-control.git/110251
> > 
> > Sounds good. But it looks like this patch is unlikely to be merged, does 
> > it not?
> 
> Unlikely to be merged by Junio?  Without success stories, certainly.
> 
> But you can do the same as I did: run your local Git with that patch.  I 
> am actually growing fonder and fonder of denyCurrentBranch=updateInstead.  
> It works beautifully here.

Same here. I've been using denyCurrentBranch=updateInstead for about a
week now. I find very useful.

> Of course, I always know what I am doing.

Haven't seen any issues so far.


> Ciao,
> Dscho
> 
> P.S.: :-)

-- 
MST
