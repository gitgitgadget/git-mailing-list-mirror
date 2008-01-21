From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 23:30:43 +0300
Message-ID: <20080121203043.GV14871@dpotapov.dyndns.org>
References: <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095@ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 21:32:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH3K4-0007sW-Ip
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 21:32:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585AbYAUUbB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 15:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756591AbYAUUbA
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 15:31:00 -0500
Received: from smtp02.mtu.ru ([62.5.255.49]:57896 "EHLO smtp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757393AbYAUUa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 15:30:59 -0500
Received: from smtp02.mtu.ru (localhost [127.0.0.1])
	by smtp02.mtu.ru (Postfix) with ESMTP id 3D3D32EDD1;
	Mon, 21 Jan 2008 23:30:47 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-188-102.pppoe.mtu-net.ru [85.141.188.102])
	by smtp02.mtu.ru (Postfix) with ESMTP id 7B63E2D668;
	Mon, 21 Jan 2008 23:30:39 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JH3I3-0007yt-9u; Mon, 21 Jan 2008 23:30:43 +0300
Content-Disposition: inline
In-Reply-To: <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp02.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71329>

On Mon, Jan 21, 2008 at 11:43:54AM -0500, Kevin Ballard wrote:
> 
> I agree. Every single problem that I can recall Linus bringing up as a  
> consequence of HFS+ treating filenames as strings is in fact only a  
> problem if you then think of the filename as octets at some point.

At *some* point everything stored in computers is a sequence of octets.
In fact, the whole point of the Unicode standard is to define characters
and how to map each character to a unique number (code points) and then
how to encode this number into sequence of octets.

> If  
> you stick with UTF-8 equivalence comparison the entire time, then  
> everything just works.

There are more than one equivalence comparison. The unicode standard
defines at least two, and for some other purpose you may want to use
some others, but for some reason you are trying to present that to
work with text means to follow only one type of equivalence the entire
time...

Dmitry
