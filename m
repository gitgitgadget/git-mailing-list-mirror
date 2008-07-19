From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: "error: non-monotonic index" during fresh linux-2.6.git cloning.
Date: Sat, 19 Jul 2008 23:59:09 +0400
Message-ID: <20080719195909.GA5093@2ka.mipt.ru>
References: <20080719174742.GA4253@2ka.mipt.ru> <7vfxq521ab.fsf@gitster.siamese.dyndns.org> <7v8wvx211n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 19 22:00:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKIbQ-0004Cp-MF
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 22:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752787AbYGST70 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 15:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752307AbYGST70
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 15:59:26 -0400
Received: from relay.2ka.mipt.ru ([194.85.80.65]:55540 "EHLO 2ka.mipt.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752143AbYGST7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 15:59:25 -0400
Received: from 2ka.mipt.ru (localhost [127.0.0.1])
	by 2ka.mipt.ru (8.14.1/8.14.1) with ESMTP id m6JJxAdp002731;
	Sat, 19 Jul 2008 23:59:10 +0400
Received: (from johnpol@localhost)
	by 2ka.mipt.ru (8.14.1/8.12.1/Submit) id m6JJx9FQ002730;
	Sat, 19 Jul 2008 23:59:09 +0400
Content-Disposition: inline
In-Reply-To: <7v8wvx211n.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89130>

Hi Junio.

On Sat, Jul 19, 2008 at 11:15:16AM -0700, Junio C Hamano (gitster@pobox.com) wrote:
> > The repository you are cloning uses pack idx version #2; 1.4.4.4 predates it
> > by a wide margin.
> 
> By the way, Debian folks are very aware of the issue and already has a
> backported material to cut a 1.4.4.5, but I do not know what the release
> schedule for their update is.
> 
> Is it an option for you to update to a more modern version from say
> backports.org?  Everybody using git for anything serious should be using
> 1.5.3 or newer these days.

It is very development test machine, there is no need to use git at all,
it is just a convenient way to get a needed version via 'git clone; git reset'.

I posted it so it would be stored in archive, that old enough git
version does not work with recent trees, so one should upgrade if this
error occures.

-- 
	Evgeniy Polyakov
