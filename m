From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: merge time
Date: Mon, 30 Jul 2007 23:57:56 +0200
Organization: At home
Message-ID: <f8lmt4$h1t$1@sea.gmane.org>
References: <28948.8052.qm@web51002.mail.re2.yahoo.com> <Pine.LNX.4.64.0707301007020.11330@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 23:58:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFdFt-0002zl-5W
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 23:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968299AbXG3V6R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 17:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968282AbXG3V6R
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 17:58:17 -0400
Received: from main.gmane.org ([80.91.229.2]:33773 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968273AbXG3V6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 17:58:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IFdFl-0004Md-C4
	for git@vger.kernel.org; Mon, 30 Jul 2007 23:58:13 +0200
Received: from host-89-229-8-65.torun.mm.pl ([89.229.8.65])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 23:58:13 +0200
Received: from jnareb by host-89-229-8-65.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 30 Jul 2007 23:58:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-8-65.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54284>

david@lang.hm wrote:

> if someone really wanted to do this, the right answer may be to take the 
> concept of gitk and webify it (think SVG for the graphics and AJAX 
> interfaces to retreive the info as needed). I think this would be a very 
> useful tool, but it would be a lot of work to implement.
> 
> but without the graph showing the commits and how they are related to each 
> other, you really are crippled in your ability to figure out how things 
> are related to each other. Date order just doesn't cut it.

By the way, gitweb at repo.or.cz has graphical log (a la gitk) using
git-browser by Arteem Khodush, which uses JavaScript library for graphics
(creating lines box by box) and a bit of AJAX-ism.

I was thinking about using "template" PNG with transparency and colored
boxes to have lighter than git-browser graphical history in gitweb, but...

By the way, you can try to add --topo-order support to gitweb, although I'm
not sure if it would do what you want.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
