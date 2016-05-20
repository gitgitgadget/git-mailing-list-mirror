From: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] upload-pack.c: use of parse-options API
Date: Fri, 20 May 2016 08:55:15 +0200 (CEST)
Message-ID: <779725885.10941844.1463727315713.JavaMail.zimbra@imag.fr>
References: <20160518164019.26443-1-Antoine.Queru@ensimag.grenoble-inp.fr> <20160519153903.22104-1-Antoine.Queru@ensimag.grenoble-inp.fr> <431335092.10912437.1463674220365.JavaMail.zimbra@imag.fr> <xmqqa8jmknc7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Antoine Queru <Antoine.Queru@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	william duclot <william.duclot@ensimag.grenoble-inp.fr>,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 20 08:55:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3eLK-0007dA-8U
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 08:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933043AbcETGzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 02:55:23 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50448 "EHLO mx2.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932556AbcETGzW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 02:55:22 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u4K6tFd6002725
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 20 May 2016 08:55:15 +0200
Received: from z8-mb-verimag.imag.fr (z8-mb-verimag.imag.fr [129.88.4.38])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u4K6tFgY014204;
	Fri, 20 May 2016 08:55:15 +0200
In-Reply-To: <xmqqa8jmknc7.fsf@gitster.mtv.corp.google.com>
X-Originating-IP: [129.88.6.115]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF45 (Linux)/8.0.9_GA_6191)
Thread-Topic: upload-pack.c: use of parse-options API
Thread-Index: 7F7fuEd8WPmyvriUS13FXTbpGnBAfQ==
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Fri, 20 May 2016 08:55:15 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u4K6tFd6002725
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@imag.fr
MailScanner-NULL-Check: 1464332115.90063@uiQWVtbYDSyylye0v+lTxQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295150>

Junio Hamano wrote:
> Matthieu Moy <matthieu.moy@grenoble-inp.fr> writes:
> 
> > Antoine.Queru@ensimag.grenoble-inp.fr wrote:
> >> come from the commit (gmane/131517)
> >
> > Please, use a real commit id instead of a Gmane link.
> >
> > We don't know how long Gmane will remain up, but a self
> > reference from Git's history to itself will always remain valid.
> >
> > The following alias is handy for this:
> >
> > [alias]
> >         whatis = show -s --pretty='tformat:%h (%s, %ad)' --date=short
> >
> > In your case it would allow writing:
> >
> > Description for --stateless-rpc and --advertise-refs is taken
> > from commit 42526b4 (Add stateless RPC options to upload-pack,
> > receive-pack, 2009-10-30).
> 
> Good suggestion; a real question may be how you went from
> $gmane/131517 to 42526b4 (I vaguely recall that you have and publish
> a database of sort; this would be a good place to advertise it ;-).

I don't (I think someone has, but I'm not this someone).

I just "git log --grep"-ed the subject line in Git's history.

>     quit after a single request/response exchange

Seems much clearer to me.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
