From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 8/9] git-verify-pack: no need to count errors
Date: Thu, 10 Aug 2006 19:37:18 +0200
Message-ID: <44DB6ECE.10706@lsrfire.ath.cx>
References: <11552221582769-git-send-email-rene.scharfe@lsrfire.ath.cx> <11552221583276-git-send-email-rene.scharfe@lsrfire.ath.cx> <Pine.LNX.4.63.0608101822550.10541@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 10 19:37:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBETK-0007g0-S1
	for gcvg-git@gmane.org; Thu, 10 Aug 2006 19:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422648AbWHJRh1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 10 Aug 2006 13:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422652AbWHJRh1
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Aug 2006 13:37:27 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:58340
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1422648AbWHJRh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Aug 2006 13:37:27 -0400
Received: from [10.0.1.3] (p508E54C8.dip.t-dialin.net [80.142.84.200])
	by neapel230.server4you.de (Postfix) with ESMTP id C291E7004;
	Thu, 10 Aug 2006 19:37:25 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0608101822550.10541@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25203>

Johannes Schindelin schrieb:
> there was no harm done counting the errors, i.e. no need to "fix" tha=
t.

Yes, it's more of a style thing.  Why count when you don't need the
number?  Why use "!!" when you can use "1" explicitly?

And then there's the danger of counter wrap-around. ;-)

It's surely one of those bikeshed colour issues, admittedly.

Thanks,
Ren=E9
