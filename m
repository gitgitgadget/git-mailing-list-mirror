From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4 2/2] post-receive-email: deprecate script in favor of git-multimail
Date: Mon, 15 Jul 2013 10:29:46 +0200
Message-ID: <vpqoba4gr9h.fsf@anie.imag.fr>
References: <1373789343-3189-1-git-send-email-mhagger@alum.mit.edu>
	<1373789343-3189-3-git-send-email-mhagger@alum.mit.edu>
	<20130715060245.GD2962@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Chris Hiestand <chrishiestand@gmail.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Michiel Holtkamp <git@elfstone.nl>,
	Stefan =?iso-8859-1?Q?N=E4we?= <stefan.naewe@gmail.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 10:30:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyeAl-0003pE-Ia
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 10:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754486Ab3GOIaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 04:30:11 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60384 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754468Ab3GOIaI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 04:30:08 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r6F8Tk1T029131
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 15 Jul 2013 10:29:48 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UyeAF-0005hk-14; Mon, 15 Jul 2013 10:29:47 +0200
In-Reply-To: <20130715060245.GD2962@elie.Belkin> (Jonathan Nieder's message of
	"Sun, 14 Jul 2013 23:02:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 15 Jul 2013 10:29:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r6F8Tk1T029131
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1374481793.96775@lo4lxNjMz7+5eI7BRhJEFw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230438>

Jonathan Nieder <jrnieder@gmail.com> writes:

> (3)
> 	# An example hook ...
> 	#
> 	# Warning: this script is no longer actively maintained.  Consider
> 	# switching to ...
>
> I prefer (2), which makes it clear to the reader that it is dangerous
> to keep using the script (since no one is actively chasing down bugs)
> while also making it clear why a potentially buggy script with a good
> natural successor is still in contrib for now.  What do you think?

I don't think it is dangerous to keep using the old script. If you look
at its history, it's pretty stable these day. I think it has known bugs
in new revision detections that are fixed by git-multimail, but nothing
really blocking IMHO.

There are two good reasons to use it: 1) you already use it, and you're
too lazy to change (e.g. because it's packaged by Debian and is already
there on your server), and 2) you don't have Python on your server.

I think the notice still deserve the "***NOTICE***" or whatever makes it
visible enough to distinguish it from the traditional licence &
non-warranty header, but I don't think we should kill the old script too
early.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
