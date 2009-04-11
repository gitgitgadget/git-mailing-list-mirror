From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] Add "list" and "rm" sub commands to tg-depend
Date: Sat, 11 Apr 2009 21:29:15 +0200
Message-ID: <36ca99e90904111229l21d34100h8e9295748adc9853@mail.gmail.com>
References: <20090407133329.57b06727.weiny2@llnl.gov>
	 <20090408080824.GF8940@machine.or.cz>
	 <20090408083955.GA28482@pengutronix.de>
	 <20090408091949.8a648d83.weiny2@llnl.gov>
	 <20090409124337.GA6034@pengutronix.de>
	 <20090409091021.5a7ded79.weiny2@llnl.gov>
	 <36ca99e90904091101l6dd1685y5be70dd77bf52b57@mail.gmail.com>
	 <20090409201515.GA4218@pengutronix.de>
	 <36ca99e90904110840g35fa3b37m45f0286cb1f99db6@mail.gmail.com>
	 <20090411190636.GA31461@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ira Weiny <weiny2@llnl.gov>,
	Brian Behlendorf <behlendorf1@llnl.gov>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Sat Apr 11 21:30:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lsiui-0006QP-2w
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 21:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923AbZDKT3T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Apr 2009 15:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753483AbZDKT3S
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 15:29:18 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:50552 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753480AbZDKT3S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Apr 2009 15:29:18 -0400
Received: by fxm2 with SMTP id 2so1534849fxm.37
        for <git@vger.kernel.org>; Sat, 11 Apr 2009 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wB2pOjc2GKwSFff4yM4rw8GyTx0TU2Jd+rbAlY7OaPE=;
        b=VeAZU8cypGUvI9b0+T9sN3h1ec3XJj4X7+Aj9G262tiNMPWgVYrFtFNHRHqXHlPXn4
         EfuLW4Nk3LKj3YT27W6LszbyunjtvKp3qlHQBJgJLaLWbNRpydFDZL4kJh68wZu7KyaX
         Rb6T081E23+5Jfezyl53kHY1p4cnn1sKEZDww=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PJjrSLhGHy2gdTqfCskH8Xib2NGz6NamYp5ugZJMgo+avRDzzQITHUQBQVJaArtWlH
         66wexyl6OYGKtp4J3Kf0gYEtnhQOwbcgcAihANVkGMYZ5zeEU1f4dr79Xrv8lMXNK2tp
         r1kpMO936d7m0bq7t0ifV3LdyAabnCJYcQ6TQ=
Received: by 10.223.111.134 with SMTP id s6mr1346267fap.60.1239478155878; Sat, 
	11 Apr 2009 12:29:15 -0700 (PDT)
In-Reply-To: <20090411190636.GA31461@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116333>

2009/4/11 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
>> [1] http://thread.gmane.org/gmane.comp.version-control.git/95458/foc=
us=3D96093
> This link isn't optimal. =C2=A0The highlighted message doesn't contai=
n the
> citations above :-/.
Sorry, haven't checked this. Here are the links again:

http://article.gmane.org/gmane.comp.version-control.git/96398
http://article.gmane.org/gmane.comp.version-control.git/96560

Bert
>
> Best regards
> Uwe
>
> --
> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Uwe Kleine-K=C3=B6=
nig =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0| http://www.pengutronix.de/ =C2=A0|
>
