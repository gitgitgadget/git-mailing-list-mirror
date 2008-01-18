From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Fri, 18 Jan 2008 13:50:40 +0300
Message-ID: <20080118105040.GE14871@dpotapov.dyndns.org>
References: <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Jan 18 11:53:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFoqu-0007DR-C0
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 11:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbYARKxF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jan 2008 05:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbYARKxE
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 05:53:04 -0500
Received: from smtp03.mtu.ru ([62.5.255.50]:63861 "EHLO smtp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323AbYARKxD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 05:53:03 -0500
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id EB6D31870C7A;
	Fri, 18 Jan 2008 13:52:57 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-191-154.pppoe.mtu-net.ru [85.141.191.154])
	by smtp03.mtu.ru (Postfix) with ESMTP id 7EEA51870E46;
	Fri, 18 Jan 2008 13:50:41 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JFoo4-0005SJ-PT; Fri, 18 Jan 2008 13:50:40 +0300
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70995>

On Fri, Jan 18, 2008 at 11:19:21AM +0100, Peter Karlsson wrote:
> Linus Torvalds:
>=20
> > But that's exactly the case he gave - '=E4' vs 'a=A8' are exactly t=
hat:=20
> > different strings (not even characters: the second is actually a=20
> > multi-character) that just look the same.
>=20
> But they are not different strings, they are canonically equivalent a=
s
> far as Unicode is concerned.

There are canonically equivalent, but they are different sequences
of characters as Unicode is concerned. In one case, we have one
character in the other case, we have two characters that canonically
equivalent to the first one.

> They're even supposed to map to the same
> glyph (if the font has an "=E4", it should display it in both cases, =
if
> it has an "a" and a combining diaeresis, it should make up one).

By defition, sequences of characters that are canonically equivalent
are both visual and functional equivalent...

> You cannot do a binary comparison of text to see if two strings are
> equivalent.

Of course, you can't. Who argues otherwise?

> > You try to twist the argument by just claiming that they are the sa=
me
> > "character". They aren't, unless you *define* character to be the
> > same as "glyph".
>=20
> Whereas you are confusing characters and code points.

I am afraid it is you who confuses "characters" with "abstract
characters", there is no place in the standard saying that
"characters" are "abstract characters" only. On contrary, the
term "characters" is used to refer non abstract characters.

Dmitry
