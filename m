From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: Re: [PATCH 00/11] More preparatory work for multiparent tree-walker
Date: Thu, 13 Feb 2014 18:05:57 +0400
Organization: Marine Bridge & Navigation Systems
Message-ID: <20140213140557.GA4839@tugrik.mns.mnsspb.ru>
References: <cover.1391794688.git.kirr@mns.spb.ru>
 <xmqqeh3aqyq6.fsf@gitster.dls.corp.google.com>
 <20140211081716.GA4455@tugrik.mns.mnsspb.ru>
 <xmqq61olpgjd.fsf@gitster.dls.corp.google.com>
 <xmqqr478nsyo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 13 15:04:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDwtk-0008DE-Gl
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 15:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbaBMOEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 09:04:11 -0500
Received: from mail.mnsspb.ru ([84.204.75.2]:40286 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbaBMOEK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 09:04:10 -0500
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1WDwtc-000180-Td; Thu, 13 Feb 2014 18:04:09 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.72)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1WDwvN-0001GH-L6; Thu, 13 Feb 2014 18:05:57 +0400
Content-Disposition: inline
In-Reply-To: <xmqqr478nsyo.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242065>

On Wed, Feb 12, 2014 at 09:25:51AM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Kirill Smelkov <kirr@mns.spb.ru> writes:
> >
> >> Sorry for the confusion. Could you please do the following:
> >>
> >> Patches should be applied over to ks/tree-diff-walk
> >> (74aa4a18). Before applying the patches, please cherry-pick
> >>
> >>     c90483d9    (tree-diff: no need to manually verify that there is no
> >>                  mode change for a path)
> >>
> >>     ef4f0928    (tree-diff: no need to pass match to
> >>                  skip_uninteresting())
> >>
> >> into that branch, and drop them from ks/combine-diff - we'll have one
> >> branch reworking the diff tree-walker, and the other taking advantage of
> >> it for combine-diff.
> >
> > As long as that does not lose changes to tests and clean-ups, I'm
> > fine with that direction.  For example, I do not know if you want to
> > lose e3f62d12 (diffcore-order: export generic ordering interface,
> > 2014-01-20), which is part of the combine-diff topic.
> 
> Ahh, sorry, I misread the "drop" as "salvage these two and drop the
> rest".  The new series does apply cleanly on a commit in master..pu
> that has both ks/tree-diff-walk and ks/combine-diff, and the latter
> is not yet in 'next' so we are free to reorganize.
> 
> Let me flip the latter topic around, also queue these updates and
> push the result out on 'pu'.
> 
> Thanks.

Thank you. As we've managed to apply this to pu, I've send the final
speedup patches. Please review them as time permits.

Thanks beforehand,
Kirill
