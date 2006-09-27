From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: tree view: hash_base and hash are now context sensitive
Date: Wed, 27 Sep 2006 15:53:42 -0700 (PDT)
Message-ID: <20060927225342.7695.qmail@web31801.mail.mud.yahoo.com>
References: <7v1wpxhkj9.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, ltuikov@yahoo.com
X-From: git-owner@vger.kernel.org Thu Sep 28 00:53:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSiHk-0005n9-9B
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 00:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031184AbWI0Wxp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 18:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031186AbWI0Wxp
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 18:53:45 -0400
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:58737 "HELO
	web31801.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1031184AbWI0Wxo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 18:53:44 -0400
Received: (qmail 7697 invoked by uid 60001); 27 Sep 2006 22:53:42 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=crTyNuTfIJSxNjDWgGBsi+PxXYnp/Z+CO1K0tDnLrtxmTV24OcK0ROET/yE2tmBJ3FlqZ5tSYGT6vPK22Y2a5UgNLZVPG8lrR8onxfrXf6LS/2qszLEjJs2MJ5p/FdeClFNvV6PcN5sYzlPzjzjDaHMxYKELIhvZ0xvNhj4FQ7M=  ;
Received: from [64.215.88.90] by web31801.mail.mud.yahoo.com via HTTP; Wed, 27 Sep 2006 15:53:42 PDT
To: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <7v1wpxhkj9.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27941>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > --- Jakub Narebski <jnareb@gmail.com> wrote:
> >> I think that this need some thinking over. For blob we have two
> >> "base" objects: tree which have specified blob, and commit which
> >> have tree which have specified blob. We might want to specify
> >> that all hash*base are to the commit-ish.
> >
> > Agreed, we should always refer to the commit-ish, for obvious
> > reasons.
> >
> > This patch doesn't make this decision though.  It simply
> > sets hash_base to HEAD if not defined.
> >
> > Now, since "git-ls-tree" works on both commit-ish and
> > tree-ish, we are ok.
> 
> I think so, too.  Jakub?

Status?  I see Jakub hasn't objected, and it is really important
for us to be able to link to "latest" binary blob -- for example
a PDF spec file.

   Luben
