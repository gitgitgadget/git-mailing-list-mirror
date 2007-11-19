From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git in a Nutshell guide
Date: Mon, 19 Nov 2007 17:05:00 +0100
Organization: At home
Message-ID: <fhsc7b$k4g$1@ger.gmane.org>
References: <1195477504.8093.15.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 17:06:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu98p-0002RQ-Su
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 17:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174AbXKSQFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 11:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752864AbXKSQFt
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 11:05:49 -0500
Received: from main.gmane.org ([80.91.229.2]:43892 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754206AbXKSQFs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 11:05:48 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iu97Z-0008KP-5s
	for git@vger.kernel.org; Mon, 19 Nov 2007 16:05:13 +0000
Received: from abwr246.neoplus.adsl.tpnet.pl ([83.8.241.246])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 16:05:13 +0000
Received: from jnareb by abwr246.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 19 Nov 2007 16:05:13 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwr246.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65458>

Jonas Juselius wrote:

> The guides, including the LaTeX source, are available via gitweb:
> http://git.jonas.iki.fi/gitweb.cgi?p=git_guides.git;a=summary

By the way, the description of this repository (for gitweb) is
"CVS to git migration guide", the same as for CVS2git.git
(shouldn't it be CVS2git_guide.git?).

> First, it seems that it was not entirely clear to everybody that
> it's possible to clone the repository:
> 
>   git clone http://git.jonas.iki.fi/git_guides.git

Thanks.

Perhaps you should have make gitweb.cgi with 
  GITWEB_BASE_URL="http://git.jonas.iki.fi"
then, or configure @git_base_url_list in gitweb_config.perl.

Do I understand correctly that you don't support cloning via git://
protocol?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
