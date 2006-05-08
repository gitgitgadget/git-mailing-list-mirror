From: Pavel Roskin <proski@gnu.org>
Subject: Re: Implementing branch attributes in git config
Date: Sun, 07 May 2006 21:04:39 -0400
Message-ID: <1147050279.17371.20.camel@dv>
References: <1147037659.25090.25.camel@dv>
	 <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
	 <BAYC1-PASMTP08D42DA222BA9843352CC1AEA80@CEZ.ICE>
	 <Pine.LNX.4.64.0605071751050.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 03:04:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FcuB4-0002ez-37
	for gcvg-git@gmane.org; Mon, 08 May 2006 03:04:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWEHBEn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 May 2006 21:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbWEHBEn
	(ORCPT <rfc822;git-outgoing>); Sun, 7 May 2006 21:04:43 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:63177 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932233AbWEHBEn
	(ORCPT <rfc822;git@vger.kernel.org>); Sun, 7 May 2006 21:04:43 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FcuB0-0000eh-C0
	for git@vger.kernel.org; Sun, 07 May 2006 21:04:42 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FcuAx-0007wk-CY; Sun, 07 May 2006 21:04:39 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605071751050.3718@g5.osdl.org>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19738>

On Sun, 2006-05-07 at 17:55 -0700, Linus Torvalds wrote:
> 
> On Sun, 7 May 2006, sean wrote:
> > 
> > Having magic sections that prepend "branch." seems a bit suspect;
> > why not just be explicit:
> > 
> >   [branch.Origin]
> >       URL = ...
> >       fetch = master
> 
> Exactly because section (and key) names are normally not case sensitive.
> 
> Even the documentation actually talks about "core.fileMode" and "[imap] 
> Folders". 

Make it ["branch.Origin"]

No hardcoded "branch" prepending needed.  The case sensitive name is
still protected by quotes.  This extends trivially to ["user.Linus"] or
["path./src/git.c"] or whatever.

-- 
Regards,
Pavel Roskin
