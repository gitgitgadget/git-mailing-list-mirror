From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [kernel.org users] README and ChangeLog files
Date: Fri, 22 Aug 2008 19:09:52 -0400
Message-ID: <48AF4740.2030202@garzik.org>
References: <48AC6839.7050605@zytor.com> <1219264114.7576.1121.camel@calx> <20080820210733.GA418@smurf.noris.de> <20080820223033.GD18947@flint.arm.linux.org.uk> <alpine.LFD.1.10.0808201552070.3487@nehalem.linux-foundation.org> <1219273792.7576.1146.camel@calx> <alpine.LFD.1.10.0808201622260.3487@nehalem.linux-foundation.org> <1219294266.7576.1180.camel@calx> <20080821125945.GE16634@mit.edu> <7vk5eaez0m.fsf@gitster.siamese.dyndns.org> <20080822082908.GA29475@isilmar.linta.de> <7vej4g92io.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
	Matthias Urlichs <smurf@smurf.noris.de>,
	Theodore Tso <tytso@mit.edu>, "H. Peter Anvin" <hpa@zytor.com>,
	users@kernel.org, git@vger.kernel.org, Russell@hera.kernel.org,
	Matt Mackall <mpm@selenic.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	King <rmk@arm.linux.org.uk>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 01:11:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWfmz-0007pD-Tp
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 01:11:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781AbYHVXK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 19:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754741AbYHVXK0
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 19:10:26 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:43796 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754459AbYHVXKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 19:10:25 -0400
Received: from cpe-069-134-153-115.nc.res.rr.com ([69.134.153.115] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.69 #1 (Red Hat Linux))
	id 1KWflR-0000vD-AG; Fri, 22 Aug 2008 23:09:55 +0000
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <7vej4g92io.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.5 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93395>

Junio C Hamano wrote:
> Maybe we should try to see how hard it would be to issue warnings when
> "git-foo" form is used for builtins before we declare that dashed form is
> deprecated for builtins, and start warning when the deprecation actually
> happens.  As many people on this thread suggested, it would make the
> transition easier.


I would tend to prefer a compatibility package or similar.

My fingers have long learned "git-prefix<tab>" for several commands. 
And Fedora puts so much crap in /usr/bin anyway, I don't see it a big 
deal to have all those names in the directory.

Actually, I bet git-foo, git-bar, and git-blah could all link to the 
same compatibility script, which simply invokes "git $command $args..."

That would be nice.

	Jeff
