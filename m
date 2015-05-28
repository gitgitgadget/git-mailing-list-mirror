From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH v2 0/2] config: list only variable names for completion
Date: Thu, 28 May 2015 14:29:33 +0200
Message-ID: <1432816175-18988-1-git-send-email-szeder@ira.uka.de>
References: <1432757240-4445-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 14:30:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxwww-0008TZ-Uf
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 14:30:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbbE1MaH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2015 08:30:07 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:41371 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932103AbbE1MaB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2015 08:30:01 -0400
Received: from x590c3072.dyn.telefonica.de ([89.12.48.114] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1YxwwX-0007cw-6j; Thu, 28 May 2015 14:29:50 +0200
X-Mailer: git-send-email 2.4.2.349.g6883b65
In-Reply-To: <1432757240-4445-1-git-send-email-szeder@ira.uka.de>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1432816190.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270143>

=46ixed misspelled option names in docs and in commit message, incorpor=
ated
Peff's suggestions, and renamed 'show_only_keys' to 'omit_values' in 1/=
2.

Only minor tweaking in 2/2's commit message.

SZEDER G=C3=A1bor (2):
  config: add options to list only variable names
  completion: use new 'git config' options to reliably list variable
    names

 Documentation/git-config.txt           | 12 ++++++++++--
 builtin/config.c                       | 17 ++++++++++++++---
 contrib/completion/git-completion.bash | 19 +++++--------------
 t/t1300-repo-config.sh                 | 22 ++++++++++++++++++++++
 4 files changed, 51 insertions(+), 19 deletions(-)

--=20
2.4.2.349.g6883b65
