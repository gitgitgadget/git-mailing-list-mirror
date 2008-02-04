From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 0/4] Introduce the .git-file
Date: Mon,  4 Feb 2008 21:59:17 +0100
Message-ID: <1202158761-31211-1-git-send-email-hjemli@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 22:02:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM8S3-0008Ne-Nk
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 22:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbYBDVBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 16:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbYBDVBV
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 16:01:21 -0500
Received: from mail42.e.nsc.no ([193.213.115.42]:46942 "EHLO mail42.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752750AbYBDVBU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 16:01:20 -0500
Received: from localhost.localdomain (ti231210a341-0149.bb.online.no [88.88.168.149])
	by mail42.nsc.no (8.13.8/8.13.5) with ESMTP id m14L0REc021902;
	Mon, 4 Feb 2008 22:00:28 +0100 (MET)
X-Mailer: git-send-email 1.5.4.5.g25d066
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72569>

This is a resend of my previous patches + an update to make git-submodule
work with the .git-file + a litte documentation.

PS: Regarding the color of the bikeshed, it seems that everyone can live
with  "gitdir:" so that's what I ended up using.

Diffstat:
 Documentation/repository-layout.txt |    5 ++-
 git-submodule.sh                    |    4 +-
 setup.c                             |   40 +++++++++++++++++++
 t/t0002-gitfile.sh                  |   71 +++++++++++++++++++++++++++++++++++
 4 files changed, 117 insertions(+), 3 deletions(-)
