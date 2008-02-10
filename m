From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: [PATCH] gitweb: Make use of the $git_dir variable at sub
	git_get_project_url_list
Date: Sun, 10 Feb 2008 00:46:11 -0200
Message-ID: <20080210024611.GA31577@c3sl.ufpr.br>
References: <1202318112-8223-1-git-send-email-ribas@c3sl.ufpr.br> <20080208041542.GA28336@c3sl.ufpr.br> <7vbq6sm0j3.fsf@gitster.siamese.dyndns.org> <200802081015.39707.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 03:47:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO2E1-0005Rj-A2
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 03:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755391AbYBJCqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 21:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755297AbYBJCqu
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 21:46:50 -0500
Received: from mx.c3sl.ufpr.br ([200.17.202.3]:54952 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043AbYBJCqt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 21:46:49 -0500
Received: from localhost (unknown [189.1.135.222])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 23252700003D4;
	Sun, 10 Feb 2008 00:46:42 -0200 (BRST)
Content-Disposition: inline
In-Reply-To: <200802081015.39707.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73297>

On Fri, Feb 08, 2008 at 10:15:39AM +0100, Jakub Narebski wrote:
> Junio C Hamano wrote:
> > Bruno Cesar Ribas <ribas@c3sl.ufpr.br> writes:
> >> On Wed, Feb 06, 2008 at 11:37:51AM -0800, Jakub Narebski wrote:
> >>> Bruno Ribas <ribas@c3sl.ufpr.br> writes:
> >>>
> >>><snip> 
> >>>
> >>> Good catch (although it wasn't actually a bug).
> >>
> >> Not a bug but makes the code cleaner =)
> > 
> > I think I saw very similar 's|projectroot/$path|$git_dir|' patch
> > recently.  If there are more of the same, I'd rather see all of
> > them in a single patch.
> 
> That's all that it is. Those patches are about places where we read
> file inside repo or get repo config, and there are only two places now: 
> description and cloneurl/URL list.

And (if added) at the owner's place ;)

> 
> -- 
> Jakub Narebski
> Poland

-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
