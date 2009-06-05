From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 19/23] http-push.c::fetch_symref(): use the new http API
Date: Fri, 05 Jun 2009 13:54:07 -0700 (PDT)
Message-ID: <m37hzq5rod.fsf@localhost.localdomain>
References: <20090606000559.483f22da.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 22:54:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCgQd-0001kB-DD
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 22:54:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbZFEUyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 16:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752129AbZFEUyJ
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 16:54:09 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:35148 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbZFEUyI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 16:54:08 -0400
Received: by bwz9 with SMTP id 9so1765801bwz.37
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 13:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=p2PHFoADym9kyhmL/bqSNtrfnwBveu8m/eecKUjpd98=;
        b=hP8eqlLmgZCD8XgzOgHv2JNuxrxw4fucKPUN8Tkrxa+5ZJJWwa0Q6WPnt/ocxGuwB9
         9fMRCg48/6mmDwH0YbuVXFgdeaJL61wsCAkIGqksCL98KbXYi6IJVWZ6Lj/t7QQ3y2io
         wmi22OWNxrt7DCO9qctoBjnn3xbDxDwOm/Ey4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=YMfvCWVvLKEcl2jpFI6WeF3UXVX5grWC22/oufmbUo0QKOgczJhqpC2cVk4wnXAKqU
         nasS/4QE/8AA6UmrpQf6osDZ8qt1gADkxPPDo5aIf1y+8d9EVPQgw1k0RRjfIwYpHy1B
         sV/qjHlRnEJXzG4rwVmLY5vMcvapOH3TOeEqQ=
Received: by 10.204.97.140 with SMTP id l12mr3568401bkn.133.1244235247895;
        Fri, 05 Jun 2009 13:54:07 -0700 (PDT)
Received: from localhost.localdomain (abwo21.neoplus.adsl.tpnet.pl [83.8.238.21])
        by mx.google.com with ESMTPS id k29sm384381fkk.17.2009.06.05.13.53.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 13:54:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n55KrGxb024701;
	Fri, 5 Jun 2009 22:53:26 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n55Kqo0C024690;
	Fri, 5 Jun 2009 22:52:50 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090606000559.483f22da.rctay89@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120835>

Tay Ray Chuan <rctay89@gmail.com> writes:

> From:	Mike Hommey <mh@glandium.org>
> Subject: [WIP Patch 09/12] Use the new http API in fetch_symref()

What is the subject of this patch:
  "http-push.c::fetch_symref(): use the new http API"
or
  "Use the new http API in fetch_symref()"

> Date:	Sun, 18 Jan 2009 09:04:34 +0100
> 
> Signed-off-by: Mike Hommey <mh@glandium.org>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> ---

If you wanted to note old subject, it would be better to put it in
comments (here).

>  http-push.c |   20 +++-----------------
>  1 files changed, 3 insertions(+), 17 deletions(-)
> 
> diff --git a/http-push.c b/http-push.c
> index 455e0aa..1714e4e 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -2029,27 +2029,13 @@ static void fetch_symref(const char *path, char **symref, unsigned char *sha1)
>  {
>  	char *url;
>  	struct strbuf buffer = STRBUF_INIT;
> -	struct active_request_slot *slot;
> -	struct slot_results results;
> 
>  	url = xmalloc(strlen(repo->url) + strlen(path) + 1);
>  	sprintf(url, "%s%s", repo->url, path);
> 
> -	slot = get_active_slot();
> -	slot->results = &results;
> -	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
> -	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
> -	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, NULL);
> -	curl_easy_setopt(slot->curl, CURLOPT_URL, url);
> -	if (start_active_slot(slot)) {
> -		run_active_slot(slot);
> -		if (results.curl_result != CURLE_OK) {
> -			die("Couldn't get %s for remote symref\n%s",
> -			    url, curl_errorstr);
> -		}
> -	} else {
> -		die("Unable to start remote symref request");
> -	}
> +	if (http_get_strbuf(url, &buffer, 0) != HTTP_OK)
> +		die("Couldn't get %s for remote symref\n%s", url,
> +		    curl_errorstr);
>  	free(url);
> 
>  	free(*symref);
> --
> 1.6.3.1
> 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
