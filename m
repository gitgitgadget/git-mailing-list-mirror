From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] add: warn when -u or -A is used without filepattern
Date: Mon, 28 Jan 2013 09:48:16 +0100
Message-ID: <vpqobg966cv.fsf@grenoble-inp.fr>
References: <vpq1uddoedj.fsf@grenoble-inp.fr>
	<1359110978-20054-1-git-send-email-Matthieu.Moy@imag.fr>
	<7v8v7h3vx8.fsf@alter.siamese.dyndns.org>
	<vpqtxq28v3s.fsf@grenoble-inp.fr>
	<7vehh6v01v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Eric James Michael Ritz <lobbyjones@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 09:48:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzkOY-0002kt-DG
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 09:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755160Ab3A1Is3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 03:48:29 -0500
Received: from mx1.imag.fr ([129.88.30.5]:49193 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754877Ab3A1Is2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 03:48:28 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r0S8mGLh022235
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 28 Jan 2013 09:48:16 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TzkO0-0007Lf-Uk; Mon, 28 Jan 2013 09:48:17 +0100
In-Reply-To: <7vehh6v01v.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 27 Jan 2013 12:33:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 28 Jan 2013 09:48:16 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r0S8mGLh022235
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1359967697.69233@GNv7rO4/0CsN5RMU11RddA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214820>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> Plus, option_with_implicit_dot is used in cut-and-paste ready commands
>> below.
>
> I do not think we should aim for easy cut-and-paste, especially when
> the real purpose of the change is to train people's fingers; the
> message should discouraging cut-and-paste in a case like this, if
> anything.

cut-and-paste readyness is also a way to avoid being ambiguous. If you
tell users to run "git add -u (--update)", you'll always find someone to
type the command as-is and complain about it not working (sadly, the
teacher living inside me is speaking of experience ;-) ).

> But we could obviously do this, if you really want to cut-and-paste.

I was going to do something like this, you've been too quick ;-).

Resend comming soon.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
