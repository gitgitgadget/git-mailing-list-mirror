From: Pierre Habouzit <madcoder@debian.org>
Subject: [take 2] git send-email updates
Date: Tue,  4 Nov 2008 17:24:13 +0100
Message-ID: <1225815858-30617-1-git-send-email-madcoder@debian.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 04 17:25:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxOio-0006x8-E9
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 17:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788AbYKDQYX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Nov 2008 11:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754729AbYKDQYW
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 11:24:22 -0500
Received: from pan.madism.org ([88.191.52.104]:54650 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754004AbYKDQYW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 11:24:22 -0500
Received: from madism.org (unknown [213.223.38.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 10EEF3BFD0
	for <git@vger.kernel.org>; Tue,  4 Nov 2008 17:24:21 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 5D402384EA; Tue,  4 Nov 2008 17:24:18 +0100 (CET)
X-Mailer: git-send-email 1.6.0.3.844.gcde3
In-Reply-To: <1225450632-7230-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100085>

  [PATCH 1/5] git send-email: make the message file name more specific.
    self described

  [PATCH 2/5] git send-email: interpret unknown files as revision lists
    All unknown arguments are passed to git-format-patch at once,
    checking for possible file/rev conflicts and dying in that case,
    like Junio suggested.

  [PATCH 3/5] git send-email: add --annotate option
    same as before.

  [PATCH 4/5] git send-email: ask less questions when --compose is used=
=2E
    same as before, with an update wrt empty bodies. Still doesn't grok
    To/Cc/Bcc. I would be really glad if a patch to deal with it was
    appended to that series, but a patch that deals with Header
    continuations well.

  [PATCH 5/5] git send-email: turn --compose on when more than one patc=
h.
    This patch is probably controversial. I propose it not because I'm
    lazy, I now have a 'git send' alias for the task that expands to
    'send-email -C -C -M -n --annotate --compose --to'. I propose it
    because I believe it's a good thing to make people write about thei=
r
    stuff when there is a series and not a single patch. If they still
    don't want to, they just have to clear the mail buffer at once.

    The drawback is that it _may_ break some scripts, those people woul=
d
    have to pass --no-compose to their send-email call to fix the
    scripts.

    I wouldn't complain if the patch gets dropped.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g
