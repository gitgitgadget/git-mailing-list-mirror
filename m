From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 0/5] git p4: fix branch detection with --use-client-spec
Date: Sun, 12 Aug 2012 10:04:49 -0400
Message-ID: <20120812140449.GA5635@padd.com>
References: <CANWnr5aqswATTM9_Zyw=w_x01=e8CqoCsn0Ybee0XvGSJ3F_yw@mail.gmail.com>
 <20120811165143.GA2004@padd.com>
 <7v4no8hgc0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthew Korich <matthew@korich.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 16:04:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0Ymo-00073O-TU
	for gcvg-git-2@plane.gmane.org; Sun, 12 Aug 2012 16:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117Ab2HLOEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Aug 2012 10:04:53 -0400
Received: from honk.padd.com ([74.3.171.149]:59214 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752068Ab2HLOEx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2012 10:04:53 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 3CAB41E43;
	Sun, 12 Aug 2012 07:04:52 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 3EB44314C3; Sun, 12 Aug 2012 10:04:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v4no8hgc0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203309>

gitster@pobox.com wrote on Sat, 11 Aug 2012 21:41 -0700:
> Pete Wyckoff <pw@padd.com> writes:
> 
> > matthew@korich.net wrote on Fri, 10 Aug 2012 12:14 -0700:
> >> Using git p4 on git version 1.7.12.rc2 has path issues. Standard
> >> clone/sync ops apparently place detected master and branches on
> >> independent and parallel directory structures instead of git branches.
> >> See http://stackoverflow.com/q/11893688/1588831 for a full demo of the problem.
> >
> > Thank you for the detailed report.  It is a bug in 1.7.12-rc2.
> 
> Do you mean "a feature that was present in 1.7.11 without this bug
> was broken when used with 1.7.12-rc2"?  Or do you mean "this bug
> exists in 1.7.12-rc2 (older versions may or may not have it, but I
> am stressing that it is not fixed)"?
> 
> The description for [PATCH 5/5] blames v1.7.9-rc0~4^2~1, which tells
> me it is the latter.  And if that were the case, and if this were in
> the area of the system I oversee, I wouldn't push it to the upcoming
> release at this late in the cycle, when I do not know what other
> things it might break while fixing this bug (in other words, a fix
> to an old bug is not an execuse to introduce a regression).
> 
> But git-p4 is not in my area, so if you meant this should go in the
> upcoming 1.7.12 release, I'll queue them directly on 'master'.
> 
> Please tell me what your preference is.

Good point about "already released bugs".  I confirmed it was
broken in 1.7.11 too, so there's no reason to rush this fix into
1.7.12.  If you could queue it up in pu, that would be great.
Otherwise I'll resubmit after the upcoming release.

Thanks,

		-- Pete
