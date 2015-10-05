From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/1] Makefile: make curl-config path configurable
Date: Mon, 5 Oct 2015 12:31:27 -0700
Message-ID: <20151005193127.GC11993@google.com>
References: <1444072858-24399-1-git-send-email-repk@triplefau.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>
To: Remi Pommarel <repk@triplefau.lt>
X-From: git-owner@vger.kernel.org Mon Oct 05 21:31:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjBU1-0000Ie-Fp
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 21:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbbJETbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 15:31:33 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35739 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbbJETba (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 15:31:30 -0400
Received: by pacfv12 with SMTP id fv12so188914294pac.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 12:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jpJUOlMYgbB9ViKIRX50aPYiUaGkpXx7H94oaYoxeYo=;
        b=gywh0fYsESxuYho3a+AiOcMEqbBxiEDOCKM6Y/77a253gvoX0j02yXzke+rvCOPwsq
         lQ64layj7VdECUrf6eVWz4c4o6aqaM4KRf5AYpbFkZslbJEenLdxDJsG0qeU+TvzXm6x
         xiTaymABOZBKR/oaA+QHC2aUphf/biT1ziuruC0jdElYPFc4mhIPHEg3cGTMjjjUZWdo
         4h57j5MUKEnvV24cOgb6XuTBx7dHCp7qYJodro8hBilOeBm5F6SGmckw/N5fP+F3kPoj
         FhBRlxE0gyLDzE+R7AwqJ/aw1ebMx6lQcip9K9HJfnyru9romwaFfJE/EGAg2S1/VYoB
         UAkw==
X-Received: by 10.66.145.193 with SMTP id sw1mr42011046pab.74.1444073490121;
        Mon, 05 Oct 2015 12:31:30 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:201e:549b:492b:2feb])
        by smtp.gmail.com with ESMTPSA id rw8sm29269818pac.11.2015.10.05.12.31.28
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Oct 2015 12:31:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1444072858-24399-1-git-send-email-repk@triplefau.lt>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279070>

Remi Pommarel wrote:

> There are situations, ie during cross compilation, where curl-config program
> is not present in the PATH.

s/ie/e.g.,/

[...]
> @@ -374,6 +378,7 @@ LDFLAGS =
>  ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
>  ALL_LDFLAGS = $(LDFLAGS)
>  STRIP ?= strip
> +CURL_CONFIG = curl-config

Could this go down with the other programs (CC, AR, FIND, et al)?

The rest looks good.

Jonathan
