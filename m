From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Make builtin-tag.c use parse_options.
Date: Fri, 09 Nov 2007 14:57:48 +0100
Organization: At home
Message-ID: <fh1p10$nta$1@ger.gmane.org>
References: <473463E0.7000406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 09 14:58:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqUNS-0004yL-5r
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 14:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759741AbXKIN6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 08:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759912AbXKIN6K
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 08:58:10 -0500
Received: from main.gmane.org ([80.91.229.2]:42088 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759830AbXKIN6I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 08:58:08 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IqUMx-0000MH-Jv
	for git@vger.kernel.org; Fri, 09 Nov 2007 13:57:59 +0000
Received: from abvp178.neoplus.adsl.tpnet.pl ([83.8.213.178])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 13:57:59 +0000
Received: from jnareb by abvp178.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 13:57:59 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvp178.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64183>

Carlos Rica wrote:

> +     struct option options[] = {
> +             { OPTION_STRING, 'l', NULL, &list, "pattern", "list tag names",
> +                     PARSE_OPT_OPTARG, NULL, (intptr_t) no_pattern },

> +             OPT_STRING('F', NULL, &msgfile, "file", "message in a file"),

Does it matter that you use OPTION_STRING here and OPT_STRING macro there?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
