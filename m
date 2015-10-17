From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git tag --contains now takes a long time
Date: Sat, 17 Oct 2015 17:58:41 +0200
Message-ID: <vpqmvvhpjv2.fsf@grenoble-inp.fr>
References: <20151016220739.GF17700@cantor.redhat.com>
	<CAOLa=ZTDd3MSmqXArtNz8i5n=uj2NEB6UPk2jSnEhUsAqbr7nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jerry Snitselaar <jsnitsel@redhat.com>, Git <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 17 17:58:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZnTsj-00052A-P9
	for gcvg-git-2@plane.gmane.org; Sat, 17 Oct 2015 17:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbbJQP6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2015 11:58:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:39286 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752435AbbJQP6t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Oct 2015 11:58:49 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t9HFwdiG023089
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Sat, 17 Oct 2015 17:58:39 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t9HFwfbN026183;
	Sat, 17 Oct 2015 17:58:41 +0200
In-Reply-To: <CAOLa=ZTDd3MSmqXArtNz8i5n=uj2NEB6UPk2jSnEhUsAqbr7nQ@mail.gmail.com>
	(Karthik Nayak's message of "Sat, 17 Oct 2015 12:14:58 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 17 Oct 2015 17:58:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t9HFwdiG023089
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1445702320.20924@/RsFG22K2PJ7f2l/S0wLxQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279789>

Karthik Nayak <karthik.188@gmail.com> writes:

> Could you Squash that in, Junio?

The guilty commit is in master, so you'll need a new commit to fix the
old one. Can you send a patch with a proper commit message (referencing
b7cc53e92c806b73e14b03f60c17b7c29e52b4a4)?

We should both have catched this earlier (by review and/or benchmark).
Sorry we didn't, and thanks to Jerry for the report.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
