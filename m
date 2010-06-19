From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/2] git-cvsserver: Minor fixes for oopsies
Date: Sat, 19 Jun 2010 16:06:56 +0000
Message-ID: <1276963618-14662-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 19 18:07:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQ0Zk-0004ov-3s
	for gcvg-git-2@lo.gmane.org; Sat, 19 Jun 2010 18:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab0FSQHL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jun 2010 12:07:11 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:52152 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725Ab0FSQHJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jun 2010 12:07:09 -0400
Received: by mail-wy0-f174.google.com with SMTP id 33so1291912wyb.19
        for <git@vger.kernel.org>; Sat, 19 Jun 2010 09:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=sfRVOTtVI8uiJhn5to0O2Fc40kv0iBi28BuppHMUcuY=;
        b=D9FFCQPHXRfbcmhVtv0J3/S6jRGK6Z/c9y7kX6nxGEamKjR6VX6x16hsAN1jcEZmyO
         tD8wchsV3dXQuhwLcXqQN6clOaKhZN2e1kI7UOy46LcZU8pe4JAGc88K/ViIRjFrVC/B
         Z8o6QIzOtKEJSJSEmuRLhijdtEOIeNZw/R+V0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=ev2C4iOc6axI+SOtAi4YYZT5/iEcGwJxzjlzfREpaSW+ZBvSv5qSrtvk/xfdtQ6jGm
         S7fDPRC2j7YGKGxhNFTv2J4LDMrXnwPAIqYn1URhx3Zqor33ZJ7jCEFNQGFIV703Vvyq
         3woa5xF3KZwHsktDeSOJXC3oeSrOJdtRXTg3s=
Received: by 10.227.145.14 with SMTP id b14mr2472444wbv.93.1276963628400;
        Sat, 19 Jun 2010 09:07:08 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id y31sm7107452wby.16.2010.06.19.09.07.06
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 19 Jun 2010 09:07:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149383>

The original git-cvsserver pserver support had some oops code. There
was a typo in a comment, and the error for invalid password formats
wasn't correct.

As an aside, since the original implementation I've released the code
on CPAN as the Crypt::CVS. That version also has a scramble() function
and exhaustive tests.

It would make a good experimental case for adding dual-life modules to
Git due to its smallness and the inclusion of tests.

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
  git-cvsserver: typo in a comment: bas -> has
  git-cvsserver: fix error for invalid password formats

 git-cvsserver.perl |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)
