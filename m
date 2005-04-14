From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Re: Re: Re: Remove need to untrack before tracking new branch
Date: Fri, 15 Apr 2005 00:35:03 +0200
Message-ID: <81b0412b0504141535793cc235@mail.gmail.com>
References: <20050412132307.GH22614@pasky.ji.cz>
	 <20050413092656.GO16489@pasky.ji.cz>
	 <1113394537.23299.51.camel@nosferatu.lan>
	 <20050413221936.GI25711@pasky.ji.cz>
	 <1113461754.23299.68.camel@nosferatu.lan>
	 <1113467335.23299.77.camel@nosferatu.lan>
	 <1113467905.23299.81.camel@nosferatu.lan>
	 <20050414091106.GX25711@pasky.ji.cz>
	 <1113471609.23299.95.camel@nosferatu.lan>
	 <1113472557.23299.99.camel@nosferatu.lan>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 00:33:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMCtc-0000UH-NC
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 00:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVDNWgO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 18:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVDNWgO
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 18:36:14 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:56751 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261604AbVDNWfH convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 18:35:07 -0400
Received: by wproxy.gmail.com with SMTP id 68so673366wra
        for <git@vger.kernel.org>; Thu, 14 Apr 2005 15:35:03 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SyXcN92UkSLqtyJuOiu+qI0/z+2AK3CS9RkM3IqGtZ7YljvyFx7TG0pR0hHJ7IYiFHvm644vIXCjegc/v0euIyOejioJRuWGicHr1Bl7A4X5MElvoxLzwo9AUr5D4TCXFbDXzY1FUaiI0omLW8ALScImHIkG2L/MknihZ2YImls=
Received: by 10.54.46.52 with SMTP id t52mr967039wrt;
        Thu, 14 Apr 2005 15:35:03 -0700 (PDT)
Received: by 10.54.79.20 with HTTP; Thu, 14 Apr 2005 15:35:03 -0700 (PDT)
To: azarah@nosferatu.za.org
In-Reply-To: <1113472557.23299.99.camel@nosferatu.lan>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 4/14/05, Martin Schlemmer <azarah@nosferatu.za.org> wrote:
> +               if (update_mode && changed & MODE_CHANGED)
> +                       chmod(ce->name, ce->st_mode);

it's "if ((update_mode && changed) & MODE_CHANGED)"
Did you really mean that?

-alex
