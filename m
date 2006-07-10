From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: newbie'ish FAQ/question about merging different trees
Date: Mon, 10 Jul 2006 14:31:21 +0200
Message-ID: <81b0412b0607100531k6fc6921do1990850aef259dba@mail.gmail.com>
References: <d55656c10607100456o761bb342p3db229b499579dd9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 14:31:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzuv8-000287-S5
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 14:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030345AbWGJMbY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 08:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbWGJMbY
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 08:31:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:27939 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964951AbWGJMbX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 08:31:23 -0400
Received: by ug-out-1314.google.com with SMTP id a2so3855528ugf
        for <git@vger.kernel.org>; Mon, 10 Jul 2006 05:31:22 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rasjlXTD6jeAsC0TgHzi5X80iumiX4K07EKtSLzyw4mTcsOJm9Y84x/ndpdcDNBq1IdGzA8Se7XJhWiMt1N2hKlDPMMTmg55UGcqkwUUA2/qzFPiDztXtTdOFdPj+cFx2f/JyqVQtUAoXevm3awzC1gGCv/8X9OUyV5eTokmNPY=
Received: by 10.78.164.13 with SMTP id m13mr1623248hue;
        Mon, 10 Jul 2006 05:31:22 -0700 (PDT)
Received: by 10.78.160.5 with HTTP; Mon, 10 Jul 2006 05:31:21 -0700 (PDT)
To: "Peter Gervai" <grin@grin.hu>
In-Reply-To: <d55656c10607100456o761bb342p3db229b499579dd9@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23615>

On 7/10/06, Peter Gervai <grin@grin.hu> wrote:
> There are two trees on kernel.org's git:
>
> linux/kernel/git/jejb/aic94xx-sas-2.6.git  (it seems to be at 2.6.16-rc5)
> linux/kernel/git/torvalds/linux-2.6.git (it probably does have a tag
> at v2.6.17.4)

It doesn't. The stable tags are in stable per-release repo
(linux-2.6.17.y.git currently)

> Is there a way to merge these to produce 2.6.17.4 (latest released), patched?
>

Why, doesn't "git pull aic94xx-sas-2.6.git master" work anymore?
