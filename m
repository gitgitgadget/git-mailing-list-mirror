From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] remote: fix remote set-url usage
Date: Mon, 7 Nov 2011 03:48:41 -0600
Message-ID: <20111107094841.GE30641@elie.hsd1.il.comcast.net>
References: <1320637017-30863-1-git-send-email-felipe.contreras@gmail.com>
 <7vfwi04itx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 10:48:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNLow-0004g4-5N
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 10:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006Ab1KGJsq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 04:48:46 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:62351 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902Ab1KGJsp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 04:48:45 -0500
Received: by gyc15 with SMTP id 15so3993785gyc.19
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 01:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=p19srPLtg5pU/zWwD5PKGpxD/53TVjbx+pBji/UrdRY=;
        b=UPNJo7mxxFsYmFxTgeQTKsKB1frtkJjmB28kBy17Xx/q3VMTACJ1fSv0MeQdKRg4K5
         FX5/Liy4OoM8ujSTOW16dEyEkx6iOHxF5V/CoWXC1ycgBxh2IB7Xmi0X2lMV7SE3kHH4
         Ca+YbIpxgfTzkO3sMZwKNGAJ/GOcOblNkFaVI=
Received: by 10.43.53.1 with SMTP id vo1mr46324491icb.2.1320659324737;
        Mon, 07 Nov 2011 01:48:44 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id n30sm37471816ibl.4.2011.11.07.01.48.42
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Nov 2011 01:48:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vfwi04itx.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184967>

Junio C Hamano wrote:

> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -1336,7 +1336,7 @@ static int set_branches(int argc, const char **argv)
>  			     builtin_remote_setbranches_usage, 0);
>  	if (argc == 0) {
>  		error("no remote specified");
> -		usage_with_options(builtin_remote_seturl_usage, options);
> +		usage_with_options(builtin_remote_setbranches_usage, options);

Good eyes.  Thanks for catching it.
