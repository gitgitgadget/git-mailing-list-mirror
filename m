From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCHv3 0/2] 'git config --names-only' to help the completion script
Date: Mon, 10 Aug 2015 11:46:05 +0200
Message-ID: <1439199967-9655-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Christian Couder <christian.couder@gmail.com>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:46:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjfW-0001KZ-TE
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754694AbbHJJqo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2015 05:46:44 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:50865 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754652AbbHJJql (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 05:46:41 -0400
Received: from x590c3bfd.dyn.telefonica.de ([89.12.59.253] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 25 
	iface 141.3.10.81 id 1ZOjf0-0006Y1-Qr; Mon, 10 Aug 2015 11:46:32 +0200
X-Mailer: git-send-email 2.5.0.245.gff6622b
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1439199992.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275586>

This is a reroll of 'sg/config-name-only'.

  * Instead of the two new listing options of the previous round add on=
e
    new option '--names-only' to modify the output of '--list' and
    '--get-regexp' options, as suggested in previous discussions.
  * Reorganized the commit messages: don't go into details of the
    completion bug in the first patch modifying builtin/config.c, talk
    about that in the second patch.

SZEDER G=C3=A1bor (2):
  config: add '--names-only' option to list only variable names
  completion: list variable names reliably with 'git config
    --names-only'

 Documentation/git-config.txt           | 10 +++++++---
 builtin/config.c                       | 14 ++++++++++++--
 contrib/completion/git-completion.bash | 16 ++++------------
 t/t1300-repo-config.sh                 | 22 ++++++++++++++++++++++
 4 files changed, 45 insertions(+), 17 deletions(-)

--=20
2.5.0.245.gff6622b
