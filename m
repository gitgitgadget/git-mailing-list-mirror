From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH/RFC] git-remote-mediawiki: new tool to preview local changes without pushing
Date: Sun, 09 Jun 2013 16:37:24 +0200
Message-ID: <vpqfvwrs63f.fsf@anie.imag.fr>
References: <1370641831-9115-1-git-send-email-benoit.person@ensimag.fr>
	<20130609060807.GA8906@sigill.intra.peff.net>
	<CAETqRCh9frekD8yiR0bE+WQ7b_et1th8p_LsqrL8NhPnC8yaow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?iso-8859-1?Q?C=E9l?= =?iso-8859-1?Q?estin?= Matte 
	<celestin.matte@ensimag.fr>
To: =?iso-8859-1?Q?Beno=EEt?= Person <benoit.person@ensimag.fr>
X-From: git-owner@vger.kernel.org Sun Jun 09 16:37:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlgkZ-0003Yo-79
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 16:37:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897Ab3FIOhi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 10:37:38 -0400
Received: from mx1.imag.fr ([129.88.30.5]:59459 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753234Ab3FIOhi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 10:37:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r59EbNqw024191
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 9 Jun 2013 16:37:23 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UlgkG-0003gh-IS; Sun, 09 Jun 2013 16:37:24 +0200
In-Reply-To: <CAETqRCh9frekD8yiR0bE+WQ7b_et1th8p_LsqrL8NhPnC8yaow@mail.gmail.com>
	(=?iso-8859-1?Q?=22Beno=EEt?= Person"'s message of "Sun, 9 Jun 2013
 14:35:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Sun, 09 Jun 2013 16:37:24 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r59EbNqw024191
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1371393447.10334@oN+zIoc9SpvlEDnRPYFwXQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226962>

Beno=EEt Person <benoit.person@ensimag.fr> writes:

> On 9 June 2013 08:08, Jeff King <peff@peff.net> wrote:
>> I also wonder if it would be useful to be able to specify not only f=
iles
>> in the filesystem, but also arbitrary blobs. So in 4b above, you cou=
ld
>> "git mw preview origin:page.mw" to see the rendered version of what
>> upstream has done.
>
> Hum, so `git mw preview origin:page.mw` would just do the get
> request to the remote mediawiki, save it locally and - maybe - load i=
t
> in the browser ? Is it really better than just opening the browser an=
d
> typing the right URL ?
>
> Currently, this URL is one click away when you have preview file load=
ed
> in a web browser.

origin:page.mw is not necessarily the best example, but HEAD^:page.mw
can exist in your local history and not on the wiki. Even HEAD:page.mw
can be interesting if you have uncommited changes. Not that it's
terribly useful to be able to preview it, but once you can deal with
local files, it should be easy enough to generalize it to any blob.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
