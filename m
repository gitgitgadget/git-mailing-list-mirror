From: Martin Langhoff <martin@catalyst.net.nz>
Subject: Re: [offtopic?] xdelta patch format wrapper
Date: Wed, 13 Feb 2008 17:13:20 +1300
Message-ID: <47B26E60.70005@catalyst.net.nz>
References: <47B24D8A.5090703@catalyst.net.nz> <7vy79py1it.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jmacd@cs.berkeley.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 05:14:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP90V-0000Ux-U9
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 05:14:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753769AbYBMEN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 23:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754710AbYBMEN3
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 23:13:29 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:34968 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690AbYBMEN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 23:13:28 -0500
Received: from 121-73-4-156.cable.telstraclear.net ([121.73.4.156] helo=[192.168.0.94])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <martin@catalyst.net.nz>)
	id 1JP8zp-0000pR-IT; Wed, 13 Feb 2008 17:13:21 +1300
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <7vy79py1it.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73743>

Junio C Hamano wrote:
> If you want to reuse that much of git

Wondering about the confusion over this. When I talk about using xdelta,
it's not the implementation in git. I intend to ship this xdelta.exe
http://evanjones.ca/software/xdelta-win32.html (for Windows users at
least!).

What I am sounding out is writing a wrapper written in PHP (I'd write it
in Perl, but we're already shipping the PHP interpreter) that does all
the parsing of the file, splits out the actual "xdelta" blobs and calls
xdelta.exe to apply them to the relevant files.

Someone more talented than me would write it in perfectly portable C so
that on day one works on Win32, OSX, unices and linuces. I can't so I'll
look like a wimp but I'll deliver something workable ;-) But there's no
reason the PHP or Perl implementation can't be considered a working
prototype for a subsequent C version.

Specially if the file format makes sense. And we've been complaining
about problems and ambiguities in the unified diff header. So... I'll
rephrase my question

   "What would a unified diff header that didn't suck look like?"

(Ah, can't find the threads where the ambiguities of diff headers were
discussed. Alas, the Google Gods aren't with me today.)

cheers,



m
-- 
