From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [PATCH 0/4] bash: support user-supplied completion scripts for custom
	git commands and aliases
Date: Tue, 23 Feb 2010 22:02:56 +0100
Message-ID: <cover.1266958460.git.szeder@ira.uka.de>
References: <20100131191936.GA30466@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	David Rhodes Clymer <david@zettazebra.com>,
	Teemu Matilainen <teemu.matilainen@iki.fi>,
	git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Feb 23 22:03:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk1uc-0002Ey-10
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 22:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332Ab0BWVDR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 16:03:17 -0500
Received: from francis.fzi.de ([141.21.7.5]:22912 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751216Ab0BWVDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 16:03:16 -0500
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 23 Feb 2010 22:03:11 +0100
X-Mailer: git-send-email 1.7.0.119.g9b76
In-Reply-To: <20100131191936.GA30466@neumann>
X-OriginalArrivalTime: 23 Feb 2010 21:03:11.0471 (UTC) FILETIME=[9B8F6FF0:01CAB4CB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140833>

Hi,

here is the full series, extended for aliases.

I didn't want to push an obviously post-v1.7.0 change during the -rc
period, and then forgot about it until Teemu (on CC) sent similar
patches today[*].  His two patches do basically the same as my 2/4 (wit=
h
minor differences).

Junio was concerned about possible namespace issues.  This series does
not addresses his concern, but I have some thoughts about it, and I wil=
l
try to discuss it after dinner.

Best,
G=C3=A1bor

[*] gmane: http://thread.gmane.org/gmane.comp.version-control.git/14080=
4
    message id: <1266936193-10644-1-git-send-email-teemu.matilainen@iki=
=2Efi>


SZEDER G=C3=A1bor (4):
  bash: improve aliased command recognition
  bash: support user-supplied completion scripts for user's git
    commands
  bash: support user-supplied completion scripts for aliases
  bash: completion for gitk aliases

 contrib/completion/git-completion.bash |   94 ++++++++++++------------=
--------
 1 files changed, 34 insertions(+), 60 deletions(-)
