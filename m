From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: unify boolean feature subroutines
Date: Wed, 17 Dec 2008 09:10:28 +0100
Message-ID: <20081217081028.GA3640@machine.or.cz>
References: <7vabawu1ao.fsf@gitster.siamese.dyndns.org> <1229408179-7655-1-git-send-email-kraai@ftbfs.org> <7vmyewqypk.fsf@gitster.siamese.dyndns.org> <20081216142357.GF4529@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 09:11:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCrVb-0000nY-At
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 09:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbYLQIKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 03:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbYLQIKb
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 03:10:31 -0500
Received: from w241.dkm.cz ([62.24.88.241]:57407 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751463AbYLQIKa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 03:10:30 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id A30B1244C024; Wed, 17 Dec 2008 09:10:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081216142357.GF4529@ftbfs.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103312>

Hi,

On Tue, Dec 16, 2008 at 06:23:57AM -0800, Matt Kraai wrote:
> On Tue, Dec 16, 2008 at 01:03:03AM -0800, Junio C Hamano wrote:
> > But a change to the function signature of feature subroutines is not
> > something I'd like to apply while other series that want to add new
> > features are still cooking.  How about doing these two patches as the
> > first thing that goes to 'next' after 1.6.1, and then force other series
> > rebase on top of your change?  Alternatively, we could make you wait until
> > other series do settle in 'next' and then apply your change rebased on
> > them, but I think that is probably less optimal.
> 
> OK, I'll resubmit the patches on top of 'next' once 1.6.1 is
> released.  Thanks for your help,

is it worth keeping them separate? Just a single patch makes more sense
to me, the interface is much nicer in the latter than in the former. :-)

				Petr "Pasky" Baudis
