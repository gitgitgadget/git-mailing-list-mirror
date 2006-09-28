From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] format-patch: use cwd as default output directory
Date: Thu, 28 Sep 2006 17:25:00 +0700
Message-ID: <fcaeb9bf0609280325l1e88e9u75e8eac122e05e60@mail.gmail.com>
References: <fcaeb9bf0609220221w3a65af24u9db1da4e1be0d1eb@mail.gmail.com>
	 <20060922111201.GA10124@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 28 12:25:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSt4k-0000KB-Hb
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 12:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161056AbWI1KZB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 06:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161057AbWI1KZB
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 06:25:01 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:23339 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1161056AbWI1KZB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 06:25:01 -0400
Received: by py-out-1112.google.com with SMTP id n25so700433pyg
        for <git@vger.kernel.org>; Thu, 28 Sep 2006 03:25:00 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Az8jiApYSPF7/zuJNyMN9ALlOdPEEIGGedRDaPHcjqU4u0R8ncDXxrq3arEi+5NHdwXyArjU2rp/WCTrvYhObMIynk/JVtjXzmEgFcaTvKYUaOCrWXYh4NZTFrJNO2FIFz1qVMmwVFSVe7fBqZQ0rgZpGiDZEgAP7l7+jIgKXL8=
Received: by 10.35.53.18 with SMTP id f18mr3464585pyk;
        Thu, 28 Sep 2006 03:25:00 -0700 (PDT)
Received: by 10.70.45.19 with HTTP; Thu, 28 Sep 2006 03:25:00 -0700 (PDT)
To: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <20060922111201.GA10124@moooo.ath.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27999>

This patch works great. I assume you forgot it?

On 9/22/06, Matthias Lederhofer <matled@gmx.net> wrote:
> ---
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> > git format-patch in subdir generates files in topdir instead of
> > current dir as documented in its man page
> Here is a patch for this.
> ---
>  builtin-log.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-log.c b/builtin-log.c
> index fbc58bb..130b53a 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -270,6 +270,8 @@ int cmd_format_patch(int argc, const cha
>
>         rev.extra_headers = extra_headers;
>
> +       output_directory = prefix;
> +
>         /*
>          * Parse the arguments before setup_revisions(), or something
>          * like "git fmt-patch -o a123 HEAD^.." may fail; a123 is
> --
> 1.4.2.1.ge767
>
>
-- 
Duy
