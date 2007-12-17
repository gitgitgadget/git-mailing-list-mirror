From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: git gui blame utf-8 bugs
Date: Mon, 17 Dec 2007 08:50:51 +0100
Message-ID: <20071217075050.GA9927@pvv.org>
References: <20071212091744.GA5377@pvv.org> <20071214064709.GH14735@spearce.org> <m3k5nhqwkn.fsf@roke.D-201>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 08:51:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Akx-0004ot-Ne
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 08:51:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759369AbXLQHu4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 02:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757947AbXLQHu4
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 02:50:56 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:46992 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755837AbXLQHuz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 02:50:55 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.60)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1J4AkV-0003XX-4N; Mon, 17 Dec 2007 08:50:51 +0100
Content-Disposition: inline
In-Reply-To: <m3k5nhqwkn.fsf@roke.D-201>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68513>

On Fri, Dec 14, 2007 at 04:39:59AM -0800, Jakub Narebski wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Finn Arne Gangstad <finnag@pvv.org> wrote:
> > > git gui has some utf-8 bugs:
> > 
> > It has several.  :-)
> >  
> > > If you do git gui blame <file>, and the file contains utf-8 text,
> > > the lines are not parsed as utf-8, but seemingly as iso-8859-1 instead.
> > 
> > Right.  git-gui is keying off the environment setting for LANG, so I
> > guess its set to iso-8859-1 on your system but you are working with a
> > [...]

Setting LANG does not seem to have any effect at all (neiher for file
contents, aurhor or commit messages).

LANG=en_US.UTF-8 git gui blame dir.c -> same
LANG=utf-8 git gui blame dir.c -> same

- Finn Arne
