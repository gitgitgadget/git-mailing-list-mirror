From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3] daemon: give friendlier error messages to clients
Date: Sat, 15 Oct 2011 03:26:47 -0500
Message-ID: <20111015082647.GA7302@elie.hsd1.il.comcast.net>
References: <7vvcrs181e.fsf@alter.siamese.dyndns.org>
 <20111014131041.GC7808@sigill.intra.peff.net>
 <20111014192326.GA7713@sigill.intra.peff.net>
 <20111014210251.GD16371@elie.hsd1.il.comcast.net>
 <20111014211244.GA16429@sigill.intra.peff.net>
 <20111014211921.GB16429@sigill.intra.peff.net>
 <CAMK1S_g0aKUa=+ndAm7rqeoPAobjVb6oJ1Z4DqSeNrdauXNH3w@mail.gmail.com>
 <7vk486x0hq.fsf@alter.siamese.dyndns.org>
 <CAMK1S_gkB49qhnt8U=3G3UPnjo2vzFx5mL4cOM1Ubu68ySJrDA@mail.gmail.com>
 <m3r52e7js7.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 15 10:27:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REzaM-0001HG-2i
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 10:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843Ab1JOI1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 04:27:03 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:45749 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678Ab1JOI1B (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 04:27:01 -0400
Received: by iaek3 with SMTP id k3so3596462iae.19
        for <git@vger.kernel.org>; Sat, 15 Oct 2011 01:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PPvMnaDp6YmIUL8LplGDjVbFy7jiyxft9oUAx5DOwxU=;
        b=KEiS8IThUt9C/IGMfJFplwGTqETTcruTFjfSZGZgogDYxNYz9qIkgQ1XL7cc8CUw8V
         GzLSLivH41hMht7xLYdiBUc6zJu94DTYaeOAGZmTz/C9mbIk0hzdjYmetmkr/hfSyz+c
         OjQgZK4haTgmTHEJS/uTv9OFkf3jXBJBgIDtw=
Received: by 10.42.159.1 with SMTP id j1mr22069333icx.20.1318667220588;
        Sat, 15 Oct 2011 01:27:00 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id g16sm15934230ibs.8.2011.10.15.01.26.59
        (version=SSLv3 cipher=OTHER);
        Sat, 15 Oct 2011 01:27:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m3r52e7js7.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183647>

Jakub Narebski wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:

>> "Access denied or no such repo" is much better.  (The "not exported"
>> nuance is not relevant in this context; you can safely ignore it.)
>
> To join this bike-shedding:
>
>   "Access denied or repository not available"
>
> or just
>
>   "Repository not available"

If such details about the message matter, then I have to say that
Sitaram's "access denied or no such repository" is as close to perfect
as I can imagine.  The admin who is eventually forwarded this message
will be reminded to check two things:

 - that access is not denied, neither globally, using a whitelist,
   using filesystem permissions, nor by leaving out
   git-daemon-export-ok, and

 - that such a repo exists at all, and there was not a typo in the
   address.
