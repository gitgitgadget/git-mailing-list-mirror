From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH gitk 0/4] gitk support for git log -L
Date: Sun, 18 Aug 2013 21:54:57 +1000
Message-ID: <20130818115456.GA6772@iris.ozlabs.ibm.com>
References: <cover.1370806329.git.trast@inf.ethz.ch>
 <874nblpamj.fsf@linux-k42r.v.cablecom.net>
 <874nbdnomj.fsf@hexa.v.cablecom.net>
 <51F6CB7D.1070806@web.de>
 <87siyu98cq.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Aug 18 13:55:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB1Zo-00030v-SH
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 13:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324Ab3HRLzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 07:55:11 -0400
Received: from ozlabs.org ([203.10.76.45]:56968 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754194Ab3HRLzK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 07:55:10 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id DC8F82C0270; Sun, 18 Aug 2013 21:55:07 +1000 (EST)
Content-Disposition: inline
In-Reply-To: <87siyu98cq.fsf@linux-k42r.v.cablecom.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232476>

Hi Thomas,

On Wed, Jul 31, 2013 at 03:17:41PM +0200, Thomas Rast wrote:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
> > Am 29.07.2013 21:37, schrieb Thomas Rast:
> >> Thomas Rast <trast@inf.ethz.ch> writes:
> >> 
> >>> Thomas Rast <trast@inf.ethz.ch> writes:
> >>>
> >>>> Now that git log -L has hit master, I figure it's time to discuss the
> >>>> corresponding change to gitk.
> >>>
> >>> Paul, any news on this?  Any chance we can get it into the next release,
> >>> since that will also be the first release to ship with 'git log -L'?
> >> 
> >> Jens pointed out privately that the handling of unstuck -L options is
> >> unfortunate, to put it mildly.  I'll send a reroll.
> >
> > But as soon as that is fixed I'd really like to see this applied, as
> > I think gitk is the perfect tool to show history information.

One thing I worry about is having gitk storing in memory not just the
history graph but also all the diffs (assuming I have understood
correctly what you're doing).  Gitk's memory consumption is already
pretty large.  However, I can't see an alternative at this point.

> Unfortunately it's turning out to be harder than I hoped.  gitk runs the
> arguments through git-rev-parse, which only knows that -n gets an
> unstuck argument.  Consequently, gitk accepts an unstuck -n but only
> stuck forms of -S and -G.

Excuse my ignorance, but what do you mean by "stuck" vs. "unstuck"?

Thanks,
Paul.
