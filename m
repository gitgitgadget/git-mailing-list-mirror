From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg-tred: Print the transitive reduction of the 
	dependecies
Date: Wed, 25 Mar 2009 12:24:40 +0100
Message-ID: <36ca99e90903250424l534bde1frcd11f1c453c02534@mail.gmail.com>
References: <1237977341-32173-1-git-send-email-bert.wesarg@googlemail.com>
	 <20090325105841.GB27803@pengutronix.de>
	 <36ca99e90903250420l42a46718x91263b4adb7da45f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Wed Mar 25 12:26:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmRFQ-0000lQ-Be
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 12:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbZCYLYp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 07:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbZCYLYp
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 07:24:45 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:37027 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838AbZCYLYo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 07:24:44 -0400
Received: by ewy9 with SMTP id 9so2476901ewy.37
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 04:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oATDiT256QGe9PqrXq99B3k3JJnY09N/ARiJAZsUuoA=;
        b=ToBxOmkppZyaybLmelAYypYV6qY/WZcWiuDRl+b2XH/sJYi2sBxwrJWfRHzaDirI23
         OOa/2+NtCoArmGSPA2DYjIiOyPQ7QVv8XE04Idrkx7+Xv55Q2l0xeryE+IcSLB+N70pA
         U9EvO5b5sGxi3zN4q8D2NLwcdgVyE9drvMkdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SLD0H4qG4rjst8Adyl2lQ9Jo86sdTYzIrhzFW5DtLKq/ggr+IiLbLQVN6oNwa/liPx
         e6hIV0aNpSDhCJ7S3Su8DjBtaIOSRPRV4romfforxgKZ66nxP7+vxHbua374E6QzuxmA
         mMQ671BJ3tnhsrVA49Clc7XC1qfSgS1kmG64k=
Received: by 10.211.178.8 with SMTP id f8mr985638ebp.91.1237980280878; Wed, 25 
	Mar 2009 04:24:40 -0700 (PDT)
In-Reply-To: <36ca99e90903250420l42a46718x91263b4adb7da45f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114587>

>> if master is redundant. =C2=A0Is this asserted?
> I asked this myself, I haven't looked very deeply but I think it is
> stable. And some tests showed this.
BTW: Because of this uncertainty I implemented it so, that it just
shows the reduced dep list not alter the current one. Anyway, you can
always check what changed with my diff example.
