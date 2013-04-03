From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: RFC: allowing multiple parallel sequencers
Date: Wed, 3 Apr 2013 16:14:45 -0400
Message-ID: <20130403201445.GD32276@hmsreliant.think-freely.org>
References: <20130402174640.GA14473@neilslaptop.think-freely.org>
 <7v38v8eriz.fsf@alter.siamese.dyndns.org>
 <20130402190651.GA17620@hmsreliant.think-freely.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 03 22:15:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNU5a-000490-5Z
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 22:15:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458Ab3DCUOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 16:14:53 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:41078 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762579Ab3DCUOw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 16:14:52 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1UNU51-0003zg-4m; Wed, 03 Apr 2013 16:14:50 -0400
Content-Disposition: inline
In-Reply-To: <20130402190651.GA17620@hmsreliant.think-freely.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219969>

On Tue, Apr 02, 2013 at 03:06:51PM -0400, Neil Horman wrote:
> On Tue, Apr 02, 2013 at 11:06:28AM -0700, Junio C Hamano wrote:
> > Neil Horman <nhorman@tuxdriver.com> writes:
> > 
> > > 	I've recently started looking into the possibility of having git support
> > > multiple in-progress sequencers, and wanted to solicit opinions for how best to
> > > do it.... The thoughts I had were:
> > >
> > > 1) A per branch sequence directory...
> > > 2) Augment the git-stash command...
> > 
> > 3) A per branch working tree.
> > 
> > That is how I would do this myself, anyway ;-)
> > 
> Not sure I completely follow.  Are you suggesting that all untracked
> files, indexes and meta data in .git be saved during a branch switch?
> 
> Thanks
> Neil
> 
> --
Scratch that, after some digging I located the git-new-workdir script in the
contrib directory, which does what we're talking about here.

Thanks!
Neil

> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
