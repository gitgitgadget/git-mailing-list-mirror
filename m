From: Thomas Harning <harningt@gmail.com>
Subject: Bug-tracking tools that handle branch/merge/etc
Date: Tue, 4 Mar 2008 17:09:03 -0500
Message-ID: <20080304170903.7b029fc3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 23:10:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWfKv-0001rF-Gw
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 23:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757126AbYCDWJg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 17:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755134AbYCDWJf
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 17:09:35 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:56235 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771AbYCDWJe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 17:09:34 -0500
Received: by wr-out-0506.google.com with SMTP id 50so1591673wra.13
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 14:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=GRvMFCRJF/aazwmNihG3dbi7BRTX/jJSgdtMse1KyOA=;
        b=pYSu4ARG8Gtn8223ybRc1ElFJ9loNkBtngcOtobP3UI4Ce0g6o05mP7UzcRMIMKrSKtkLkRLFOsF2/cyFUdr0H8xqMuaof+XN3W0Df/yQwQF1j+Iuv/xtI0aFLQYUH3U0+5BkRahcfQuRHp7Iy1TRld5VLozIhH00Tn64b2TSAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=OTiivJjz+twE+6h2YOWFG+qgHyKEbJPiTWD6rPWvR/ClLOLMFmKOpLo4cpGLAumrsd26sVabuoUWOS+j7m4tgbpgJD4hBLnqjfYA6Ak4hREpQo8zW7CVnpkDCXlqxQiSfwY9F4orqdvgMqstSakCHthW66u8ksFiWN3NOP0orSE=
Received: by 10.65.110.11 with SMTP id n11mr4081380qbm.46.1204668566931;
        Tue, 04 Mar 2008 14:09:26 -0800 (PST)
Received: from localhost ( [149.164.193.61])
        by mx.google.com with ESMTPS id h17sm6459739wxd.24.2008.03.04.14.09.25
        (version=SSLv3 cipher=OTHER);
        Tue, 04 Mar 2008 14:09:26 -0800 (PST)
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.10.11; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76146>

Partly referring back to the discussion last June
(http://article.gmane.org/gmane.comp.version-control.git/49734)...  has
there been any developments in the area of a BTS that can grok GIT in a
sane way?

Main concept I see as important for a BTS grokking git:
 * Capability of following branches/merges in a way that
   you can see a list of bugs that affect a branch at any point
   in time.

Niceties include:
 * The ability to 'distribute' this so bug tracking is as disconnected
   as coding itself (great for airplane-trip coding sessions)
 * Ability to watch incoming commits (suppose the BTS can 'pull' from
   various sources on occasion) for messages marking a bug as
   in-progress/fixed/re-opened/etc.
 * Local-application GUI integration... ex: gitk/git-gui + BT
