From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] Fix rename/copy when dealing with temporarily broken pairs.
Date: Tue, 14 Jun 2005 08:17:17 +1000
Message-ID: <2cfc403205061315173f8095b8@mail.gmail.com>
References: <7vfyvpxlqi.fsf@assigned-by-dhcp.cox.net>
	 <7vwtp0p6tz.fsf@assigned-by-dhcp.cox.net>
	 <2cfc4032050613092462d3a456@mail.gmail.com>
	 <7vis0ic6ot.fsf@assigned-by-dhcp.cox.net>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Tue Jun 14 01:30:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhyNw-0007oh-Pm
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 01:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVFMXel (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 19:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVFMWSd
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 18:18:33 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:19180 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261519AbVFMWRT convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2005 18:17:19 -0400
Received: by rproxy.gmail.com with SMTP id i8so1329421rne
        for <git@vger.kernel.org>; Mon, 13 Jun 2005 15:17:17 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G2FMSEph2PXfUkPoFMFQS7vwAALsoK6bpXQFj6vrWhM+SiH3Sc2YBYIedphSOQv0FkXuPoekBq+KR/EvVDFxgKvf5gDWSnYi1MwlXEqfXS3CJAY2dvMI9sTBiSpcjQ+YS+4uIj95dezZcUMEtZFlcXewEuvN+KxMdhptCneSyEU=
Received: by 10.38.89.20 with SMTP id m20mr1167493rnb;
        Mon, 13 Jun 2005 15:17:17 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Mon, 13 Jun 2005 15:17:17 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vis0ic6ot.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/14/05, Junio C Hamano <junkio@cox.net> wrote:
> JS> I wondered if this patch might fix it, but it doesn't seem to.
> Regular "patch" cannot grok either copy or rename.  If your
> recipient uses "patch", then you must not use -C nor -M when you
> are preparing a diff for his consumption.

Ok, there was no problem other than me not understanding what
git-apply did - thank you Pasky for bringing light to the dark regions
of my sleep-deprived brain!

jon.
