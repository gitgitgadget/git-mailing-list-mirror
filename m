From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] More diff possibilities in gitweb
Date: Sat, 17 Mar 2007 22:51:51 +0100
Organization: At home
Message-ID: <ethnog$cf6$1@sea.gmane.org>
References: <20070317151731.GA32571@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 22:49:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSgmR-0000xk-Gq
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 22:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbXCQVth (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 17:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751845AbXCQVth
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 17:49:37 -0400
Received: from main.gmane.org ([80.91.229.2]:60076 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751149AbXCQVtg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 17:49:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HSgm3-0007Qq-Vf
	for git@vger.kernel.org; Sat, 17 Mar 2007 22:49:15 +0100
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Mar 2007 22:49:15 +0100
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Mar 2007 22:49:15 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42454>

[Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>, git@vger.kernel.org]

Martin Koegler wrote:

> The whole is implemented in JavaScript on the client side (tested with
> IE 6 and Mozilla). On the server side, only the JavaScript file is
> included in the output (see below). 

I'd rather not use JavaScript for that, but perhaps add in the history
view (shortlog, history) selectbox to select commits (for shortlog, and
history of a directory) or versions of a blob/file (history of a file)
like in an "info" view e.g. in MoinMoin wiki:
  http://git.or.cz/gitwiki/GitSurvey?action=info
JavaScript can be used to beautify this like e.g. MediaWiki engine
does:
  http://en.wikipedia.org/w/index.php?title=Darcs&action=history 
(to allow selection of diff only in forward direction).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
