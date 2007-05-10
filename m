From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCHv2] connect: display connection progress
Date: Thu, 10 May 2007 19:40:18 +0200
Message-ID: <81b0412b0705101040g3a8426advc682d6560155d50c@mail.gmail.com>
References: <20070510095156.GC13655@mellanox.co.il>
	 <20070510120802.GG13655@mellanox.co.il>
	 <81b0412b0705100519i3028fbc4y25e7c407c7c8216@mail.gmail.com>
	 <20070510122550.GJ13655@mellanox.co.il>
	 <81b0412b0705100633t61ac0309jfc8536b30244adf6@mail.gmail.com>
	 <20070510134622.GN13655@mellanox.co.il>
	 <81b0412b0705100716t680290a3qd1d10cf588a65f5a@mail.gmail.com>
	 <20070510143913.GF22029@mellanox.co.il>
	 <81b0412b0705100752wa6dec37t787ccd61266f8944@mail.gmail.com>
	 <20070510150225.GS13655@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@dev.mellanox.co.il>
X-From: git-owner@vger.kernel.org Thu May 10 19:40:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmCcr-0005m6-Vu
	for gcvg-git@gmane.org; Thu, 10 May 2007 19:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750992AbXEJRkV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 13:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755992AbXEJRkV
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 13:40:21 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:19395 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbXEJRkU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 13:40:20 -0400
Received: by an-out-0708.google.com with SMTP id d18so163727and
        for <git@vger.kernel.org>; Thu, 10 May 2007 10:40:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BmnjPGF5fB/5EJM0Cm1PDCbcNe4GkfkdDfQbGgVW1bKXeyjmyMkna4s+WIKz9Dicn4G1CohvUvNpVygxLmPRSBAkWZLYZWKshD3mDD3xkWlqJJ64r93OfGR/caW2lxW9AI0u03mlApwNL88wwbeQTcYJ+S0XA89gwUS0wSl6/9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GiJdGi7dCAlSTfPhd4XH0/P7X1wjsBIRhPqMpjZmPmDzpWjbocHNjgVK6Y4bTy3lKDFn6EeFPYbuB5ERGzZfBQnMNUtmGW9VDqXM8O4nzl5ycuHYjDPUlxYgvTGwYB8xRm3HdCwl91u0bixJhk1cyCSR8o6hWnwo7xI7hZcAtG4=
Received: by 10.100.122.8 with SMTP id u8mr1550177anc.1178818819074;
        Thu, 10 May 2007 10:40:19 -0700 (PDT)
Received: by 10.100.225.3 with HTTP; Thu, 10 May 2007 10:40:18 -0700 (PDT)
In-Reply-To: <20070510150225.GS13655@mellanox.co.il>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46882>

On 5/10/07, Michael S. Tsirkin <mst@dev.mellanox.co.il> wrote:
>
> Do you really have git servers accessed over a local lan or on local system?

Yes and yes.

> I just use ssh in this case, and I think that's the common case ...

not on windows

> We *could* try doing something smart with non-blocking connect + select,
> and only print the message if it takes > 1 second. Are you
> sure it's worth the complication?

I'm not sure this suggestion of yours is worth the complication.
Besides, it's hard to get portably
