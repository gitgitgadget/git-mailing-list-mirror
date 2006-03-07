From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: PATCH: Allow format-patch to attach patches
Date: Mon, 06 Mar 2006 19:24:39 -0800
Message-ID: <440CFCF7.9090407@gmail.com>
References: <440C352C.9070009@codeweavers.com> <7vpskz5aqh.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mike McCormack <mike@codeweavers.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 07 04:24:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGSoY-0008A5-Rc
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 04:24:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752483AbWCGDYo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 22:24:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWCGDYo
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 22:24:44 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:36048 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752483AbWCGDYn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Mar 2006 22:24:43 -0500
Received: by wproxy.gmail.com with SMTP id i4so80442wra
        for <git@vger.kernel.org>; Mon, 06 Mar 2006 19:24:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=hh6nLhkUOsmkmk6E2kOAFWCYj+xEInGdcgSgAYwr+IsbswlAQmLNjGiJP1MGfT6aTgybV108TivLGZZgZbR3P0ypgE7AiLQbS51/csnVv/Tfy+N8MKcDll41JuXR5lyu7ZzXtRXZ5vip/n6HsnoKJZs6sq5VaFqELtCNDqFUgWg=
Received: by 10.54.95.1 with SMTP id s1mr77200wrb;
        Mon, 06 Mar 2006 19:23:46 -0800 (PST)
Received: from ?10.0.0.6? ( [67.20.67.7])
        by mx.gmail.com with ESMTP id 44sm94136wri.2006.03.06.19.24.41;
        Mon, 06 Mar 2006 19:24:42 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpskz5aqh.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17317>

Junio C Hamano wrote:
> Nicely done.
...
> The only two and half minor issues I might have about this are:
> 
...
> 
>  (2) is it possible to cheaply come up with a safe mime-magic,
>      instead of a hardcoded long string and hope it does not
>      clash?

Base64 encode a large number (160?) of bits from /dev/urandom.
