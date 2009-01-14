From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 2/3] remove pathspec_match, use match_pathspec instead
Date: Wed, 14 Jan 2009 17:09:39 +0100
Message-ID: <20090114160939.GA20307@localhost>
References: <1231944876-29930-1-git-send-email-drizzd@aon.at> <1231944876-29930-2-git-send-email-drizzd@aon.at> <1231944876-29930-3-git-send-email-drizzd@aon.at> <alpine.DEB.1.00.0901141637170.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	johannes@familieschneider.info
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 17:11:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN8Kk-0006Ah-Vf
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 17:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755271AbZANQJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 11:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756485AbZANQJq
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 11:09:46 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:56677 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296AbZANQJp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 11:09:45 -0500
Received: from darc.dyndns.org ([84.154.84.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 17:09:42 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LN8JH-0002CJ-RS; Wed, 14 Jan 2009 17:09:39 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901141637170.3586@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 14 Jan 2009 16:09:43.0475 (UTC) FILETIME=[8313B830:01C97662]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105651>

On Wed, Jan 14, 2009 at 04:40:42PM +0100, Johannes Schindelin wrote:
> > Both versions have the same functionality. This removes any
> > redundancy.
> >
> > This also adds makes two extensions to match_pathspec:
> 
> s/makes//

Thanks.

> Nice.  Does it still pass the test suite?  (From my reading, it should, 
> but I do not quite have the time to run it right now.)

It sure does. I am not confident enough to send untested patches yet. :-)

On Wed, Jan 14, 2009 at 04:44:36PM +0100, Johannes Schindelin wrote:
> I would prefer something like this:
> 
>       static int has_special(const char *p)
>       {
>               while (*p)
>                       if (isspecial(*(p++)))
>                               return 1;
>               return 0;
>       }

Ok, no problem.
