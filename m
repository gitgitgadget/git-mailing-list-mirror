From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words
 configurable
Date: Wed, 7 May 2008 14:10:50 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805071408360.30431@racer>
References: <46dff0320805020726y2592732cj9aef0111e5b2288a@mail.gmail.com>  <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com>  <7v63ttq0y8.fsf@gitster.siamese.dyndns.org>  <46dff0320805041840g1b9362d3u138b9d40cde160f2@mail.gmail.com> 
 <7vprs1ny5e.fsf@gitster.siamese.dyndns.org>  <46dff0320805050510t3bc5fd0eq44e0d58d1bb57629@mail.gmail.com>  <46dff0320805051740o65eee07eqc7073e4fa7996277@mail.gmail.com>  <alpine.DEB.1.00.0805060954470.30431@racer>  <46dff0320805061815k6aca9020g285b09da2bcf29c3@mail.gmail.com>
  <alpine.DEB.1.00.0805071223450.30431@racer> <46dff0320805070519m569d9653ja276412fde135f45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 07 15:12:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtjQw-00016u-78
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 15:11:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbYEGNK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 09:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbYEGNK4
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 09:10:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:44685 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751052AbYEGNKy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 09:10:54 -0400
Received: (qmail invoked by alias); 07 May 2008 13:10:52 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp014) with SMTP; 07 May 2008 15:10:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ZelF26yrZjgB7avyOM4ZlsEuVtnYUseN8jbse9H
	YaKwb+xjRuUu96
X-X-Sender: gene099@racer
In-Reply-To: <46dff0320805070519m569d9653ja276412fde135f45@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81435>

Hi,

On Wed, 7 May 2008, Ping Yin wrote:

> On Wed, May 7, 2008 at 7:24 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >  > So how about this
> >  >
> >  > --color-words={char,punct,word}
> >  >
> >  >   - char: one char one token
> >  >   - punct/word: a token can be either a run of word characters or a
> >  > single punct character.  diff.punctchars is used for punct, and
> >  > diff.wordchars is used for word.
> >
> >  I am rather interested in the semantics, i.e. if you can punch holes into
> >  this 3-class approach.
> >
> >  Bikeshedding comes later ;-)
> 
> Sorry, but i can't parse both sentences, especially Bikeshedding and
> "punch holes into".

"punch holes into": find cases where Junio's proposed algorithm breaks 
down.

"bikeshedding": discussing minor implementation details that are not 
really interesting at this stage.  See also 
http://en.wikipedia.org/wiki/Bikeshedding.

Ciao,
Dscho
