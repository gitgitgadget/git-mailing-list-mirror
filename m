From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Garbage in .git directories???
Date: Mon, 19 Sep 2005 16:58:52 -0700
Message-ID: <432F50BC.5000304@zytor.com>
References: <200509172141.31591.dtor_core@ameritech.net> <432F0D1B.60303@zytor.com> <20050919194445.GD18320@pasky.or.cz> <432F46BE.5000406@zytor.com> <20050919234030.GI18320@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 20 02:01:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHVXs-0002op-7O
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 01:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbVISX7V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 19:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbVISX7V
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 19:59:21 -0400
Received: from terminus.zytor.com ([209.128.68.124]:1458 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964790AbVISX7U
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 19:59:20 -0400
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j8JNwvHw013509
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 19 Sep 2005 16:58:58 -0700
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <20050919234030.GI18320@pasky.or.cz>
X-Virus-Scanned: ClamAV version 0.87, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8927>

Petr Baudis wrote:
> Dear diary, on Tue, Sep 20, 2005 at 01:16:14AM CEST, I got a letter
> 
> Another idea - try this patch:
> 
> diff --git a/init-db.c b/init-db.c
> --- a/init-db.c
> +++ b/init-db.c
> @@ -154,6 +154,7 @@ static void copy_templates(const char *g
>  	}
>  
>  	memcpy(path, git_dir, len);
> +	path[len] = 0;
>  	copy_templates_1(path, len,
>  			 template_path, template_len,
>  			 dir);
> 

This seems to have worked.

	-hpa
