From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH] doc: technical details about the index file format
Date: Wed, 02 Mar 2011 07:53:36 -0500
Message-ID: <1299070416.17973.29.camel@drew-northup.unet.maine.edu>
References: <AANLkTi=iFe=MmUiXzC_HMwueZxLJDCea+zp_-SNWvSup@mail.gmail.com>
	 <1283769430-9263-1-git-send-email-pclouds@gmail.com>
	 <AANLkTi=YJkk6KHChCrrazij_ziyG-Ru7kGLWc7JnUGoN@mail.gmail.com>
	 <AANLkTi=hz0xRsTy5f8xhzBhu0md_iPCxvdTrEPrzYwzt@mail.gmail.com>
	 <20110226100310.GA21724@do> <7vsjvb6qmt.fsf@alter.siamese.dyndns.org>
	 <20110226133639.GA32442@do> <7vpqqaffy2.fsf@alter.siamese.dyndns.org>
	 <AANLkTi=GhdfWCyx7MN3w0ZPhqKHcC1e6RmPeZt67OeqG@mail.gmail.com>
	 <7voc5ucb6b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	kusmabite@gmail.com, raa.lkml@gmail.com, jjuran@gmail.com,
	Robin Rosenberg <robin.rosenberg@dewire.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 02 13:54:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PulZG-00065I-Jr
	for gcvg-git-2@lo.gmane.org; Wed, 02 Mar 2011 13:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757264Ab1CBMyI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2011 07:54:08 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:56709 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756962Ab1CBMyH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2011 07:54:07 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p22Crdix009274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 2 Mar 2011 07:53:39 -0500
In-Reply-To: <7voc5ucb6b.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=8 Fuz1=8
	Fuz2=8
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p22Crdix009274
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1299675220.23422@2rmK9EJut4OuzkH49lz6Ng
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168305>


On Tue, 2011-03-01 at 22:02 -0800, Junio C Hamano wrote:

> I didn't like the way I explained the cache-tree entry order.  Was it
> understandable?
> 
> I am wondering if an illustration with an example might be in order.  I
> think anybody halfway intelligent may be able to get a fuzzy idea of what
> is going on by looking at the output from test-dump-cache-tree after
> "reset --hard && write-tree" and then by comparing it with the output from
> test-dump-cache-tree after running ">t/something && git add t/something"
> (which invalidates the top-level tree and t/ subtree). But a well written
> documentation should be able to help clarifying the idea obtainable that
> way.  I don't think what I wrote in the previous message is sufficient
> even for that (i.e. comparing the two output would give you better
> explanation of what is going on than what I wrote--iow, what I wrote may
> not be very useful for people who are motivated to learn).

Perhaps I'll be able to put some time into reading the work you guys are
doing.... I can definitely put the "newbie goggles" on if I do.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
