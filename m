From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Deal with binary diff output from (unknown version of)
 diff
Date: Thu, 17 Nov 2005 20:58:26 -0800
Message-ID: <437D5F72.8050100@gmail.com>
References: <20051115144223.GA18111@diana.vm.bytemark.co.uk>	<b0943d9e0511160311k725526d8v@mail.gmail.com>	<7vr79g8mys.fsf@assigned-by-dhcp.cox.net>	<7v7jb83w8m.fsf_-_@assigned-by-dhcp.cox.net>	<81b0412b0511170029xac34cdbtddf74eb766281b3c@mail.gmail.com>	<7vy83ny450.fsf@assigned-by-dhcp.cox.net>	<81b0412b0511170236r28572db9i84dc271700ded79a@mail.gmail.com>	<7vwtj7wn7n.fsf@assigned-by-dhcp.cox.net> <437D2D14.5080205@gmail.com>	<7vfypur5jb.fsf@assigned-by-dhcp.cox.net> <437D4F57.9070303@gmail.com>	<7vbr0ir387.fsf@assigned-by-dhcp.cox.net> <7v1x1er2ai.fsf_-_@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: John Benes <smartcat99s@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 06:00:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcyKf-0000HI-Aq
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 05:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751518AbVKRE63 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 Nov 2005 23:58:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbVKRE63
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Nov 2005 23:58:29 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:30032 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751518AbVKRE63 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2005 23:58:29 -0500
Received: by xproxy.gmail.com with SMTP id s14so108953wxc
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 20:58:28 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=mH7Ul7rzoaoCAveU34d2xINT+Dn/+lVDHYuQfXpoTqqxRYvKtveeZcONnLzOzRiEGr4e/DPbMu35BVcdYHty37wSjvM6V0lBv9tqiIh1yTvaEbF/O5O3WEZTYo117qFYK4BmPxBtjvbtV07B2oo2Mf8vti29pwyD+xZG8bZUI3Q=
Received: by 10.70.47.13 with SMTP id u13mr5928995wxu;
        Thu, 17 Nov 2005 20:58:28 -0800 (PST)
Received: from ?10.0.0.6? ( [70.32.120.109])
        by mx.gmail.com with ESMTP id i15sm360638wxd.2005.11.17.20.58.27;
        Thu, 17 Nov 2005 20:58:28 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1x1er2ai.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12199>

Passed here!


Junio C Hamano wrote:
> Some vintage of diff says just "Files X and Y differ\n", instead
> of "Binary files X and Y differ\n", so catch both patterns.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> 
> ---
> 
>     Junio C Hamano <junkio@cox.net> writes:
> 
>     >> Files /dev/null and b/file3 differ
>     >> diff --git a/file4 b/file4
>     >> index edc575d..adb07b7 100644
>     >> Files a/file4 and b/file4 differ
>     >
>     > Thanks.  I've seen enough.  I expected diff (GNU diffutils 2.8.1
>     > is what I have handy) output which says "Binary files a/foo and
>     > b/foo differ".
>     >
>     > Hmph.  Now I'd need to find a way to catch at least these two
>     > cases...
> 
>     Could you two try this patch please?

[snip snip]
