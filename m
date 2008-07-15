From: Petr Baudis <pasky@suse.cz>
Subject: Re: Closing the merge window for 1.6.0
Date: Tue, 15 Jul 2008 11:20:23 +0200
Message-ID: <20080715092023.GO10151@machine.or.cz>
References: <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org> <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org> <7vabgqsc37.fsf@gitster.siamese.dyndns.org> <7vtzetjbif.fsf@gitster.siamese.dyndns.org> <7vzlokhpk7.fsf@gitster.siamese.dyndns.org> <20080714085555.GJ32184@machine.or.cz> <alpine.DEB.1.00.0807141256310.8950@racer> <20080714124109.25414.qmail@06d015ec9c6744.315fe32.mid.smarden.org> <alpine.LFD.1.10.0807141351540.12484@xanadu.home> <7v3amcgujd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Gerrit Pape <pape@smarden.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 11:21:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIgit-0007Pd-WA
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 11:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448AbYGOJU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 05:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754289AbYGOJU2
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 05:20:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47800 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754364AbYGOJU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 05:20:26 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 0FB601E4C021; Tue, 15 Jul 2008 11:20:23 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v3amcgujd.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88544>

On Mon, Jul 14, 2008 at 12:00:54PM -0700, Junio C Hamano wrote:
> But as the upstream, we have our own deprecation schedule.  We should of
> course plan carefully not to harm existing users of our releases, but
> frankly speaking, 18 months since 1.4.4.4 was tagged (early January 2007)
> is an eternity in git timescale.  Maybe we will slow down someday, and
> this 18-month is not a set-in-stone rule in any way, but at this point
> even without the packfile format issues, I personally think anything
> before 1.5.0 is irrelevant --- maybe they are interesting as historical
> curiosities, but not more than that.

Really, I think this is should be put into certain perspective:

	(i) This change is special since it affects client-server
	compatibility in bare repositories. AFAIK, none of the others
	you mention does this.

	(ii) The CRC checking is perhaps quite an improvement, but I
	don't think it is critical-to-have-just-now.

	(iii) Most importantly, this is not about waiting another few
	years for Debian to catch up, since the next stable release
	should really be upcoming rather soon:

		http://debian-community.org/LennyReleaseSchedule/

	(iv) These problems do not concern people who are currently
	_actively_ _working_ with Git; these people hopefully do not
	use 1.4 willingly and already use Git from backports.org.
	This is about user experience for casual users who are quite
	possibly interested only in read-only tracking of upstream
	using Git - these people will likely use default Debian Git
	version and that is okay, because frankly, for them, the
	1.5 improvements do not really matter much. This is also
	large class of prospective future real Git users and we might
	not want to ruin Git's reputation in their eyes.

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
