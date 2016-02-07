From: Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Subject: Re: git show doesn't work on file names with square brackets
Date: Sun, 7 Feb 2016 18:09:35 +0300
Message-ID: <CABCFD40-C1B8-412C-90E3-24147AA6AFA5@jetbrains.com>
References: <6A7D4447-AC25-4591-9DA7-CD153198EC64@jetbrains.com> <alpine.DEB.2.20.1602061518220.2964@virtualbox> <25D155FA-6F05-425C-AB2D-7F0B44E0D1C5@jetbrains.com> <alpine.DEB.2.20.1602061708220.2964@virtualbox>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 07 16:09:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSQyC-00070Y-QN
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 16:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902AbcBGPJj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2016 10:09:39 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:36363 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885AbcBGPJi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2016 10:09:38 -0500
Received: by mail-lb0-f176.google.com with SMTP id dx2so71589220lbd.3
        for <git@vger.kernel.org>; Sun, 07 Feb 2016 07:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jetbrains-com.20150623.gappssmtp.com; s=20150623;
        h=from:content-type:mime-version:subject:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=a3b+urwgA/WRiUqcOEJyFBayJPf11kr1zwkq743gRUY=;
        b=JI6RWh8ge+OmHTUxi+I2AF5wCavkmDMm4oun4zxvE1AD6S2XZxe0zEAGPIEFwnPzi/
         66kfRdQSjgtpSM4QD0dd94bxBznNMjqZXndwCDeyMDWMONlxxxpu3hn+Xq2c1RRufvxh
         0WwBvdUBcmjhJBBWhn93AF9BZaRuy8DOK9u51UOGrzj53MVDJnBsGvgdyhj5n4U0ThDc
         ZXk+SNy3rHm/Y2R9El3WQC3N+0IyMz5jjIlCgVnuulJlWd8/88J1Y5Fz4ag+ODjcarC3
         TJuc1wkkOurRJJSPu3eI6cp46kD1mz6+Fyjn0dVM9TBL7Hz7Q2DQNCc8Yi7wZswPgRx4
         oaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-type:mime-version:subject
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=a3b+urwgA/WRiUqcOEJyFBayJPf11kr1zwkq743gRUY=;
        b=Z+uH4upfmQl3MMOS6fhxIZox46j63c1LIU2FHimbhgrdpRr7JagAf9TmXDLMMqXxtE
         IsRvZjL5+TFG7QkeJ6+c6E4cgI7GoyBkklqtVEnqvcy19D9todEZ/Td4pXBhg44UGMki
         xO7IRBZJ8xSgqc7YiyXt9dpwXw1Thx8LMrEbLXXtkDyS0V4/icxqiud7U7LAI4iOPapI
         WCU2QqNPsWTbx0puAYpd6TBgpfQlOdnjR7RHY4rnDM+lVkA9lOpCB0n0VFtMVneDJUgD
         NaUMPWyTF5hXt5y2eAga+rhss7q2QFYxjO7BncJvoO6K540Wit5D1x3YADshgKNmNYLP
         Behg==
X-Gm-Message-State: AG10YOQWQhQBWQMr6EDk+N/UCmEw0AoDPdxAnzsMnxsNlj3//sL1dGjJBQiH9uQUQzdxWzd6
X-Received: by 10.112.147.1 with SMTP id tg1mr8001636lbb.119.1454857777185;
        Sun, 07 Feb 2016 07:09:37 -0800 (PST)
Received: from loki.labs.intellij.net ([80.76.244.114])
        by smtp.gmail.com with ESMTPSA id ke9sm3325450lbc.28.2016.02.07.07.09.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 07 Feb 2016 07:09:36 -0800 (PST)
X-Google-Original-From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
In-Reply-To: <alpine.DEB.2.20.1602061708220.2964@virtualbox>
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285730>

Hi Johannes,

> On 06 Feb 2016, at 19:10 , Johannes Schindelin <Johannes.Schindelin@g=
mx.de> wrote:
>=20
> 	git show 'HEAD:bra[ckets].txt' --
>=20

Nice catch! It works for me even without quotes. Although this =E2=80=9C=
--=E2=80=9C is mentioned in the error message, I didn=E2=80=99t even tr=
y since its meaning is totally unrelated with the problem ;) Anyway, th=
anks a lot for finding the workaround.