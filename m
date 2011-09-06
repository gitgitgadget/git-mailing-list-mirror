From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: git push output goes into stderr
Date: Tue, 6 Sep 2011 09:49:16 +0200
Message-ID: <20110906074916.GC28490@ecki>
References: <CAPgpnMQuck_aPU0ciaGgj-C8rno7jbzZ7wZ4unU8CqA0eaiYQw@mail.gmail.com>
 <7v8vq3ztym.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lynn Lin <lynn.xin.lin@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 09:51:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0qRd-0001w4-Sc
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 09:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753307Ab1IFHvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 03:51:42 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:5325 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753258Ab1IFHvl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 03:51:41 -0400
Received: from localhost (p5B22CD62.dip.t-dialin.net [91.34.205.98])
	by bsmtp.bon.at (Postfix) with ESMTP id 427CECDF8B;
	Tue,  6 Sep 2011 09:51:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v8vq3ztym.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180778>

On Sun, Sep 04, 2011 at 05:57:53PM -0700, Junio C Hamano wrote:
> Lynn Lin <lynn.xin.lin@gmail.com> writes:
> 
> > When I create a local branch and then push it to remote. I find that
> > the output without error goes into stderr, is this expected?
> 
> Progress output are sent to the stderr stream.

But it's not only progress output that goes to stderr in case of
git push. Even the summary written in tranport_print_push_status
goes to stderr, unless we specify git push --porcelain. Can't we
let that part of the output go to stdout unconditionally?

Clemens
