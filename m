From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv6 05/10] gitweb: use fullname as hash_base in heads link
Date: Mon, 25 Oct 2010 16:56:59 +0200
Message-ID: <201010251657.02802.jnareb@gmail.com>
References: <1287917136-26103-1-git-send-email-giuseppe.bilotta@gmail.com> <1287917136-26103-6-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 25 16:57:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAOUW-0004Pu-Sd
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 16:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142Ab0JYO5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Oct 2010 10:57:35 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37474 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267Ab0JYO5e (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Oct 2010 10:57:34 -0400
Received: by ywk9 with SMTP id 9so2125814ywk.19
        for <git@vger.kernel.org>; Mon, 25 Oct 2010 07:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VSnILbpWPfvfPu9vBa8Zvm1y1mexkI9Orj8C7OhPhOA=;
        b=C83Qq+N8xWeVu0yc+np5CdDIsctUXW5bX55qxWvre41PYnqY/naAKhB7bN4M/HMcdR
         pql2Z6wV5cLw/o9LdsD+42NxmabLPQMb2KuZ8fRHKLfPmMHByk6ms4nF7ge//LcKN4Fs
         EhzNqNCDjxUcFfEQGsJ1llhpMntzXyIC3vDlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=her1ZG0vb/WW2zrY+QN56NIgSG7dn3XthkNxWzOb2+le8NYAHcHLLeIxOXU1TgC1jW
         1nKDhGtWQlUdeOv190pxWgYRibJ43CW2t/xBPHx4tSQ+exfZSmBdEp5x+MNUzWdrgQSI
         vpTn+GdErJCj2/pMDUaWPTpI+Cb5wCRVnhScA=
Received: by 10.103.40.6 with SMTP id s6mr3846110muj.57.1288018653163;
        Mon, 25 Oct 2010 07:57:33 -0700 (PDT)
Received: from [192.168.1.13] (abwi90.neoplus.adsl.tpnet.pl [83.8.232.90])
        by mx.google.com with ESMTPS id m8sm1180887faj.3.2010.10.25.07.57.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 25 Oct 2010 07:57:19 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1287917136-26103-6-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159953>

On Sun, 24 Oct 2010, Giuseppe Bilotta wrote:

> Otherwise, if names are manipulated for display, the link will point to
> the wrong head.
> 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

Shouldn't this patch be at beginning, as first patch of the series?

> ---
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index f4592ad..a381892 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4991,7 +4991,7 @@ sub git_heads_body {
>  		      "<td class=\"link\">" .
>  		      $cgi->a({-href => href(action=>"shortlog", hash=>$ref{'fullname'})}, "shortlog") . " | " .
>  		      $cgi->a({-href => href(action=>"log", hash=>$ref{'fullname'})}, "log") . " | " .
> -		      $cgi->a({-href => href(action=>"tree", hash=>$ref{'fullname'}, hash_base=>$ref{'name'})}, "tree") .
> +		      $cgi->a({-href => href(action=>"tree", hash=>$ref{'fullname'}, hash_base=>$ref{'fullname'})}, "tree") .
>  		      "</td>\n" .
>  		      "</tr>";
>  	}
> -- 
> 1.7.3.68.g6ec8
> 
> 

-- 
Jakub Narebski
Poland
