From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 3/3] git-apply --whitespace=nowarn
Date: Mon, 27 Feb 2006 19:26:59 -0800
Message-ID: <4403C303.70602@gmail.com>
References: <20060225174047.0e9a6d29.akpm@osdl.org>	<7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>	<20060225210712.29b30f59.akpm@osdl.org>	<Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>	<20060226103604.2d97696c.akpm@osdl.org>	<Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>	<20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer>	<Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de>	<20060227011832.78359f0a.akpm@osdl.org>	<7vhd6kxuea.fsf@assigned-by-dhcp.cox.net> <7v4q2kuvxk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andrew Morton <akpm@osdl.org>
X-From: git-owner@vger.kernel.org Tue Feb 28 04:27:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDvWB-0000oX-LV
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 04:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWB1D1L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 22:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932196AbWB1D1L
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 22:27:11 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:51718 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932172AbWB1D1J (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 22:27:09 -0500
Received: by zproxy.gmail.com with SMTP id v1so1138662nzb
        for <git@vger.kernel.org>; Mon, 27 Feb 2006 19:27:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fMsxbSE8XpQ99jZmctaKAy2uT0w5IRRlX8avITESVLUjkgQY3EhLHNOYjqkDkbU/N8WAaWsRGVludRyiocL+kzrD6Sevafnt4iT0Ct9HyLdIZ9Li8vI1xsDL3Q68WmiimlcnsNzI0Jxnk7aTL52NgVo4yAs4pza1j+sepxC1SIY=
Received: by 10.35.107.20 with SMTP id j20mr967408pym;
        Mon, 27 Feb 2006 19:27:08 -0800 (PST)
Received: from ?10.0.0.6? ( [67.20.71.142])
        by mx.gmail.com with ESMTP id s72sm2363757pyc.2006.02.27.19.27.06;
        Mon, 27 Feb 2006 19:27:07 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q2kuvxk.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16910>

Junio C Hamano wrote:
> Andrew insists --whitespace=warn should be the default, and I
> tend to agree.  This introduces --whitespace=warn, so if your
> project policy is more lenient, you can squelch them by having
> apply.whitespace=nowarn in your configuration file.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

I think this is wrong. The default policy of, non-security, tools SHOULD 
  be the least restrictive and most flexible.
