From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] remove protocol from gravatar and picon links for clear
 if Gitweb is being called through a secure server
Date: Mon, 28 Jan 2013 12:58:34 -0800
Message-ID: <20130128205834.GC7759@google.com>
References: <1359400490-16449-1-git-send-email-admin@andrej-andb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Andrej Andb <admin@andrej-andb.ru>
X-From: git-owner@vger.kernel.org Mon Jan 28 21:59:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzvnB-0003K7-62
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 21:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753229Ab3A1U6k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 15:58:40 -0500
Received: from mail-pb0-f43.google.com ([209.85.160.43]:54821 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753314Ab3A1U6j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 15:58:39 -0500
Received: by mail-pb0-f43.google.com with SMTP id jt11so1708869pbb.30
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 12:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=uQKNHyjRYBe5XBMbPhueHxhqRM1e3gU0I0vUiaKDjio=;
        b=zy2IYRe3ag8gIQUk+W3vpS9VcWhJOFusaaYU9kK9XFvS9V/wODf+LZLg1P1EfNPi/l
         YMsFxczDrZaNZC+7OpawbTQlkWmL3OCV9Xqsu5bJVLoesZpUJSxFeLAi2ZrXkjpi9z0W
         553ZDbkf2tQGh7BgZLriBhzSt2Iw/Cj3u8Af8NevHpBOgOXFIGnCdA024hyVw0z5zeuH
         6Ukpay/6Y7Pwl6hsIcOm2pHLejRv5P2TjML8KU1LXuh2mqps1Ei+xJd/CjJyoraGNPMK
         uAWyeUwy1lEtMuKFgfNv8jaB6aljvQ5qrvK9iHygpKuerJ/g9zd3boIA3MQ0xKlYuoY0
         gcVA==
X-Received: by 10.68.130.195 with SMTP id og3mr40970040pbb.10.1359406718678;
        Mon, 28 Jan 2013 12:58:38 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id bj9sm7389606pab.22.2013.01.28.12.58.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 12:58:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1359400490-16449-1-git-send-email-admin@andrej-andb.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214872>

(cc-ing some area experts)
Hi Andrej,

Andrej Andb wrote:

> [Subject: remove protocol from gravatar and picon links for clear if
> Gitweb is being called through a secure server]

Sounds good to me.  May we have your signoff?  (See
Documentation/SubmittingPatches for what this means.)

Thanks,
Jonathan
(patch left unsnipped for reference)

> ---
>  gitweb/gitweb.perl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index c6bafe6..1309196 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2068,7 +2068,7 @@ sub picon_url {
>  	if (!$avatar_cache{$email}) {
>  		my ($user, $domain) = split('@', $email);
>  		$avatar_cache{$email} =
> -			"http://www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/" .
> +			"//www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/" .
>  			"$domain/$user/" .
>  			"users+domains+unknown/up/single";
>  	}
> @@ -2083,7 +2083,7 @@ sub gravatar_url {
>  	my $email = lc shift;
>  	my $size = shift;
>  	$avatar_cache{$email} ||=
> -		"http://www.gravatar.com/avatar/" .
> +		"//www.gravatar.com/avatar/" .
>  			Digest::MD5::md5_hex($email) . "?s=";
>  	return $avatar_cache{$email} . $size;
>  }
