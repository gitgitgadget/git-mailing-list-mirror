From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 23:36:29 +0300
Message-ID: <20080121203629.GW14871@dpotapov.dyndns.org>
References: <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095!@ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 22:09:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH3tf-00044g-T9
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 22:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751527AbYAUVJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 16:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbYAUVJG
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 16:09:06 -0500
Received: from smtp02.mtu.ru ([62.5.255.49]:53503 "EHLO smtp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370AbYAUVJF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 16:09:05 -0500
Received: from smtp02.mtu.ru (localhost [127.0.0.1])
	by smtp02.mtu.ru (Postfix) with ESMTP id 661343517D;
	Tue, 22 Jan 2008 00:07:32 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-188-102.pppoe.mtu-net.ru [85.141.188.102])
	by smtp02.mtu.ru (Postfix) with ESMTP id 514C63561D;
	Tue, 22 Jan 2008 00:03:23 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JH3Nd-00080J-F7; Mon, 21 Jan 2008 23:36:29 +0300
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp02.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71341>

On Mon, Jan 21, 2008 at 10:12:01AM -0800, Linus Torvalds wrote:
> 
> The fact is, text-as-string-of-codepoints (let's make the "codepoints" 
> obvious, so that there is no ambiguity, but I'd also like to make it clear 
> that a codepoint *is* how a Unicode character is defined, and a Unicode 
> "string" is actually *defined* to be a sequence of codepoints, and totally 
> independent of normalization!) is fine.

Code point is a unique numerical value assigned to every Unicode character.
Also, every Unicode character has a uniqie name assigned to it. There are
some other non-unique properties that every Unicode has. So, to say that
a Unicode character is just a code point is not exactly correct, because
the code point is one of properties of a unicode character. But, yes, any
Unicode character can be identified by its code point. So, it is one to
one relation.

Dmitry
