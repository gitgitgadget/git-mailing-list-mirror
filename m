From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: use result of open(2) to check for presence
Date: Thu, 5 Jan 2006 11:45:27 -0500
Message-ID: <118833cc0601050845i40f93bbajdd70e77953d07014@mail.gmail.com>
References: <81b0412b0601050343w4c00ac86y30569c3babbf6728@mail.gmail.com>
	 <118833cc0601050648t17f68bcch8fd7c541585e965c@mail.gmail.com>
	 <81b0412b0601050712q4c2123f7i8e9190c3b75b6fda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 05 17:46:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EuYF2-0003p5-LN
	for gcvg-git@gmane.org; Thu, 05 Jan 2006 17:45:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbWAEQp3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jan 2006 11:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbWAEQp3
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jan 2006 11:45:29 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:64041 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751687AbWAEQp2 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 5 Jan 2006 11:45:28 -0500
Received: by zproxy.gmail.com with SMTP id 14so3312959nzn
        for <git@vger.kernel.org>; Thu, 05 Jan 2006 08:45:28 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UMy9ClO9dArBe6+1Y2ZEIuI+Q3V+uZyG8Sh7Jx2Rq/T/LAf2d8dbqirbygHUqZdszmmQnRaB0DXxCL65ItpDtzAQWqI8vRsuv7XV0maakH2Kl0lpye9EmnmqEV5gnSM4dajCpD121Ncf3003Hi53lCtgh8vGigCfE9pw/ssIlo0=
Received: by 10.36.90.3 with SMTP id n3mr6922424nzb;
        Thu, 05 Jan 2006 08:45:27 -0800 (PST)
Received: by 10.36.90.2 with HTTP; Thu, 5 Jan 2006 08:45:27 -0800 (PST)
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0601050712q4c2123f7i8e9190c3b75b6fda@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14204>

Config files always tend to grow, but I do agree that 4GB config files stretches
credibility a bit.

However, empty ones are not unlikely and then mmap will fail.

M.
