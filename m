From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: fill in gitweb configuration by Makefile
Date: Mon, 31 Jul 2006 08:55:57 +0200
Organization: At home
Message-ID: <eak9hf$hv2$1@sea.gmane.org>
References: <20060730223754.GA16364@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Jul 31 08:56:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7Rh1-0005Sx-SP
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 08:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWGaGz4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 02:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWGaGz4
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 02:55:56 -0400
Received: from main.gmane.org ([80.91.229.2]:59340 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932151AbWGaGz4 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 02:55:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G7Rgt-0005Rc-1F
	for git@vger.kernel.org; Mon, 31 Jul 2006 08:55:51 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 08:55:51 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 08:55:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24495>

Martin Waitz wrote:

>  gitweb/{gitweb.cgi => gitweb.pl} |   15 +++++++--------
[...]
> diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.pl
> similarity index 100%
> rename from gitweb/gitweb.cgi
> rename to gitweb/gitweb.pl
> index 243a2921f849568260e848201d238b3b9fe7e1f2..8e05c335f801d4c52a9b348fa56fccfae36ce621 100755
> --- a/gitweb/gitweb.cgi
> +++ b/gitweb/gitweb.pl

Shouldn't we use .perl suffix, i.e. gitweb.perl, like almost all
other Perl files in git distribution (the exception is 
Documentation/sort_glossary.pl which never get installed).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
