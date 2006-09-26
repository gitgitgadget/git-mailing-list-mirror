From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: tree view: eliminate redundant "blob"
Date: Tue, 26 Sep 2006 22:31:58 +0200
Organization: At home
Message-ID: <efc2no$eti$2@sea.gmane.org>
References: <efapsl$e65$1@sea.gmane.org> <20060926201433.46979.qmail@web31810.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Sep 26 22:35:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSJeU-0002S1-So
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 22:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWIZUff (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 16:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWIZUff
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 16:35:35 -0400
Received: from main.gmane.org ([80.91.229.2]:26540 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964794AbWIZUfe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Sep 2006 16:35:34 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1GSJdu-0002K2-D1
	for git@vger.kernel.org; Tue, 26 Sep 2006 22:35:03 +0200
Received: from host-81-190-26-96.torun.mm.pl ([81.190.26.96])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Sep 2006 22:35:02 +0200
Received: from jnareb by host-81-190-26-96.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 26 Sep 2006 22:35:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-26-96.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27820>

Luben Tuikov wrote:

> Jakub,
> 
> I understand your argument completely.  Underlining/coloring/etc
> entities which are "links" themselves was very cool circa 1993 when
> I took an HTML course (NSA Mosaic or rather...), transitioning from
> "gopher" to the WWW.
> 
> Over the years I've seen a transition where web content is more and
> more context sensitive, i.e. everything you can see is in some way
> "clickable".  Be it letters, words, sentences, graphical objects of
> some sort, etc.  If you could imagine: any web content being a "wiki
> on steroids".
>
> Generally, this WEB Development argument goes as follows:
>     "There is no reason for anything to not be clickable."
> 
> Thus, I like the fact that gitweb is on the forefront of WEB development.
> We should keep it like that.

This is example of where forefront has it wrong. I'm all for "list" entry
to be link to default view, but I'm all against removing clearly marked
link to "plain"/"tree" view.

And "invisible links" _especially_ if the link is not convenience only
(i.e. it is not provided clearly as link somewhere else) is so called
"mystery meat navigation" and is one of the most common mistakes in
web development.

And is not as if "plain |" takes much space...
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
