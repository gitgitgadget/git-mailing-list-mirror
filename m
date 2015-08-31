From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Running interpret-trailers automatically on each commit?
Date: Mon, 31 Aug 2015 10:12:32 +0200
Message-ID: <vpqmvx7ho5r.fsf@anie.imag.fr>
References: <55E07CB1.0@game-point.net>
	<xmqqk2sf2vic.fsf@gitster.mtv.corp.google.com>
	<55E09540.60805@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Mon Aug 31 10:12:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWKCs-0005Fn-9q
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 10:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbbHaIMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 04:12:42 -0400
Received: from mx2.imag.fr ([129.88.30.17]:45030 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbbHaIMk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 04:12:40 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t7V8CV8R012396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 31 Aug 2015 10:12:32 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7V8CWim009727;
	Mon, 31 Aug 2015 10:12:32 +0200
In-Reply-To: <55E09540.60805@game-point.net> (Jeremy Morton's message of "Fri,
	28 Aug 2015 18:07:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 31 Aug 2015 10:12:32 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7V8CV8R012396
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1441613552.99549@gAQFD0WI7/QVkxXeud82Fw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276854>

Jeremy Morton <admin@game-point.net> writes:

> Yeah but it's kind of useless to me having it on each commit on a
> per-repo basis (and even then, only with hooks).

Please, don't top-post on this list.

Actually, it seems strange to me to activate it on a per-user basis.
Whether you add a trailer is usually a per-project policy. If you add a
branch trailer in each of your repository, it seems likely that some
projects you contribute to will be bothered by this.

That said, I agree it would be nice to allow a configuration-based
mechanism in addition to the current hook-based one we currently have.
But no one stepped in to implement it until now ...

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
