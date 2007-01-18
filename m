From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] prune: --expire=seconds
Date: Thu, 18 Jan 2007 14:32:58 -0800
Message-ID: <7vy7o0klt1.fsf@assigned-by-dhcp.cox.net>
References: <20070118171830.GA13521@moooo.ath.cx>
	<20070118172408.GG15428@spearce.org>
	<20070118174244.GA14287@moooo.ath.cx>
	<20070118175134.GH15428@spearce.org>
	<20070118222919.GA22060@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 18 23:33:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7fod-0002xA-Hb
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 23:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbXARWdA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 17:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbXARWdA
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 17:33:00 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:34596 "EHLO
	fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932602AbXARWc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 17:32:59 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070118223259.BVJK7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Thu, 18 Jan 2007 17:32:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id CmY41W01D1kojtg0000000; Thu, 18 Jan 2007 17:32:05 -0500
To: Matthias Lederhofer <matled@gmx.net>
cc: git@vger.kernel.org
In-Reply-To: <20070118222919.GA22060@moooo.ath.cx> (Matthias Lederhofer's
	message of "Thu, 18 Jan 2007 23:29:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37144>

Matthias Lederhofer <matled@gmx.net> writes:

> This option specifies the minimum age of an object before it
> may be removed by prune.  The default value is 2 hours and
> may be changed using gc.pruneexpire.
>
> Signed-off-by: Matthias Lederhofer <matled@gmx.net>
> ---
> Shawn O. Pearce <spearce@spearce.org> wrote:
>> If you are going to implement this I would suggest making the default
>> age 2 hours and allow the user to configure it from a gc.pruneexpire
>> configuration option, much like gc.reflogexpire.
>
> Here it is, I've set the default value to 2 hours as you suggested.
> Any other comments if the default should be a value >0 or 0 to keep
> the old behaviour?

I am not sure if this is needed, as Shawn explained earlier
rounds of loose-objects safety work.

If this is something we would want, it might make sense if we
allowed "prune --expire='1.day'" syntax ;-).
