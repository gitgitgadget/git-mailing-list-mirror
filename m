From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Git an case-insensitive Mac OS X filesystem
Date: Tue, 11 Sep 2012 13:25:11 +0200
Message-ID: <vpqsjaodco8.fsf@bauges.imag.fr>
References: <CAPLaKK71O3RzavOqY2uVC1tUsbs+W6WxJRWuLBDFUvTwojAN-g@mail.gmail.com>
	<CABPQNSYv1hd8RFHfcQ1XTB94nu6xo+tjj4CvWur29152z2dk6A@mail.gmail.com>
	<vpq392og8fg.fsf@bauges.imag.fr>
	<CABPQNSZznFvjCLR7A7sACf9NcESek7DmOeJcSSHFY1cGHwD2Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@entel.upc.edu>,
	git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Sep 11 13:25:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBOau-0002Kf-G3
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 13:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759011Ab2IKLZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 07:25:18 -0400
Received: from mx1.imag.fr ([129.88.30.5]:56788 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758978Ab2IKLZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 07:25:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q8BBKlrj011665
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 11 Sep 2012 13:20:47 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TBOad-0007iE-N7; Tue, 11 Sep 2012 13:25:11 +0200
In-Reply-To: <CABPQNSZznFvjCLR7A7sACf9NcESek7DmOeJcSSHFY1cGHwD2Jg@mail.gmail.com>
	(Erik Faye-Lund's message of "Tue, 11 Sep 2012 13:18:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 11 Sep 2012 13:20:47 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8BBKlrj011665
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1347967249.44859@79hHUb6aXvTOdNNzhe3zmA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205221>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> Yes, but being costly in terms of performance is IMO a lot better than
> corrupting refs, which is what we currently do.

I'm not saying nothing should be done, but I'm not sure packed-refs are
the right solution in the long term. We already have the foo Vs foo/bar
issue (discussed in the "keeping reflog for deleted refs" discussion). I
think the right way would be to re-think the way we map ref name to the
filesystem, with proper escaping of capitals, slashes, ...

But that's a rather big change to do (and I'm unlikely to be the one
volunteering for it :-( )

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
