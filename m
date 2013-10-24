From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] http.c: Spell the null pointer as NULL
Date: Thu, 24 Oct 2013 13:58:17 -0700
Message-ID: <20131024205817.GD9464@google.com>
References: <5269804F.2080800@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jeff King <peff@peff.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 24 22:58:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZRz7-0003hH-8M
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 22:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755129Ab3JXU6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 16:58:21 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:50578 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665Ab3JXU6U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 16:58:20 -0400
Received: by mail-pa0-f51.google.com with SMTP id ld10so3063797pab.10
        for <git@vger.kernel.org>; Thu, 24 Oct 2013 13:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LSgZICLweJgV5nUTgTP9kzuRUcoolw6jfkMcxUOOOTg=;
        b=ReoEIsOyFq6oBe0xKb4JNf30qf2+qQRcPXgYyzwbS6xXUiqLjcB2Zzyth+VjyxDbAd
         zxXYOjdGzzSpqI2EgKLPHwDTCE2AAVWsieswo5vD3Ff5n5TGYYKebibROoVxjlCQY5RF
         591V+hC3cz68YX0YAoLK2dV/ssBQccpNkZFlt0o72+egZRksv/jzKf2qKK+YShRVLOGW
         atYDtOIMAMWhFHJarxqIIv9NaYVSjWcSo4fnFate4WA86UYAe1dGG8o+hVaU8832mlMR
         D0kkp3App/Stvf+rnNwu7c4NnwWkah9MimBr5MsZrt3uKXwnqBBbQOexv7FXwdwJ8Ed0
         GErQ==
X-Received: by 10.68.209.197 with SMTP id mo5mr3903719pbc.191.1382648299882;
        Thu, 24 Oct 2013 13:58:19 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id de1sm4698695pbc.7.2013.10.24.13.58.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Oct 2013 13:58:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5269804F.2080800@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236621>

Ramsay Jones wrote:

> Commit 1bbcc224 ("http: refactor options to http_get_*", 28-09-2013)
> changed the type of final 'options' argument of the http_get_file()
> function from an int to an 'struct http_get_options' pointer.
> However, it neglected to update the (single) call site. Since this
> call was passing '0' to that argument, it was (correctly) being
> interpreted as a null pointer. Change to argument to NULL.

Jeff King wrote:

> Thanks, patch is obviously correct (and the cause was just oversight on
> my part).

For what it's worth, against the jk/http-auth-redirects branch,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
