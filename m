From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: Is there any way to make hooks part of the repository?
Date: Tue, 01 May 2012 13:57:48 -0700
Message-ID: <86r4v3mxf7.fsf@red.stonehenge.com>
References: <CAE1pOi2hr7ewjo5WVDoW0ipYxDVTckr5M_sHNoOQ323=_k754Q@mail.gmail.com>
	<7vipgf8wve.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 22:57:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPK8w-0002Qr-T2
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 22:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897Ab2EAU5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 16:57:50 -0400
Received: from lax-gw17.mailroute.net ([199.89.0.117]:44980 "EHLO
	gw17.lax01.mailroute.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299Ab2EAU5t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 16:57:49 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gw17.lax01.mailroute.net (Postfix) with ESMTP id 5775066654E;
	Tue,  1 May 2012 20:57:49 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from gw17.lax01.mailroute.net ([199.89.0.117])
	by localhost (gw17.lax01.mailroute.net.mailroute.net [127.0.0.1]) (mroute_mailscanner, port 10026)
	with LMTP id C-AOJ7h2nmlU; Tue,  1 May 2012 20:57:48 +0000 (GMT)
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by gw17.lax01.mailroute.net (Postfix) with ESMTP id 47EED66652D;
	Tue,  1 May 2012 20:57:48 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 2D65A130D; Tue,  1 May 2012 13:57:48 -0700 (PDT)
x-mayan-date: Long count = 12.19.19.6.6; tzolkin = 4 Cimi; haab = 9 Uo
In-Reply-To: <7vipgf8wve.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 01 May 2012 13:33:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196746>

>>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:

Junio> By design.  Do you want me to include "rm -fr ~hilco" in some hook of
Junio> git.git repository?

This just came up yesterday at $PRIMARY_CLIENT.  One idea we kicked
around was having a convention for storing the hooks-to-be-populated in
".githooks" in the repository tree, and then having clone notice that
and offer to install them directly if from a trusted source, or at least
move them into a disabled state in .git/hooks otherwise.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
