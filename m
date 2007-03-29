From: Don Zickus <dzickus@redhat.com>
Subject: Re: git-mailinfo munges the patch?
Date: Thu, 29 Mar 2007 17:53:25 -0400
Message-ID: <20070329215325.GH11029@redhat.com>
References: <7v1wj74xck.fsf@assigned-by-dhcp.cox.net> <20070329205357.GF11029@redhat.com> <7vejn73fqg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 23:55:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX2aB-0006Sg-RO
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 23:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934357AbXC2Vy4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 17:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934358AbXC2Vy4
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 17:54:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55709 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934357AbXC2Vy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 17:54:56 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l2TLsrfk017639;
	Thu, 29 Mar 2007 17:54:53 -0400
Received: from mail.boston.redhat.com (mail.boston.redhat.com [172.16.76.12])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l2TLsrVC004151;
	Thu, 29 Mar 2007 17:54:53 -0400
Received: from drseuss.boston.redhat.com (drseuss.boston.redhat.com [172.16.80.234])
	by mail.boston.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id l2TLsrq5028154;
	Thu, 29 Mar 2007 17:54:53 -0400
Received: from drseuss.boston.redhat.com (localhost.localdomain [127.0.0.1])
	by drseuss.boston.redhat.com (8.13.7/8.13.4) with ESMTP id l2TLrPv1030542;
	Thu, 29 Mar 2007 17:53:25 -0400
Received: (from dzickus@localhost)
	by drseuss.boston.redhat.com (8.13.7/8.13.7/Submit) id l2TLrPbs030541;
	Thu, 29 Mar 2007 17:53:25 -0400
X-Authentication-Warning: drseuss.boston.redhat.com: dzickus set sender to dzickus@redhat.com using -f
Content-Disposition: inline
In-Reply-To: <7vejn73fqg.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43479>

On Thu, Mar 29, 2007 at 02:24:39PM -0700, Junio C Hamano wrote:
> Don Zickus <dzickus@redhat.com> writes:
> 
> > On Thu, Mar 29, 2007 at 01:18:51PM -0700, Junio C Hamano wrote:
> >> I noticed that the new mailinfo when splitting a message into
> >> cover letter and the patch text seems to munge the patch text,
> >> applying the same "if content-type is not there then assume
> >> latin-1 and recode to utf-8" logic that is applied to the commit
> >> log message.  That munging should not be done to the patch text,
> >> and it appears the current code botches it.
> >
> > Ok.  I see what you are saying with the old code.  Sorry about that.  Do
> > you have a sample file that I can play with to test my fix?
> 
> Attached are two files.

Thanks.  I'll play with them later tonight.

Cheers,
Don
