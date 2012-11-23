From: Sascha Cunz <sascha-ml@babbelbox.org>
Subject: Re: [PATCH] Completion must sort before using uniq
Date: Fri, 23 Nov 2012 13:26:28 +0100
Message-ID: <2630847.8aaR79v5Od@blacky>
References: <002201cdc952$00159c90$0040d5b0$@schmitz-digital.de> <CAFj1UpEMKq9zH3nbLwYrNZRmd52_KEcN5BBrzGg2jxCzd+fsbA@mail.gmail.com> <003b01cdc974$4cdd1900$e6974b00$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: 'Marc Khouzam' <marc.khouzam@gmail.com>, git@vger.kernel.org,
	szeder@ira.uka.de, felipe.contreras@gmail.com
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Fri Nov 23 13:33:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbsRj-0004fk-IX
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 13:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815Ab2KWMdM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 07:33:12 -0500
Received: from babbelbox.org ([83.133.105.186]:52905 "EHLO mail.babbelbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896Ab2KWMdM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 07:33:12 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Nov 2012 07:33:11 EST
Received: (qmail 25528 invoked from network); 23 Nov 2012 12:27:24 -0000
Received: from p54aeac80.dip.t-dialin.net (HELO blacky.localnet) (sascha@babbelbox.org@84.174.172.128)
  by babbelbox.org with ESMTPA; 23 Nov 2012 12:27:24 -0000
User-Agent: KMail/4.9.3 (Linux/3.6.6-gentoo; KDE/4.9.3; x86_64; ; )
In-Reply-To: <003b01cdc974$4cdd1900$e6974b00$@schmitz-digital.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210254>

> I can't see the difference and in fact don't understand uniq's -u option al
> all Linux man pages say: "only print unique lines", but that is what uniq
> does by default anyway?!?

>From the german translation of uniq's man-page, you can deduct that "only 
print unique lines" actually means: "print lines that are _not repeated_ in 
the input".

A short test confirms that. i.e.:

	printf "a\nb\nb\nc\n" | uniq -u

gives:
	a
	c

Sascha
