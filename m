From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Fri, 18 Jan 2008 00:27:00 +0300
Message-ID: <20080117212700.GB14088@dpotapov.dyndns.org>
References: <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org> <alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org> <8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org> <alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org> <B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Mark Junker <mjscod@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 17 22:27:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFcGs-0003MY-Ae
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 22:27:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235AbYAQV1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2008 16:27:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754496AbYAQV1F
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jan 2008 16:27:05 -0500
Received: from smtp02.mtu.ru ([62.5.255.49]:53242 "EHLO smtp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752881AbYAQV1D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2008 16:27:03 -0500
Received: from smtp02.mtu.ru (localhost [127.0.0.1])
	by smtp02.mtu.ru (Postfix) with ESMTP id C124730A38;
	Fri, 18 Jan 2008 00:26:57 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-190-40.pppoe.mtu-net.ru [85.141.190.40])
	by smtp02.mtu.ru (Postfix) with ESMTP id 7386B305C5;
	Fri, 18 Jan 2008 00:26:57 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JFcGK-0003mJ-CS; Fri, 18 Jan 2008 00:27:00 +0300
Content-Disposition: inline
In-Reply-To: <478F99E7.1050503@web.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp02.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70929>

On Thu, Jan 17, 2008 at 07:09:43PM +0100, Mark Junker wrote:
> 
> Sorry, but you're using different characters that look the same. But 
> Kevins point was that it's a different thing if you use two characters 
> that look the same or the same character with different encodings.

No, the encoding was the same -- UTF-8. MacOSX converts one sequence of
Unicode characters to *another* sequence, which are canonical equivalent,
but being canonical equivalent does not mean they are the same characters.
In the same way, as being compatible equivalent does not mean being the
same. As well as, being case-insensitive equivalent does not mean being
the same... Do you remember DOS? It stored all filenames in upper-case,
so they original and stored names are case-insensitive equivalent, but
they are not the same!

Dmitry
