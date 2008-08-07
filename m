From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git svn rebase - could not detach HEAD
Date: Thu, 7 Aug 2008 10:24:06 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0808071013190.19665@iabervon.org>
References: <f7d8f60b0808062349q92fffb9l33de5550250e4e13@mail.gmail.com>  <7vd4kljnpn.fsf@gitster.siamese.dyndns.org>  <f7d8f60b0808070033g7a322ee4w9147dd51e41850c6@mail.gmail.com>  <20080807074117.GA7648@atjola.homenet>
 <f7d8f60b0808070553o6f709445j9dd036f380763f6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-478476910-1218119046=:19665"
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tony Stubbs <antony.stubbs@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 16:25:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR6Qd-000672-0f
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 16:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbYHGOYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 10:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbYHGOYK
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 10:24:10 -0400
Received: from iabervon.org ([66.92.72.58]:51968 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202AbYHGOYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 10:24:09 -0400
Received: (qmail 23395 invoked by uid 1000); 7 Aug 2008 14:24:06 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 Aug 2008 14:24:06 -0000
In-Reply-To: <f7d8f60b0808070553o6f709445j9dd036f380763f6e@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91585>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-478476910-1218119046=:19665
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 8 Aug 2008, Tony Stubbs wrote:

> >> <manually deleted "untracked file" here>
> >
> > Maybe you're ignoring that file? git clean deletes ignored files only if
> > you use -x/-X.
> >
> > Björn
> >
> 
> That's probably it, I'll try it tomorrow. However, that could be a
> problem. There's ignored files I don't want to keep (build artifacts),
> and there's ignored files I do want to keep (i.e. .metadata).
> Is there a good solution?

There's only a problem if there's some reason you specifically want to not 
keep an ignored file; this is usually only an issue when you're trying to 
merge/rebase with a branch that has it tracked, at which point you have to 
decide whether to add your version and merge or remove your version. 
Ideally, git would tell you when the file that's in the way is ignored, 
which would probably help you know what's going on, but it's tricky to get 
that information there.

	-Daniel
*This .sig left intentionally blank*
--1547844168-478476910-1218119046=:19665--
