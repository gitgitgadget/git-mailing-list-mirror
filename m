From: Lukasz Palczewski <l.palczewski@prevac.pl>
Subject: Re: Restart submodule update --recursive
Date: Fri, 29 Oct 2010 07:28:16 +0000 (UTC)
Message-ID: <loom.20101029T091828-728@post.gmane.org>
References: <loom.20101028T090353-376@post.gmane.org> <201010281235.14313.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 29 09:28:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBjO8-0003mE-MN
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 09:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755867Ab0J2H2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 03:28:32 -0400
Received: from lo.gmane.org ([80.91.229.12]:58950 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755112Ab0J2H2a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 03:28:30 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PBjNy-0003h6-Uo
	for git@vger.kernel.org; Fri, 29 Oct 2010 09:28:26 +0200
Received: from ayr35.internetdsl.tpnet.pl ([83.18.121.35])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 09:28:26 +0200
Received: from l.palczewski by ayr35.internetdsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 09:28:26 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 83.18.121.35 (Mozilla/5.0 (Windows; U; Windows NT 5.1; pl; rv:1.9.2.12) Gecko/20101026 Firefox/3.6.12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160312>

Hi Johan,

Johan Herland writes:

> [...]
> You could for example try something like (all on one line):
> 
> git submodule foreach --recursive "git fetch && git stash && git 
> checkout $sha1 && git stash pop; true"
> 
> ...Johan
> 

Thanks for the suggestion. Using s script in a command good idea, but it will
work only for the local changes (I think), so I am continuing with a second
suggestion from Jonathan. If it works, it would not matter what error arises.

Lukasz Palczewski
