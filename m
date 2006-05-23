From: Ryan Anderson <ryan@michonline.com>
Subject: Re: Make more commands builtin
Date: Tue, 23 May 2006 09:32:55 -0700
Message-ID: <20060523163253.GG31164@h4x0r5.com>
References: <20060523122056.GA5777@bohr.gbar.dtu.dk> <e4uvku$o28$1@sea.gmane.org> <20060523125400.GA11128@bohr.gbar.dtu.dk> <e4v1a0$u6c$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 18:33:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiZoo-00067b-7z
	for gcvg-git@gmane.org; Tue, 23 May 2006 18:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbWEWQdL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 12:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWEWQdL
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 12:33:11 -0400
Received: from h4x0r5.com ([70.85.31.202]:25361 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S1750835AbWEWQdJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 12:33:09 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1FiZoV-000510-Fa; Tue, 23 May 2006 09:32:55 -0700
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <e4v1a0$u6c$1@sea.gmane.org>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20612>

On Tue, May 23, 2006 at 03:05:12PM +0200, Jakub Narebski wrote:
> Peter Eriksen wrote:
> 
> > On Tue, May 23, 2006 at 02:36:54PM +0200, Jakub Narebski wrote:
> >> Peter Eriksen wrote:
> >> 
> >> > Btw.
> >> > 
> >> > I used these commands to produce the patch series:
> >> > 
> >> > git diff --stat -C 24b65a30015aedd..pe/builtin
> >> > git-send-email --no-chain-reply-to --compose \
> >> >                --from=s022018@student.dtu.dk --not-signed-off-by-cc \
> >> >                --quiet \
> >> >                --subject="Make more commands builtin" \
> >> >                --to=git@vger.kernel.org Patches/*
> >> 
> >> I wonder why the patches themselves are not replies to the main/summary
> >> email, i.e. "Make more commands builtin" email...
> > 
> > It seems thay are:
> > 
> > Subject: Make more commands builtin
> > Message-Id: <11483865361243-git-send-email-1>
> > 
> > Subject: [PATCH 1/8] Builtin git-ls-files.
> > Message-Id: <11483865362613-git-send-email-1>
> > In-Reply-To: <11483865361243-git-send-email-1>
> 
> Ahh... I'm reading git mailing list through GMane NNTP interface.
> It would be nice if git-send-email added 'References:' Usenet/news
> header in addition to email one 'In-Reply-To:'.

Things would have worked better if --no-chain-reply-to had *not* been
used, at least for those of us reading via mutt.

I'm still in the process of getting my machines setup after moving, when
I get sorted out, I'll try to look into this.
