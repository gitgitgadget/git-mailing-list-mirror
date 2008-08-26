From: Al Viro <viro@hera.kernel.org>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 18:55:48 +0000
Message-ID: <20080826185548.GA7559@hera.kernel.org>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <1219764860.4471.13.camel@gaara.bos.redhat.com> <1219766398.7107.87.camel@pmac.infradead.org> <alpine.LFD.1.10.0808260959000.3363@nehalem.linux-foundation.org> <20080826180926.GA25711@isilmar.linta.de> <alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
	Kristian =?iso-8859-1?Q?H=F8gsberg?= <krh@redhat.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	users@kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 21:01:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY3mK-0001Rr-Uo
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 21:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758166AbYHZS7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 14:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758913AbYHZS7G
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 14:59:06 -0400
Received: from hera.kernel.org ([140.211.167.34]:50006 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757976AbYHZS7E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 14:59:04 -0400
Received: from hera.kernel.org (IDENT:U2FsdGVkX19Ihj7H9nwOMcY32mBvs1vErQGCVYam+Pc@localhost [127.0.0.1])
	by hera.kernel.org (8.14.2/8.14.2) with ESMTP id m7QItnFx010172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Aug 2008 18:55:49 GMT
Received: (from viro@localhost)
	by hera.kernel.org (8.14.2/8.13.1/Submit) id m7QItm1d010171;
	Tue, 26 Aug 2008 18:55:48 GMT
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808261114070.3363@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.93.3/8093/Tue Aug 26 16:01:30 2008 on hera.kernel.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY
	autolearn=ham version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on hera.kernel.org
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0 (hera.kernel.org [127.0.0.1]); Tue, 26 Aug 2008 18:55:50 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93798>

On Tue, Aug 26, 2008 at 11:19:28AM -0700, Linus Torvalds wrote:
> but the FACT is that git-1.6.0 can work either way. So the people who 
> complain about having lost git-xyzzy are the ones that are being stupid. 
> 
> At least the ones who complained about "git-<tab><tab>" being scary had a 
> _point_.

Well, to be fair, "man git-add for git add is rather unconventional" is
a valid point...

FWIW, personally I couldn't care less as long as manpages *are* there and
we do not end up with something like "oh, just use info / html / some other
weird crap; manpages are not suitable(tm), dontcha know"
