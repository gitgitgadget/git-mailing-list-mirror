From: Jakub Narebski <jnareb@gmail.com>
Subject: =?iso-8859-7?b?UmU6IFtQQVRDSF0gZ2l0?=
 =?iso-8859-7?b?d2ViOiBEb26idCBkaWVf?=
 =?iso-8859-7?b?ZXJyb3IgaW4gZ2l0X3Rh?=
 =?iso-8859-7?b?ZyBhZnRlciBhbHJlYWR5?=
 =?iso-8859-7?b?IHByaW50aW5nIGhlYWRl?=
 =?iso-8859-7?b?cnM=?=
Date: Tue, 31 Aug 2010 09:19:35 -0700 (PDT)
Message-ID: <m37hj6oivq.fsf@localhost.localdomain>
References: <alpine.DEB.2.00.1008271337310.25632@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Tue Aug 31 18:19:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqTYn-0007RE-EE
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 18:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714Ab0HaQTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 12:19:39 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57905 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555Ab0HaQTi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 12:19:38 -0400
Received: by bwz11 with SMTP id 11so4591726bwz.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 09:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=2nDsU0oH7Wj9EUBodtd3cqavHbEpkyMLyKSXBC+sXgs=;
        b=Jsjb4ivjCpxYcqYG3ZvCj5g89NAmj7tXDEI0V1jU4fmjEcMBEFh0KRdDgUAbv0ULM/
         yWFCk03SyVqWft22kzpp+Y8ZvSBBofnhEbAp2Hcd9wbvGi+BIaBWIYJVNTf5TsBVDUdF
         BVs25IXjJ2cdx+hMA5x+8vGdrc61H8nyqKyko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Gm/7qvRuJVak9GvcqbBuq+/62EqLUAq84/9VZcYMb1WDHf7B4wusyEQA/RKs1jWkfk
         fEXGu5r+DlSrD4a9LAdt9Y6LnlcY7cPZIC05M+DGhiXCpm2V0ZrpcEUcKpRg+WOR3pZT
         LJoDnNPEAhjoZdD4xu10VjauXBjcHt2QLZ+g0=
Received: by 10.204.65.145 with SMTP id j17mr4398503bki.209.1283271577417;
        Tue, 31 Aug 2010 09:19:37 -0700 (PDT)
Received: from localhost.localdomain (abve217.neoplus.adsl.tpnet.pl [83.8.202.217])
        by mx.google.com with ESMTPS id f18sm6382928bkf.15.2010.08.31.09.19.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 09:19:35 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o7VGJJF6003215;
	Tue, 31 Aug 2010 18:19:30 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o7VGInpA003106;
	Tue, 31 Aug 2010 18:18:49 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.DEB.2.00.1008271337310.25632@dr-wily.mit.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154933>

Anders Kaseorg <andersk@MIT.EDU> writes:

> This fixes an XML error when visiting a nonexistent tag
> (?p=git.git;a=tag;h=refs/tags/BADNAME).
> 
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>

Good catch!

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
>  gitweb/gitweb.perl |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 84261bb..5dab825 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5192,15 +5192,15 @@ sub git_summary {
>  }
>  
>  sub git_tag {
> -	my $head = git_get_head_hash($project);
> -	git_header_html();
> -	git_print_page_nav('','', $head,undef,$head);
>  	my %tag = parse_tag($hash);
>  
>  	if (! %tag) {
>  		die_error(404, "Unknown tag object");
>  	}
>  
> +	my $head = git_get_head_hash($project);
> +	git_header_html();
> +	git_print_page_nav('','', $head,undef,$head);
>  	git_print_header_div('commit', esc_html($tag{'name'}), $hash);
>  	print "<div class=\"title_text\">\n" .
>  	      "<table class=\"object_header\">\n" .
> -- 
> 1.7.2.2
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
