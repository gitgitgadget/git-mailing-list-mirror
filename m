From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] gitweb.cgi: Customization
Date: Wed, 2 Aug 2006 14:13:51 +1200
Message-ID: <46a038f90608011913t777cf20dh9baaf355b19d18e6@mail.gmail.com>
References: <20060801225352.26998.qmail@web31801.mail.mud.yahoo.com>
	 <7v8xm8xbaa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Luben Tuikov" <ltuikov@yahoo.com>, git@vger.kernel.org,
	"Martin Waitz" <tali@admingilde.org>,
	"Matthias Lederhofer" <matled@gmx.net>
X-From: git-owner@vger.kernel.org Wed Aug 02 04:14:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G86FH-0002mW-Mz
	for gcvg-git@gmane.org; Wed, 02 Aug 2006 04:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWHBCNy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Aug 2006 22:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWHBCNy
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Aug 2006 22:13:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:2542 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751036AbWHBCNx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Aug 2006 22:13:53 -0400
Received: by nf-out-0910.google.com with SMTP id n29so478470nfc
        for <git@vger.kernel.org>; Tue, 01 Aug 2006 19:13:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lif+VlsOTHiauOp5clDStulkHNt5wBX7b19bezzPG59FMIXJ/LVoGJUP78uxiYWzZGhkSLJaYGnKb2JWFC+VIoBJPrMweaspwm9Mr8IWHHMGsbx1QZox+64a9QOxDimc1l73pZK/Hpp7l2u0loEh+6L+5/S6TX+IqKHCDguDubU=
Received: by 10.78.116.19 with SMTP id o19mr119969huc;
        Tue, 01 Aug 2006 19:13:51 -0700 (PDT)
Received: by 10.78.120.17 with HTTP; Tue, 1 Aug 2006 19:13:51 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v8xm8xbaa.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24631>

On 8/2/06, Junio C Hamano <junkio@cox.net> wrote:
> I do not think there is much difference between any of the
> customization proposed so far (yours, Martin's and the one from
> Matthias Lederhofer) from functionality and ease-of-use point of
> view.  They all try to make customization can be done in one
> place, and the difference is mostly of taste, so I'd just pick
> one from Martin

I'm a bit lost as to gitweb config. Are we not relying on %ENV for
this stuff? Apache's facilities to configure CGIs via ENV are really
powerful. You can do conditionals in apache config files, lock stuff
down in httpd.conf, override it with files in conf.d, and
allow/disallow overrides in .htaccess ...

cheers,


martin
