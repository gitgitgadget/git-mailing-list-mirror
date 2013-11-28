From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: [RFC PATCH] disable complete ignorance of submodules for
	index <-> HEAD diff
Date: Thu, 28 Nov 2013 08:10:01 +0100
Message-ID: <20131128071001.GA1057@book.hvoigt.net>
References: <20131122151120.GA32361@sigill.intra.peff.net> <CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com> <CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com> <CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com> <CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com> <CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com> <528FC638.5060403@web.de> <20131122215454.GA4952@sandbox-ub> <20131123011145.GB4952@sandbox-ub> <CAErtv26e1NxmsBLH_2KuzBECiwZvyvstqXoK5Vybk9xpsaaO9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Sergey Sharybin <sergey.vfx@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 28 08:10:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vlvjt-0001dU-SY
	for gcvg-git-2@plane.gmane.org; Thu, 28 Nov 2013 08:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384Ab3K1HKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Nov 2013 02:10:13 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.24]:40908 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab3K1HKM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Nov 2013 02:10:12 -0500
Received: from [77.20.34.36] (helo=book.hvoigt.net)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1Vlvjj-0007Nz-6a; Thu, 28 Nov 2013 08:10:07 +0100
Content-Disposition: inline
In-Reply-To: <CAErtv26e1NxmsBLH_2KuzBECiwZvyvstqXoK5Vybk9xpsaaO9Q@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238473>

On Mon, Nov 25, 2013 at 03:01:34PM +0600, Sergey Sharybin wrote:
> Tested the patch. `git status` now shows the changes to the
> submodules, which is nice :)
> 
> However, is it possible to make it so `git commit` lists submodules in
> "changes to be committed" section, so you'll see what's gonna to be in
> the commit while typing the commit message as well?

Yes, of course that should be shown. Will add in the next iteration.
Which will hopefully be a much simpler implementation. Possibly getting
rid of this new flag.

Cheers Heiko
