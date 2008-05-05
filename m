From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words
 configurable
Date: Mon, 5 May 2008 12:51:21 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805051249520.30431@racer>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>  <1209815828-6548-1-git-send-email-pkufranky@gmail.com>  <1209815828-6548-2-git-send-email-pkufranky@gmail.com>  <1209815828-6548-3-git-send-email-pkufranky@gmail.com> 
 <1209815828-6548-4-git-send-email-pkufranky@gmail.com>  <1209815828-6548-5-git-send-email-pkufranky@gmail.com>  <7vy76rtfns.fsf@gitster.siamese.dyndns.org>  <46dff0320805031732x25286707r991358162046c07c@mail.gmail.com>  <alpine.DEB.1.00.0805041040560.30431@racer>
 <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 05 13:52:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JszF6-0004Ga-7N
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 13:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbYEELv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 07:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbYEELv0
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 07:51:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:43831 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750989AbYEELv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 07:51:26 -0400
Received: (qmail invoked by alias); 05 May 2008 11:51:24 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp029) with SMTP; 05 May 2008 13:51:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19t/HoSy0Bt4EQtml58tKWelkgle/ti1XVeWFTAm5
	DXeZu1YuHPgE6m
X-X-Sender: gene099@racer
In-Reply-To: <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81270>

Hi,

On Mon, 5 May 2008, Ping Yin wrote:

> On Sun, May 4, 2008 at 5:44 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> >  The problem: given two chunks of text, where a word was changed, and a
> >  non-word-character was moved to the next line.  Example:
> >
> >         The quick,
> >         brown fox
> >
> >  vs
> >
> >         The fast
> >         , brown fox
> >
> >  IMHO the layout of the new version should be retained, i.e.
> >
> >         The /quick/fast/
> >         , brown fox
> >
> >  should be shown.
> 
> Why not
> 
>   The <r>quick</r><g>fast</g><r>,</r>
>   <g>,</g>brown fox

I might well be a complete idiot, but your <r></r><something> example is 
way harder for me to read than my example.

And of course your example would still be wrong: the "quick" and the comma 
would not be separated at all.

Ciao,
Dscho
