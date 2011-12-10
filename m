From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [RFC/PATCH] show tracking branches with their associated branch
 names
Date: Sat, 10 Dec 2011 10:53:31 +0100
Message-ID: <4EE32C1B.8070306@lyx.org>
References: <1323502829.1698.6.camel@sdesktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Santhosh Kumar Mani <santhoshmani@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 10:53:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZJcp-0004IU-3K
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 10:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588Ab1LJJxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 04:53:42 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61062 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089Ab1LJJxm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 04:53:42 -0500
Received: by wgbdr13 with SMTP id dr13so7340579wgb.1
        for <git@vger.kernel.org>; Sat, 10 Dec 2011 01:53:41 -0800 (PST)
Received: by 10.227.209.9 with SMTP id ge9mr9326011wbb.1.1323510821109;
        Sat, 10 Dec 2011 01:53:41 -0800 (PST)
Received: from [192.168.1.52] (host064-007.kpn-gprs.nl. [62.133.64.7])
        by mx.google.com with ESMTPS id ep13sm15645965wbb.8.2011.12.10.01.53.36
        (version=SSLv3 cipher=OTHER);
        Sat, 10 Dec 2011 01:53:37 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <1323502829.1698.6.camel@sdesktop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186731>

Op 10-12-2011 8:40, Santhosh Kumar Mani schreef:
> The "git branch" command, by default, displays the local branches. There
> is no visual distinction made between the tracking branches and normal
> local branches. This patch enables the "git branch" to display
> tracking info for tracking branches:
>
> Before this patch:
>    $ git branch
>    * master
>      local
>
> After this patch:
>    $ git branch
>    * master [origin/master]
>      local
>
>
Did you try "git branch -vv" ?

Vincent
