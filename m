From: Bruno Cesar Ribas <ribas@c3sl.ufpr.br>
Subject: Re: [PATCH] contrib/hooks/post-receive-email:  checks for
	gitweb.description
Date: Mon, 18 Feb 2008 00:46:59 -0300
Message-ID: <20080218034659.GA21776@c3sl.ufpr.br>
References: <1202786746-12890-1-git-send-email-ribas@c3sl.ufpr.br> <m3wspad1xd.fsf@localhost.localdomain> <20080213002439.GA31455@c3sl.ufpr.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 04:47:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQwyj-0001KL-RB
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 04:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757425AbYBRDrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 22:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757126AbYBRDrF
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 22:47:05 -0500
Received: from mx.c3sl.ufpr.br ([200.17.202.3]:33915 "EHLO
	urquell.c3sl.ufpr.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756818AbYBRDrE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 22:47:04 -0500
Received: from localhost (unknown [201.21.136.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: ribas)
	by urquell.c3sl.ufpr.br (Postfix) with ESMTP id 49852700003C3;
	Mon, 18 Feb 2008 00:47:00 -0300 (BRT)
Content-Disposition: inline
In-Reply-To: <20080213002439.GA31455@c3sl.ufpr.br>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74226>

Forgoten?! 8^)
On Tue, Feb 12, 2008 at 10:24:40PM -0200, Bruno Cesar Ribas wrote:
> I can resend with no problem =)
> 
> On Tue, Feb 12, 2008 at 12:17:57AM -0800, Jakub Narebski wrote:
> > Bruno Ribas <ribas@c3sl.ufpr.br> writes:
> > 
> > > -projectdesc=$(sed -ne '1p' "$GIT_DIR/description")
> > > +if [ -f "$GIT_DIR/description" ]; then
> > > +	projectdesc=$(sed -ne '1p' "$GIT_DIR/description")
> > > +else
> > > +	projectdesc=$(git-config gitweb.description)
> > 
> >   +	projectdesc=$(git config gitweb.description)
> > 
> > > +fi
> > >  # Check if the description is unchanged from it's default, and shorten it to
> > >  # a more manageable length if it is
> > >  if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null
> > > -- 
> > > 1.5.4.24.gce08d
> > 
> > (but this can be fixed when applying).
> > 
> > -- 
> > Jakub Narebski
> > Poland
> > ShadeHawk on #git
> > -
> > To unsubscribe from this list: send the line "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> -- 
> Bruno Ribas - ribas@c3sl.ufpr.br
> http://web.inf.ufpr.br/ribas
> C3SL: http://www.c3sl.ufpr.br 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Bruno Ribas - ribas@c3sl.ufpr.br
http://web.inf.ufpr.br/ribas
C3SL: http://www.c3sl.ufpr.br 
