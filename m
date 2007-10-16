From: Petr Baudis <pasky@suse.cz>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 01:09:53 +0200
Message-ID: <20071016230952.GA18099@machine.or.cz>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu> <20071016070421.GE13801@spearce.org> <11F85069-1013-4685-9D56-C53F0F8231BF@MIT.EDU> <4714F2CA.5000509@op5.se> <20071016174026.GA506@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Michael Witten <mfwitten@MIT.EDU>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Wed Oct 17 01:10:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhvY5-0002dm-Lj
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 01:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbXJPXJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 19:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752833AbXJPXJz
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 19:09:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42644 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752560AbXJPXJy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 19:09:54 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 132EB5A451; Wed, 17 Oct 2007 01:09:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071016174026.GA506@uranus.ravnborg.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61275>

On Tue, Oct 16, 2007 at 07:40:26PM +0200, Sam Ravnborg wrote:
> Tabs should be used for indent and not general alignment.
> 
> Consider:
> <tab>if (some long condition that
> <tab>....&& spans two lines) {
> <tab><tab>my_private_printf("bla bla bla"
> <tab><tab>.................."more bla bla\n");
> <tab><tab>}
> 
> This will look good and align "more bla bla\n" as
> intended no matter your tab setting.
> But replacing the 8 spaces with a tab will
> cause it to look bad.

I'd so much love to have this and sometimes do this even manually, but
does anyone have an idea how to make vim do this for me? I never got
around to investigate this in depth or possibly make a patch...

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
