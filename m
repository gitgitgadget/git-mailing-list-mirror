From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Careful object writing..
Date: Wed, 4 May 2005 01:04:23 +0200
Message-ID: <81b0412b05050316045fa31c2a@mail.gmail.com>
References: <Pine.LNX.4.58.0505031204030.26698@ppc970.osdl.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 00:58:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT6L9-0001AO-4y
	for gcvg-git@gmane.org; Wed, 04 May 2005 00:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVECXEZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 19:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbVECXEZ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 19:04:25 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:15244 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261898AbVECXEY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 May 2005 19:04:24 -0400
Received: by wproxy.gmail.com with SMTP id 68so87320wra
        for <git@vger.kernel.org>; Tue, 03 May 2005 16:04:23 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aENMqWomEx5rp6t6c/ipkUnMUDG6YoyGYwwBo1MCyPJ1OwUr1m9Bzky/t8KMslJSTGGB+wV/C+mV/B33HbedqOftBQ7q6/U/67kRlfJQJQPGhtv+6sR5zeyA8JVIA0AAVk2FBbVZKscHmOQ8osalD6vYakvo46f+aiN5tdKRN3o=
Received: by 10.54.94.12 with SMTP id r12mr140765wrb;
        Tue, 03 May 2005 16:04:23 -0700 (PDT)
Received: by 10.54.79.20 with HTTP; Tue, 3 May 2005 16:04:23 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505031204030.26698@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 5/3/05, Linus Torvalds <torvalds@osdl.org> wrote:
> I also change the permission to 0444 before it gets its final name.

Maybe umask it first? Just in case.
