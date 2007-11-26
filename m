From: David Kastrup <dak@gnu.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 21:35:56 +0100
Message-ID: <85prxwzqvn.fsf@lola.goethe.zz>
References: <200711252248.27904.jnareb@gmail.com>
	<858x4l2apc.fsf@lola.goethe.zz>
	<alpine.LFD.0.99999.0711261417580.9605@xanadu.home>
	<854pf8243i.fsf@lola.goethe.zz>
	<20071126195750.GD25784@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Nov 26 21:36:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iwkh1-00042z-Nx
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 21:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbXKZUfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 15:35:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755536AbXKZUfy
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 15:35:54 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:43771 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755372AbXKZUfx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Nov 2007 15:35:53 -0500
Received: from mail-in-10-z2.arcor-online.net (mail-in-10-z2.arcor-online.net [151.189.8.27])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 69CC132F249;
	Mon, 26 Nov 2007 21:35:51 +0100 (CET)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-10-z2.arcor-online.net (Postfix) with ESMTP id 56E7E23D2E4;
	Mon, 26 Nov 2007 21:35:51 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-029-090.pools.arcor-ip.net [84.61.29.90])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 2DFD82A2AE9;
	Mon, 26 Nov 2007 21:35:41 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 7577E1C4D3AA; Mon, 26 Nov 2007 21:35:56 +0100 (CET)
In-Reply-To: <20071126195750.GD25784@efreet.light.src> (Jan Hudec's message of
	"Mon, 26 Nov 2007 20:57:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4928/Mon Nov 26 19:10:39 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66114>

Jan Hudec <bulb@ucw.cz> writes:

> On Mon, Nov 26, 2007 at 20:34:25 +0100, David Kastrup wrote:
>> Nicolas Pitre <nico@cam.org> writes:
>> > On Mon, 26 Nov 2007, David Kastrup wrote:
>> >> Get rid of plumbing at the command line level.
>> >
>> > We can't get rid of plumbing.
>> 
>> What about "at the command line level" did you not understand?
>
> Which part of we neither can nor want did you not understant?
>
> The availability of plumbing is really big part of a reason why git is
> so good and has so many scripts and tool built on top of it.

Which is the reason I proposed making the plumbing available at a
scripting level, not at the command line level.

The actual trend we are getting nowadays is locking the porcelaine,
previously available as shell scripts, down into C code, _without_
making use of a reasonable plumbing layer suitable for any scripting at
all.

So the git community at the same time praises shell scripting and
simultanouesly replaces it without even using the available plumbing,
_and_ claims that _both_, exclusive and incompatible approaches, are the
perfect solution.  At the same time.  While fighting the shell
portability fight continuously, on Unix as well as Windows.

I may have a big mouth, but swallowing all of this at once is beyond me.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
