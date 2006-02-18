From: Greg KH <greg@kroah.com>
Subject: Re: diffstat wierdness with 'git format-patch' output
Date: Fri, 17 Feb 2006 16:34:03 -0800
Message-ID: <20060218003403.GA12278@kroah.com>
References: <20060214055425.GA32261@kroah.com> <20060214055648.GA592@kroah.com> <7vveviv5d1.fsf@assigned-by-dhcp.cox.net> <20060214063420.GA11851@kroah.com> <20060214064256.GA19667@kroah.com> <20060214065224.GA20541@kroah.com> <7vhd72v2jp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 01:34:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAG3U-0003K0-08
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 01:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWBRAeL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 19:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbWBRAeL
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 19:34:11 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:42395
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751079AbWBRAeK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Feb 2006 19:34:10 -0500
Received: from press.kroah.org ([192.168.0.25] helo=localhost)
	by aria.kroah.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.54)
	id 1FAG32-0003XP-CW; Fri, 17 Feb 2006 16:34:04 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhd72v2jp.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16378>

On Mon, Feb 13, 2006 at 11:10:18PM -0800, Junio C Hamano wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > Hm, git-send-email doesn't see this, so it doesn't get sent out if you
> > use that tool.
> 
> And people are very likely to remove it by hand.
> 
> Another possibility would be to use "git apply --numstat" and
> add numbers up in your script, but that would not give you a
> nice graph output either X-<.
> 
> I'd say if you really care we should just remove those two
> lines, and remember I am _very_ receptive from such suggestion
> from prominent kernel people.

Hm, in thinking about this some more, I realized that it only requires
me to change my script to generate the emails for Linus to pull from a
tiny bit, making this whole thing not a bit deal at all.

Thanks a lot for being so receptive, if I have further problems with it,
I'll let you know.

greg k-h
