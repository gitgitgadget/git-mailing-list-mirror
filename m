From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 23:43:30 +0300
Message-ID: <20080121204330.GX14871@dpotapov.dyndns.org>
References: <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095@ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <86r6gbi0pr.fsf@lola.quinscape.zz> <CFF9E74C-4A4C-4E5F-8DA3-662D80095503@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 21:44:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH3Uw-0003NY-GX
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 21:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbYAUUnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 15:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbYAUUnd
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 15:43:33 -0500
Received: from smtp02.mtu.ru ([62.5.255.49]:54787 "EHLO smtp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557AbYAUUnc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 15:43:32 -0500
Received: from smtp02.mtu.ru (localhost [127.0.0.1])
	by smtp02.mtu.ru (Postfix) with ESMTP id 69BDA320C6;
	Mon, 21 Jan 2008 23:43:24 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-188-102.pppoe.mtu-net.ru [85.141.188.102])
	by smtp02.mtu.ru (Postfix) with ESMTP id 22A3C33D63;
	Mon, 21 Jan 2008 23:43:24 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JH3UQ-00081P-3R; Mon, 21 Jan 2008 23:43:30 +0300
Content-Disposition: inline
In-Reply-To: <CFF9E74C-4A4C-4E5F-8DA3-662D80095503@sb.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp02.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71332>

On Mon, Jan 21, 2008 at 11:59:24AM -0500, Kevin Ballard wrote:
> 
> No, it's a question of hashing algorithm. And it's one that's fairly  
> easily solved simply by picking a specific nonambiguous UTF-8 encoding  
> before hashing.

UTF-8 is a *single* encoding, and it maps every Unicode character to
a unique binary representation. So, it is completely nonambiguous.

Dmitry
