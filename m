From: Adam Brewster <adambrewster@gmail.com>
Subject: [PATCH v5]
Date: Sat,  5 Jul 2008 17:26:38 -0400
Message-ID: <1215293200-28199-1-git-send-email-adambrewster@gmail.com>
References: <20080705204849.GJ4729@genesis.frugalware.org>
Cc: gitster@pobox.com, mdl123@verizon.net, Johannes.Schindelin@gmx.de,
	jnareb@gmail.com, adambrewster@gmail.com, vmiklos@frugalware.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 23:27:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFFIM-00028d-MK
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 23:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbYGEV0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 17:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753032AbYGEV0r
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 17:26:47 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:47557 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982AbYGEV0r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 17:26:47 -0400
Received: by yw-out-2324.google.com with SMTP id 9so739845ywe.1
        for <git@vger.kernel.org>; Sat, 05 Jul 2008 14:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=dGlaDK2oq2J6BMH2HPO7wJrbcZXItikuOqI3ynK+An8=;
        b=XkDv/luyDF45J7bIz0iVJK0baFFBlenyWUBByrFxKTM9dHHoyXpBCTuPS4oqoi2xE4
         FzT3J1PN0dalbfcZ/F2ywebAuIK+ArgNvJLZmIMd2uCT7E2Ou6rub2UtJ5VgkbCGSosZ
         VT/1QbOlG12ibPH5axVBcZnpaA6ipFKBOlW5s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aI1BU0HougBUbXw8nLKiXT6gX5n6r6ZwFMg39BOrzIhyFvFWCWoyUlKyAGeTxnel1q
         Oi/DMwqwtwBkLe/Gg2odfO8hhUJRklBbsYXXksY+Tn8jl6QGzq0KrlsNRiGMbt/Yfgz8
         +5e3mfcMJN6MCdc35Z4SOX6E0y8QwAj50PZbc=
Received: by 10.150.84.17 with SMTP id h17mr4726658ybb.201.1215293204015;
        Sat, 05 Jul 2008 14:26:44 -0700 (PDT)
Received: from MBE.internal ( [65.96.168.20])
        by mx.google.com with ESMTPS id 9sm2783209yxs.5.2008.07.05.14.26.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Jul 2008 14:26:42 -0700 (PDT)
Received: by MBE.internal (Postfix, from userid 1000)
	id C56B110499B; Sat,  5 Jul 2008 17:26:40 -0400 (EDT)
X-Mailer: git-send-email 1.5.5.1.211.g65ea3.dirty
In-Reply-To: <20080705204849.GJ4729@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87470>


Apparently I'm dumber than I thought.  Here's what they look like without 
random and unnecessary mode changes.  The patch to add git-basis under contrib 
is not affected.

The real reason read_revisions_from_stdin moved to revision.c is because I was 
asked to do it that way.  If my commit message doesn't accurately describe the 
reason for the change, go ahead and edit the message, or let me know what the 
real reason is so I can provide a better message.

Adam
