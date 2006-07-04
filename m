From: Matthias Kestenholz <lists@spinlock.ch>
Subject: Re: git-fetch per-repository speed issues
Date: Tue, 4 Jul 2006 13:18:38 +0200
Message-ID: <20060704111838.GA4285@spinlock.ch>
References: <1151949764.4723.51.camel@neko.keithp.com> <Pine.LNX.4.64.0607031603290.12404@g5.osdl.org> <1151973438.4723.70.camel@neko.keithp.com> <Pine.LNX.4.64.0607032008590.12404@g5.osdl.org> <7vsllinj1m.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0607032039010.12404@g5.osdl.org> <1151987441.4723.110.camel@neko.keithp.com> <44AA4CB0.7020604@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 13:18:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxivW-0003DY-Dg
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 13:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWGDLSo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 07:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWGDLSn
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 07:18:43 -0400
Received: from mail20.bluewin.ch ([195.186.19.65]:20655 "EHLO
	mail20.bluewin.ch") by vger.kernel.org with ESMTP id S1751282AbWGDLSn
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 07:18:43 -0400
Received: from spinlock.ch (81.62.208.146) by mail20.bluewin.ch (Bluewin 7.3.110.2)
        id 449255CA003E99E2; Tue, 4 Jul 2006 11:18:41 +0000
Received: (nullmailer pid 6514 invoked by uid 1000);
	Tue, 04 Jul 2006 11:18:38 -0000
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <44AA4CB0.7020604@op5.se>
X-Editor: Vim http://www.vim.org/
X-Operating-System: GNU/Linux 2.6.17-ga39727f2 (i686)
X-GPG-Fingerprint: 249B 3CE7 E6AE 4A1F F24A  DC44 B546 3304 690B 13F9
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23285>

* Andreas Ericsson (ae@op5.se) wrote:
> Keith Packard wrote:
> >On Mon, 2006-07-03 at 20:40 -0700, Linus Torvalds wrote:
> >
> >
> >>   "And, it's painfully slow, even when the repository is up to date"
> >>
> >>and gave a 17-second time.
> >
> >
> >It's faster this evening, down to 8 seconds using ssh and 4 seconds
> >using git. I clearly need to force use of the git protocol. Anyone else
> >like the attached patch?
> 
> Since it changes the current meaning of ssh+git, I'm not exactly 
> thrilled. However, "git/ssh" or "ssh/git" would work fine for me. The 
> slash-separator could be used to say "fetch over this, push over that", 
> so we can end up with any valid protocol to use for fetches and another 
> one to push over.
> 

If we would do such a thing, we would be probably better off
allowing different URLs for pushing and pulling, because the git and
ssh URLs will only be the same, if the git repositories are located
in the root folder and I suspect that's almost never the case.

	Matthias
