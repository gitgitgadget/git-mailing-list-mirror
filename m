From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH] git-cvsimport: Add -N option to force a new import
Date: Thu, 25 Oct 2007 00:01:53 -0400
Message-ID: <1193284913.2619.23.camel@mattlaptop2>
References: <1193268519.8008.11.camel@mattlaptop2>
	 <7vfxzz51d7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 06:02:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iktv6-00008T-9f
	for gcvg-git-2@gmane.org; Thu, 25 Oct 2007 06:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbXJYEB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2007 00:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbXJYEB4
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Oct 2007 00:01:56 -0400
Received: from sd-green-bigip-66.dreamhost.com ([208.97.132.66]:43994 "EHLO
	jankymail-a2.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751485AbXJYEBz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Oct 2007 00:01:55 -0400
X-Greylist: delayed 16394 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Oct 2007 00:01:55 EDT
Received: from [129.2.207.218] (rmccutch.student.umd.edu [129.2.207.218])
	by jankymail-a2.dreamhost.com (Postfix) with ESMTP id 835E0B6A67;
	Wed, 24 Oct 2007 21:01:54 -0700 (PDT)
In-Reply-To: <7vfxzz51d7.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.12.1 (2.12.1-3.matt1) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62268>

On Wed, 2007-10-24 at 20:17 -0700, Junio C Hamano wrote:
> Matt McCutchen <matt@mattmccutchen.net> writes:
> 
> > I had a git repository for development of rsync and wanted to start
> > importing the upstream CVS with git-cvsimport, but git-cvsimport saw
> > that the git repository existed and insisted on updating a previous
> > import.  This patch adds an -N option to git-cvsimport to force a new
> > import and updates the documentation appropriately.
> 
> Sounds like a useful addition.  Tests?

Are there existing tests for git-cvsimport somewhere whose example I
could follow?  (I didn't see any in t/ .)  If not, I suppose I will just
write a simple script that runs git-cvsimport with and without -N and
with and without an existing, empty git repository and checks that the
right things happen.

Matt
