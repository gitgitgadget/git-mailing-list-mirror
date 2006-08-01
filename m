From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Perhaps an obvious cut and paste error.
Date: Tue, 01 Aug 2006 09:23:48 +0200
Organization: At home
Message-ID: <eamvhf$gfr$1@sea.gmane.org>
References: <200607292239.11034.jnareb@gmail.com> <200608010259.13721.jnareb@gmail.com> <7vlkq94325.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Aug 01 09:23:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7obX-0001xg-Il
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 09:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbWHAHXl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 03:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWHAHXk
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 03:23:40 -0400
Received: from main.gmane.org ([80.91.229.2]:62652 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932593AbWHAHXj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Aug 2006 03:23:39 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G7obJ-0001vn-R1
	for git@vger.kernel.org; Tue, 01 Aug 2006 09:23:37 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Aug 2006 09:23:37 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 01 Aug 2006 09:23:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24579>

Junio C Hamano wrote:

> diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
> index 4e79390..a4a46d9 100755
> --- a/gitweb/gitweb.cgi
> +++ b/gitweb/gitweb.cgi
> @@ -1441,7 +1434,7 @@ sub git_summary {
>       my $headlist = git_read_refs("refs/heads");
>       if (defined @$headlist) {
>               git_header_div('heads');
> -             git_heads_body($taglist, $head, 0, 15,
> +             git_heads_body($headlist, $head, 0, 15,
>                              $cgi->a({-href => "$my_uri?" . esc_param("p=$project;a=heads")}, "..."));
>       }
>  
> 

Yes, of course. ACK.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
