From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] --color-words: Make the word characters configurable
Date: Sat, 3 May 2008 15:23:40 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805031522360.30431@racer>
References: <46dff0320805012128l6cb15e1ekd40f84a9eac724d1@mail.gmail.com>  <1209736766-8029-1-git-send-email-pkufranky@gmail.com>  <alpine.DEB.1.00.0805031501290.30431@racer> <46dff0320805030713r673ea479u37018333c32131bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 16:24:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsIf8-0006mw-Uz
	for gcvg-git-2@gmane.org; Sat, 03 May 2008 16:24:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248AbYECOXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 10:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754182AbYECOXn
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 10:23:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:60457 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752538AbYECOXn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 10:23:43 -0400
Received: (qmail invoked by alias); 03 May 2008 14:23:41 -0000
Received: from dslb-088-067-214-063.pools.arcor-ip.net (EHLO dslb-088-067-214-063.pools.arcor-ip.net) [88.67.214.63]
  by mail.gmx.net (mp044) with SMTP; 03 May 2008 16:23:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Ylzxz8DmYX0TSAeY3iPVTiRmy5ve8kHQ66cK2c3
	u8ZbwVs5BGLKiA
X-X-Sender: gene099@racer
In-Reply-To: <46dff0320805030713r673ea479u37018333c32131bb@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81094>

Hi,

On Sat, 3 May 2008, Ping Yin wrote:

> On Sat, May 3, 2008 at 10:03 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> >  Now, you can specify which characters are to be interpreted as word
> >  characters with "--color-words=A-Za-z", or by setting the config variable
> >  diff.wordCharacters.
> >
> >  Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >  ---
> >
> >         I would have preferred an approach like this.
> >
> >   Documentation/config.txt       |    6 ++++
> >   Documentation/diff-options.txt |    8 ++++-
> >   README                         |    2 +-
> >   diff.c                         |   64 +++++++++++++++++++++++++++++++++++++++-
> >   4 files changed, 77 insertions(+), 3 deletions(-)
> >
> >  diff --git a/Documentation/config.txt b/Documentation/config.txt
> >  index 05bf2df..663d82b 100644
> >  --- a/Documentation/config.txt
> >  +++ b/Documentation/config.txt
> >  @@ -546,6 +546,12 @@ diff.renames::
> >         will enable basic rename detection.  If set to "copies" or
> >         "copy", it will detect copies, as well.
> >
> >  +diff.wordcharacters::
> >  +       This config setting overrides which characters are interpreted as
> >  +       word characters by the --color-words option of linkgit:git-diff[1].
> 
> I think a-zA-Z0-9_ should always be word characters. We can't override 
> them, instead, we just extend them.

No.  That is exactly the artificial-limitation-by-design I do not want.

> >  -"git" can mean anything, depending on your mood.
> >  +"git" cann mean anything, depending on your mood.
> 
> Why replacing can as cann?

Because I am stupid and committed my test case.  Of course, this patch was 
done under time pressure, because I have to leave for the day, like, right 
now.

Ciao,
Dscho
