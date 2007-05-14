From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Do not use absolute font sizes
Date: Mon, 14 May 2007 18:53:01 +0200
Organization: At home
Message-ID: <f2a3si$ein$1@sea.gmane.org>
References: <6efbd9b70705071613p23017509qaf9af12c1d14f9cb@mail.gmail.com> <20070509014150.7477.48489.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 18:49:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HndjD-00028p-1I
	for gcvg-git@gmane.org; Mon, 14 May 2007 18:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757011AbXENQsh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 12:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755635AbXENQsh
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 12:48:37 -0400
Received: from main.gmane.org ([80.91.229.2]:33100 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754877AbXENQsg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 12:48:36 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Hndin-0006Wk-91
	for git@vger.kernel.org; Mon, 14 May 2007 18:48:29 +0200
Received: from host-89-229-25-173.torun.mm.pl ([89.229.25.173])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 May 2007 18:48:29 +0200
Received: from jnareb by host-89-229-25-173.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 May 2007 18:48:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-89-229-25-173.torun.mm.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47270>

Petr Baudis wrote:

> Note that this patch actually does change visual look of gitweb in Firefox
> with my resolution and default settings - everything is bigger and I can't
> explain the joy of actually seeing gitweb text that is in _readable_ size;
> also, my horizontal screen real estate feels better used now.

Not everyone has those huge monitors with extreme resultion. For me new
gitweb look uses much to big font, so not very much fits in screen.

I'd remove 

> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
> @@ -1,6 +1,5 @@
>  body {
>         font-family: sans-serif;
> -       font-size: 12px;
>         border: solid #d9d8d1;
>         border-width: 1px;
>         margin: 10px;

chunk
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
