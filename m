From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] strbuf: use strbuf_addstr() for adding C strings
Date: Wed, 16 Jul 2014 16:41:51 -0700
Message-ID: <20140716234151.GN12427@google.com>
References: <53C70CEA.8000000@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Thu Jul 17 01:41:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7Ypj-0007af-E7
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 01:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754790AbaGPXl4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jul 2014 19:41:56 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:55223 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbaGPXlz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2014 19:41:55 -0400
Received: by mail-pa0-f42.google.com with SMTP id lf10so2199813pab.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2014 16:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TE5MiUC6B2CMXcqqhuLQQqByaL60unC7RRsQLebqm6g=;
        b=Hizywd76sZXxG4MoTKI2OGNMmPfHbr4dBGiacN121tc9MPdyQfisY0inrfLsQITqV+
         O4GvKuxFd1AGNRSM+ArOzXFbEZcF1P+UwWRZ60LgaM/gmAyryZpn2ZE1ctZ60gl8hhiZ
         2xx16RzvnzSLIY5zc3ozByC5iOljstIx7GHADx8s6cEhsWb+F71Xk/H7NMMwqpqaVamf
         7uyMicJv2uKwgttBSTWkS9OQM16ka/86Pb0TR2wgMDz+e8x3i2fiPSX6uRWJyl0ylsK9
         9RzonFVKdLU7iX1iPgXGnlkWZ+JP523SddxDrn8FPkG/mMTIAZ/JfM+F/64pR7r9NCfx
         3Yvw==
X-Received: by 10.66.163.98 with SMTP id yh2mr19625789pab.104.1405554114693;
        Wed, 16 Jul 2014 16:41:54 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c052:e528:5bc0:f00e])
        by mx.google.com with ESMTPSA id rc3sm526112pbc.5.2014.07.16.16.41.53
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Jul 2014 16:41:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <53C70CEA.8000000@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253717>

Ren=E9 Scharfe wrote:

> Avoid code duplication and let strbuf_addstr() call strlen() for us.

Nice.

> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/commit.c |  2 +-
>  diff.c           | 12 ++++++------
>  path.c           |  6 +++---
>  3 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
