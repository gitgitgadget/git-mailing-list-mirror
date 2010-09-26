From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 11/12] gitweb: use git_repo_url() in summary
Date: Mon, 27 Sep 2010 00:36:08 +0200
Message-ID: <201009270036.09100.jnareb@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com> <1285344167-8518-12-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 00:36:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzzpV-0006QH-SG
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 00:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384Ab0IZWgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 18:36:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53201 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932321Ab0IZWgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 18:36:16 -0400
Received: by fxm3 with SMTP id 3so1506091fxm.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 15:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=a1DXIEBAaxbivG5Wcl/jGLX6OFIaVL3bGmmQ2zOm+BA=;
        b=u94EP6wD3nV5mQ4rdWnIIklX6opl5OHirP3Dq91IwDTs9SesaywASuTkFMR6mVfMws
         GnrbroxrmOTT864PVzT7oRZ4GR1uFiaW2epVBsxWIzziBGlTy5xmCIeSEOdUH9aqlZaw
         CDHzVkH1uf9Ud5dFbZTRU86fBFRYq4bDOWSsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=q7gazXvyVvRw5s/lYAWEZVkmL5iwQYV4z9HAHJCO5i2i8H5bZVXQqqx0ESmV+soESj
         aiEt3GBgDfwQ82cVFt9i5hBzXCMnW1oF5N1EKvSUHvd4qS/qhwyD3+e97azlF8vQbSMn
         iww9Z7NkGW3xBKOH2bV07zHtpv/+6uGsLq3yI=
Received: by 10.223.117.15 with SMTP id o15mr5975982faq.51.1285540575235;
        Sun, 26 Sep 2010 15:36:15 -0700 (PDT)
Received: from [192.168.1.13] (abwp12.neoplus.adsl.tpnet.pl [83.8.239.12])
        by mx.google.com with ESMTPS id 10sm2087466fax.42.2010.09.26.15.36.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 15:36:14 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1285344167-8518-12-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157265>

On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:

> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -5190,7 +5190,7 @@ sub git_summary {
>  	@url_list = map { "$_/$project" } @git_base_url_list unless @url_list;
>  	foreach my $git_url (@url_list) {
>  		next unless $git_url;
> -		print "<tr class=\"metadata_url\"><td>$url_tag</td><td>$git_url</td></tr>\n";
> +		print git_repo_url($url_tag, $git_url);
>  		$url_tag = "";
>  	}

I think this patch should be squashed together with previous one.
FWIW, ACK (after squashing of course).

-- 
Jakub Narebski
Poland
