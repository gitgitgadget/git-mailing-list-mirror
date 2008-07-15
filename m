From: Petr Baudis <pasky@suse.cz>
Subject: Re: Closing the merge window for 1.6.0
Date: Tue, 15 Jul 2008 11:09:13 +0200
Message-ID: <20080715090913.GN10151@machine.or.cz>
References: <7vod5kd3im.fsf@gitster.siamese.dyndns.org> <7v3amv1e8n.fsf@gitster.siamese.dyndns.org> <7vprpwhp7t.fsf@gitster.siamese.dyndns.org> <7vlk0ffhw3.fsf@gitster.siamese.dyndns.org> <7vtzf1w0rj.fsf@gitster.siamese.dyndns.org> <7vabgqsc37.fsf@gitster.siamese.dyndns.org> <7vtzetjbif.fsf@gitster.siamese.dyndns.org> <7vzlokhpk7.fsf@gitster.siamese.dyndns.org> <20080714085555.GJ32184@machine.or.cz> <7vtzesff91.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 11:10:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIgY6-0003mP-3a
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 11:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049AbYGOJJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 05:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754013AbYGOJJR
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 05:09:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40974 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645AbYGOJJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 05:09:16 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 68A0C393BEB9; Tue, 15 Jul 2008 11:09:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vtzesff91.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88543>

On Mon, Jul 14, 2008 at 12:16:26PM -0700, Junio C Hamano wrote:
> Yeah, I think git-repack, git-gc, git-pack-objects and git-index-pack on
> the server side need a knob to tell it to stay conservative because the
> repository may be served over dumb protocols to avoid this problem.
> 
> That knob could even be called
> 
> 	[repack]
>         	usedeltabaseoffset = false
> 	[pack]
>         	indexversion = 1

Can you please mention this in release notes? Until now, I actually
thought you're speaking about a hypothetical improvement, not a knob we
actually have. :-) (BTW, turning off the usedeltabaseoffset is not
critical at least Debian-wise, and I think that really is the oldest Git
in widespread use.)

Now, there is of course still the issue of default behaviour, but at
least my concern is somewhat eased now. :-)

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
