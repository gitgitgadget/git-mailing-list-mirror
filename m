X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Subprojects tasks
Date: Sun, 17 Dec 2006 00:14:22 +0100
Message-ID: <20061216231422.GE25274MdfPADPa@greensroom.kotnet.org>
References: <7vzm9nelob.fsf@assigned-by-dhcp.cox.net>
 <20061216203553.GA25274MdfPADPa@greensroom.kotnet.org>
 <7v64cbeeiv.fsf@assigned-by-dhcp.cox.net>
 <20061216225810.GD12411@admingilde.org>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sat, 16 Dec 2006 23:14:56 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <20061216225810.GD12411@admingilde.org>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34655>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gvik0-0000Ij-CJ for gcvg-git@gmane.org; Sun, 17 Dec
 2006 00:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422776AbWLPXOt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 18:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422777AbWLPXOt
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 18:14:49 -0500
Received: from smtp14.wxs.nl ([195.121.247.5]:62977 "EHLO smtp14.wxs.nl"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1422776AbWLPXOs
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec 2006 18:14:48 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl
 [84.81.90.170]) by smtp14.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built
 Jul 14 2004)) with SMTP id <0JAE004FU37YYU@smtp14.wxs.nl> for
 git@vger.kernel.org; Sun, 17 Dec 2006 00:14:23 +0100 (CET)
Received: (qmail 5819 invoked by uid 500); Sat, 16 Dec 2006 23:14:22 +0000
To: Martin Waitz <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

On Sat, Dec 16, 2006 at 11:58:10PM +0100, Martin Waitz wrote:
> On Sat, Dec 16, 2006 at 01:07:04PM -0800, Junio C Hamano wrote:
> > Sven Verdoolaege <skimo@kotnet.org> writes:
> > > On Sat, Dec 16, 2006 at 10:32:36AM -0800, Junio C Hamano wrote:
> > >> I suspect the hardest part is "rev-list --objects" (now most of
> > >> it is found in revision.c).  [..]  But I think the updated
> > >> code needs to know that "link" needs to be unwrapped and
> > >> contained "commit" needs to be injected back to the ancestry
> > >> walking machinery.
> 
> Well, I already got to the point of using the commit directly,
> instead of any link object.

I think Junio is simply refering to the type of the object as represented
in a tree and that the value would indeed just be the commit hash, as in
your implementation.

