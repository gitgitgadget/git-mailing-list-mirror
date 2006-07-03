From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git-fmt-merge-msg a builtin
Date: Mon, 3 Jul 2006 17:45:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607031731550.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607031530380.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060703171751.2ed33220.tihirvon@gmail.com>
 <Pine.LNX.4.63.0607031632290.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060703182621.dbed5b5f.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Jul 03 17:45:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxQcU-0005Ie-8E
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 17:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWGCPpv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 11:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWGCPpv
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 11:45:51 -0400
Received: from mail.gmx.de ([213.165.64.21]:36026 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932078AbWGCPpu (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 11:45:50 -0400
Received: (qmail invoked by alias); 03 Jul 2006 15:45:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 03 Jul 2006 17:45:49 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060703182621.dbed5b5f.tihirvon@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23185>

Hi,

On Mon, 3 Jul 2006, Timo Hirvonen wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > I had in mind that I want to use path-list instead (which is cooking in 
> > the merge-recursive efforts ATM). And there, I would add a flag 
> > needs_payload. Opinions?
> 
> This code is so simple that making the path_list more complex 
> (needs_payload special case?) is not worth it.  I have not looked at the 
> code very closely though and have no idea what I'm talking about :)

Okay. But I'd rather go back to work on merge-recursive, and just reuse 
the path_list struct.

> > > free(NULL) is safe.
> > 
> > Is it? I vaguely remember that I had problems with this on some obscure 
> > platform.
> 
> I don't think so.

Well, after a little Googling, I am more convinced than ever that it is a 
BAD thing to rely on free(NULL) being a NOP.

Ciao,
Dscho
