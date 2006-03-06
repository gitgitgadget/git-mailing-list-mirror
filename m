From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] annotate: Support annotation of files on other revisions.
Date: Sun, 05 Mar 2006 21:31:26 -0800
Message-ID: <440BC92E.4060306@gmail.com>
References: <20060305111334.GB23448@c165.ib.student.liu.se> <440B751F.5000801@michonline.com> <46a038f90603051629ke34a0a6u89dad995bbd777b0@mail.gmail.com> <20060306024353.GA23001@mythryan2.michonline.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Mon Mar 06 06:31:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG8Jm-0002Hb-9H
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 06:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWCFFbb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 00:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWCFFbb
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 00:31:31 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:6348 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750981AbWCFFba (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Mar 2006 00:31:30 -0500
Received: by zproxy.gmail.com with SMTP id n1so769255nzf
        for <git@vger.kernel.org>; Sun, 05 Mar 2006 21:31:29 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=hXag0RRZI3lnvTnYHa30y1/TxNbcxRU37HLQq+bA7pguWvthODsY4u2dZOMi/ffn7/psNP41cmLCqL9TmoGzfwS8SIYTxVDw6HlR4L+wgp0RiK3bDSRCOZCgKDaGvOOYsqtk8MWNIIUDTi7FO4ixvRxxRNHakeLcl2mEL6WqvMI=
Received: by 10.36.126.13 with SMTP id y13mr6565000nzc;
        Sun, 05 Mar 2006 21:31:29 -0800 (PST)
Received: from ?10.0.0.6? ( [67.20.67.7])
        by mx.gmail.com with ESMTP id 7sm4258503nzo.2006.03.05.21.31.28;
        Sun, 05 Mar 2006 21:31:29 -0800 (PST)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20060306024353.GA23001@mythryan2.michonline.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17272>

Ryan Anderson wrote:
...
> 
> For annotate, the syntax I was using was:
> 	git annotate Makefile headname
> 
> I'm not married to it, so please, send a patch to change it if you want
> (Please fix up the test case I'm sending in this patch, as well.)
> 

Wouldn't
	git annotate <headname> <filename(s?)>
be more consistent with other git commands?
