From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 0/2] gitk --color-words
Date: Sat, 3 Apr 2010 20:06:18 +0200
Message-ID: <cover.1270317502.git.trast@student.ethz.ch>
References: <cover.1269996525.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eelis van der Weegen <eelis@eelis.net>,
	Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 03 20:06:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ny7jp-0005Nc-J7
	for gcvg-git-2@lo.gmane.org; Sat, 03 Apr 2010 20:06:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755733Ab0DCSGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Apr 2010 14:06:24 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:44362 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755750Ab0DCSGX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Apr 2010 14:06:23 -0400
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 3 Apr
 2010 20:06:21 +0200
Received: from localhost.localdomain (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sat, 3 Apr
 2010 20:06:21 +0200
X-Mailer: git-send-email 1.7.0.4.504.g4d2c
In-Reply-To: <cover.1269996525.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143891>

So here's a version intended for application.

[1/2] gained tests and docs.

[2/2] now disables the word-diff code for merge commits, since the
underlying --color-words also just gives up and shows a combined
diff.  It also patches /gitk, i.e., it's intended for application
inside the subtree.

I wasn't really sure about the last point -- this makes things a bit
complicated since Paul will have to apply 2/2, and Junio will have to
take care to only pull from Paul once 1/2 is in.


Thomas Rast (2):
  Add diff --porcelain option for --color-words
  gitk: add the equivalent of diff --color-words
