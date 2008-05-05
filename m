From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 3/6] --color-words: Fix showing trailing deleted words
 at another line
Date: Mon, 5 May 2008 13:10:26 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805051306160.30431@racer>
References: <1209815828-6548-1-git-send-email-pkufranky@gmail.com>  <1209874815-14411-1-git-send-email-pkufranky@gmail.com>  <1209874815-14411-2-git-send-email-pkufranky@gmail.com>  <1209874815-14411-3-git-send-email-pkufranky@gmail.com> 
 <1209874815-14411-4-git-send-email-pkufranky@gmail.com>  <alpine.DEB.1.00.0805041049150.30431@racer> <46dff0320805040948g2956d724wb41f3eb8651443@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 05 14:11:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JszXL-0002UX-4o
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 14:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbYEEMKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 08:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbYEEMKb
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 08:10:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:48707 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751379AbYEEMKb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 08:10:31 -0400
Received: (qmail invoked by alias); 05 May 2008 12:10:29 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp029) with SMTP; 05 May 2008 14:10:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/OEsARWEbOkg58NO3MchYnqdOGPpqWOYB8XB+nXA
	hhPFuCurf0LHPT
X-X-Sender: gene099@racer
In-Reply-To: <46dff0320805040948g2956d724wb41f3eb8651443@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81274>

Hi,

On Mon, 5 May 2008, Ping Yin wrote:

> On Sun, May 4, 2008 at 5:52 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> >  On Sun, 4 May 2008, Ping Yin wrote:
> >
> >  > This is caused by the unsymmetrical handling of LF in the plus and 
> >  > minus buffer in fn_out_diff_words_aux.
> >
> >  Is it not rather caused by the need to replace non-word-characters 
> >  with LF?
> 
> No, i think this has nothing to do with the replacing 
> non-word-characters with LF.

I know that you _think_ that.  But you do a bad job convincing me (by 
avoiding an explanation).

> >  > Following is original unsymmetrical handling rules where LF 
> >  > represents a LF will be shown there.
> >
> >  I cannot parse this sentence.
> 
> Following is the original unsymmetrical handling rules

I am sorry, but this non-native English speaker still has trouble 
recognizing the meaning in this.

> >  > The second rule causes any word following the trailing plus word 
> >  > will be shown in a different line.
> >
> >  I cannot parse this sentence.
> 
> The second rule causes any word following the trailing plus word to show 
> in a different line with the trailing plus word.

Again, I can only guess that you mean something like this:

	2nd rule: any word after an added word will be shown after a line 
	break.

Again, I am not a native speaker, so IMO it is very important to be clear 
in crucial points such as this one.

Ciao,
Dscho
