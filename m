From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH/RFC] "Recursive Make considered harmful"
Date: Wed, 27 Jul 2005 18:07:07 -0400
Message-ID: <42E8058B.7070907@gmail.com>
References: <20050727083910.GG19290@mythryan2.michonline.com> <7v4qafrk8w.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 00:14:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dxu6r-0002xT-F7
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 00:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbVG0WJ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jul 2005 18:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVG0WHd
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jul 2005 18:07:33 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:13776 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261185AbVG0WHO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2005 18:07:14 -0400
Received: by wproxy.gmail.com with SMTP id 63so298304wri
        for <git@vger.kernel.org>; Wed, 27 Jul 2005 15:07:09 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=DDgNgOGY0k3HHnDvdbpiPcjj0JR/y92oeOhGbh3oH1oPGeP1AROr1ETtfLUQp8yRZKVKadIGP4kEjN5qaxJZj46tTfrULhPag1oCEwtTeprsuX+6X16NzMWkbSnHH9UhSeF9LIdXB/fGT12g26CJGkbq4G+EWdpzZz2Pm1RunSo=
Received: by 10.54.17.11 with SMTP id 11mr506068wrq;
        Wed, 27 Jul 2005 15:07:09 -0700 (PDT)
Received: from ?10.0.0.6? ([70.89.97.97])
        by mx.gmail.com with ESMTP id 10sm5062806wrl.2005.07.27.15.07.08;
        Wed, 27 Jul 2005 15:07:09 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4qafrk8w.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> While I do not have strong objections to make the build process
> go faster, it is somewhat disturbing that the Makefile pieces
> maintained in subdirectories need to name things they touch
> using paths that include the subdirectory names.  I do not have
> a better alternative to suggest, though...

For a project the size of Git, is there any real benefit to this change?

Besides pathing issues, you also have to aware that all identifiers in 
the included makefile fragments will be global.

I don't object to the change but I see it as trading one maintenance 
issue for another.
