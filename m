From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Tue, 22 Jan 2008 02:01:18 +0300
Message-ID: <20080121230118.GF14871@dpotapov.dyndns.org>
References: <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org> <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095@ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <86r6gbi0pr.fsf@lola.quinscape.zz> <CFF9E74C-4A4C-4E5F-8DA3-662D80095503@sb.org> <20080121204330.GX14871@dpotapov.dyndns.org> <A101AC54-F0CF-4C33-8986-CC6B8DD7F17F@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 00:01:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH5eN-00012y-DT
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 00:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758014AbYAUXBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 18:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757940AbYAUXBY
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 18:01:24 -0500
Received: from smtp02.mtu.ru ([62.5.255.49]:51584 "EHLO smtp02.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757775AbYAUXBX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 18:01:23 -0500
Received: from smtp02.mtu.ru (localhost [127.0.0.1])
	by smtp02.mtu.ru (Postfix) with ESMTP id 5A32A33705;
	Tue, 22 Jan 2008 02:01:10 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-188-102.pppoe.mtu-net.ru [85.141.188.102])
	by smtp02.mtu.ru (Postfix) with ESMTP id EAAF333593;
	Tue, 22 Jan 2008 02:01:09 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JH5dm-0008KX-Rz; Tue, 22 Jan 2008 02:01:18 +0300
Content-Disposition: inline
In-Reply-To: <A101AC54-F0CF-4C33-8986-CC6B8DD7F17F@sb.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp02.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71367>

On Mon, Jan 21, 2008 at 03:53:10PM -0500, Kevin Ballard wrote:
> On Jan 21, 2008, at 3:43 PM, Dmitry Potapov wrote:
> 
> >On Mon, Jan 21, 2008 at 11:59:24AM -0500, Kevin Ballard wrote:
> >>
> >>No, it's a question of hashing algorithm. And it's one that's fairly
> >>easily solved simply by picking a specific nonambiguous UTF-8  
> >>encoding
> >>before hashing.
> >
> >UTF-8 is a *single* encoding, and it maps every Unicode character to
> >a unique binary representation. So, it is completely nonambiguous.
> 
> In this case, encoding refers to normalization form,

I thought we spoke about HFS+, and it does not use any normalization
form, because normalization should produce binary identitical strings
for equivalent strings and HFS+ conversion does not. So, it looks
like you redefine both words "encoding" and "normalization" here.

> as other people  
> have used it in the conversation besides me.

All your arguments based on confusion and the fact that some other
people were probably confused does not make your arguments any more
valid.

> I suggest you stop trying to find inconsequential stuff to argue  
> about, especially when a tiny bit of critical thinking would reveal  
> the answer.

IMHO, most of your arguments are inconsequential stuff, so I am not
sure what I am supposed to do about your writings. Probably, it does
not make sense to respond your mails anymore...

As to critical thinking, it definitely reveals that Apple's choice
was far from being. Is it so difficult to accept?

Anyway, if you think that you know better than other how to properly
deal with the problem, why don't you try to actually *do* something
and write some code that works as your propose.

Dmitry
