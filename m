From: Mike Hommey <mh@glandium.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 20:44:08 +0100
Organization: glandium.org
Message-ID: <20080121194408.GC11763@glandium.org>
References: <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095!@ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Ballard <kevin@sb.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 20:45:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH2Zp-0006a2-II
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 20:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbYAUToc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 14:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbYAUToc
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 14:44:32 -0500
Received: from vuizook.err.no ([85.19.215.103]:54985 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009AbYAUTob (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 14:44:31 -0500
Received: from aputeaux-153-1-83-190.w86-205.abo.wanadoo.fr ([86.205.41.190] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JH2Z8-0006Ul-La; Mon, 21 Jan 2008 20:44:24 +0100
Received: from mh by jigen with local (Exim 4.68)
	(envelope-from <mh@jigen>)
	id 1JH2Yz-0004LA-03; Mon, 21 Jan 2008 20:44:09 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71317>

On Mon, Jan 21, 2008 at 10:12:01AM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 21 Jan 2008, Kevin Ballard wrote:
> > On Jan 21, 2008, at 9:14 AM, Peter Karlsson wrote:
> > > 
> > > I happen to prefer the text-as-string-of-characters (or code points,
> > > since you use the other meaning of characters in your posts), since I
> > > come from the text world, having worked a lot on Unicode text
> > > processing.
> > > 
> > > You apparently prefer the text-as-sequence-of-octets, which I tend to
> > > dislike because I would have thought computer engineers would have
> > > evolved beyond this when we left the 1900s.
> > 
> > I agree. Every single problem that I can recall Linus bringing up as a
> > consequence of HFS+ treating filenames as strings [..]
> 
> You say "I agree", BUT YOU DON'T EVEN SEEM TO UNDERSTAND WHAT IS GOING ON.
> 
> The fact is, text-as-string-of-codepoints (let's make the "codepoints" 
> obvious, so that there is no ambiguity, but I'd also like to make it clear 
> that a codepoint *is* how a Unicode character is defined, and a Unicode 
> "string" is actually *defined* to be a sequence of codepoints, and totally 
> independent of normalization!) is fine.
> 
> That was never the issue at all. Unicode codepoints are wonderful.
> 
> Now, git _also_ heavily depends on the actual encoding of those 
> codepoints, since we create hashes etc, so in fact, as far ass git is 
> concerned, names have to be in some particular encoding to be hashed, and 
> UTF-8 is the only sane encoding for Unicode. People can blather about 
> UCS-2 and UTF-16 and UTF-32 all they want, but the fact is, UTF-8 is 
> simply technically superior in so many ways that I don't even understand 
> why anybody ever uses anything else.

Maybe because it's 1.5 times bigger for any text in chinese, japanese or
korean ?

Mike
