Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBE371FEAA
	for <e@80x24.org>; Mon, 20 Jun 2016 22:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbcFTWQa (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 18:16:30 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:39502 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751646AbcFTWQ3 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 18:16:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 4D5F825F5;
	Tue, 21 Jun 2016 00:16:25 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9ebJaJBpWLzF; Tue, 21 Jun 2016 00:16:25 +0200 (CEST)
Received: from zm-int-mbx6.grenet.fr (zm-int-mbx6.grenet.fr [130.190.242.145])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 3566825F1;
	Tue, 21 Jun 2016 00:16:25 +0200 (CEST)
Date:	Tue, 21 Jun 2016 00:25:17 +0200 (CEST)
From:	Antoine Queru <antoine.queru@ensimag.grenoble-inp.fr>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Antoine Queru <Antoine.Queru@grenoble-inp.org>,
	git@vger.kernel.org,
	william duclot <william.duclot@ensimag.grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	rsbecker@nexbridge.com, aaron@schrab.com,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, peff@peff.net
Message-ID: <1599012395.707458.1466461517473.JavaMail.zimbra@ensimag.grenoble-inp.fr>
In-Reply-To: <3899461F-44B4-407F-ACCE-793E65486554@gmail.com>
References: <20160604145101.21928-1-Antoine.Queru@grenoble-inp.org> <998280064.353519.1465213163063.JavaMail.zimbra@ensimag.grenoble-inp.fr> <2104102670.380496.1465220639026.JavaMail.zimbra@ensimag.grenoble-inp.fr> <3899461F-44B4-407F-ACCE-793E65486554@gmail.com>
Subject: Re: [RFC/PATCH] push: deny policy to prevent pushes to unwanted
 remotes.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF46 (Linux)/8.0.9_GA_6191)
Thread-Topic: push: deny policy to prevent pushes to unwanted remotes.
Thread-Index: L7rHZ7FEDIj4f3gNtFY4ciI871yoHQ==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> 
> >> ...
> >> 
> > 
> > Hello Rémi, thanks you for your input ! I'll make the appropriate changes
> > and send a new version as soon as i can !
> 
> Hi Antoine,
> 
> do you have an updated version already or is this the one I should look at?
> http://article.gmane.org/gmane.comp.version-control.git/296445
> 
> Thanks,
> Lars

Hello Lars ! I'm actually in holidays, but I will try to send a new
version by the end of the week, it's nearly done. The code has been
refactored with what Matthieu and Remi told, so don't bother to read
the last version.

However, in the last version, if we want to deny an website,
including all schemes, we can blacklist the url without the
scheme. For example, "pushBlacklist = github.com". By doing so, this
remote is not an url anymore, and it can't be differenced with a local
relative path. It's a problem because these two have a different
treatement. The choice we made to solve this is to force the user to
put the scheme "file://" before any local relative path. What do you
think ?

Antoine
