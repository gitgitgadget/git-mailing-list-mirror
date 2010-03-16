From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: FEATURE REQUEST: Comment assignment on branches
Date: Tue, 16 Mar 2010 08:33:42 +0100
Message-ID: <vpq4okgd8kp.fsf@bauges.imag.fr>
References: <be8f531d1003150133n3ea64109u7d573dbd533ffa48@mail.gmail.com>
	<20100315213221.GA12941@vidovic>
	<7vhbohi80n.fsf@alter.siamese.dyndns.org>
	<buovdcw6fjj.fsf@dhlpc061.dev.necel.com>
	<7vljdsu7kc.fsf@alter.siamese.dyndns.org>
	<fc339e4a1003152320i12a7d4b2p711f6b5d0eda9bcd@mail.gmail.com>
	<fabb9a1e1003152326m4d67f48bkc207ba7368cb54e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, Junio C Hamano <gitster@pobox.com>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Maxim Treskin <zerthurd@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 08:34:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrRIL-0006YD-08
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 08:34:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966035Ab0CPHeX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 03:34:23 -0400
Received: from mx2.imag.fr ([129.88.30.17]:48563 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966026Ab0CPHeW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 03:34:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o2G7UHnF015811
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 16 Mar 2010 08:30:17 +0100
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NrRHb-00072R-3N; Tue, 16 Mar 2010 08:33:43 +0100
In-Reply-To: <fabb9a1e1003152326m4d67f48bkc207ba7368cb54e4@mail.gmail.com> (Sverre Rabbelier's message of "Tue\, 16 Mar 2010 07\:26\:26 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 16 Mar 2010 08:30:18 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o2G7UHnF015811
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1269329420.25201@cvG7ZVBysIqCbItTAtMwSQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142333>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Which is also why I think it would be nice if we could teach notes to
> annotate branches/tags/the whole shaboodle. I really think that a
> generic way to annotate something under /refs/ would be useful.

meetoo.

Today, we have .git/description which is used by gitweb (and others?)
to say what the repository contains. That would be nice to have the
same thing for branches. Take
http://git.kernel.org/?p=git/git.git;a=summary for example: commits
have a comment, tag have a comment, and branches just say:

10 hours ago 	man 	shortlog | log | tree
10 hours ago 	html 	shortlog | log | tree
22 hours ago 	pu 	shortlog | log | tree
22 hours ago 	next 	shortlog | log | tree
23 hours ago 	master 	shortlog | log | tree
2 days ago 	maint 	shortlog | log | tree
5 days ago 	todo 	shortlog | log | tree

A newbie will have a hard time understanding what "pu" means, while a
one-liner saying (proposed update, may be rewound at any time) would
give most of the required information. Actually, ideally, this could
be a message like commit message (i.e. one-liner, blank line, and
body).

(My 2 cents)

--
Matthieu Moy
http://www-verimag.imag.fr/~moy/
