From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Fri, 18 Jan 2008 16:30:24 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0801181626060.817@ds9.cixit.se>
References: <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org>
 <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
 <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org>
 <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com>
 <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org>
 <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org>
 <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org>
 <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org>
 <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <20080118105040.GE14871@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 16:31:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFtBc-0004OG-R7
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 16:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbYARPas convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jan 2008 10:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754744AbYARPas
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 10:30:48 -0500
Received: from ds9.cixit.se ([193.15.169.228]:44858 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292AbYARPaq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 10:30:46 -0500
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m0IFUSZZ030424
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 18 Jan 2008 16:30:29 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id m0IFUOE2030415;
	Fri, 18 Jan 2008 16:30:24 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20080118105040.GE14871@dpotapov.dyndns.org>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Fri, 18 Jan 2008 16:30:29 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71027>

Dmitry Potapov:

> I am afraid it is you who confuses "characters" with "abstract
> characters", there is no place in the standard saying that
> "characters" are "abstract characters" only. On contrary, the term
> "characters" is used to refer non abstract characters.

Perhaps it's just a case of confusion about naming conventions. I tend
to use "character" as a "grapheme cluster", i.e a "user character" (to
the end user, "=E4" and "a"+diaeresis is the same character, no matter =
if
they would display as different glyphs), whereas some people use
"character" as a "code point", which would be more of a "programmer
character". And then there are some people that still use "character"
interchangibly for "bytes" or "code units" (for UTF-16; a pair of
surrogate code units is still only one "code point").

--=20
\\// Peter - http://www.softwolves.pp.se/
