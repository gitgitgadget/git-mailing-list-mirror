From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 0/5] Some tweaks and enhancements
Date: Fri, 11 May 2007 03:39:58 +0200
Message-ID: <20070511013400.13161.9160.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 11 03:49:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmKGB-0005bJ-Sq
	for gcvg-git@gmane.org; Fri, 11 May 2007 03:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753144AbXEKBt2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 10 May 2007 21:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757654AbXEKBt1
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 21:49:27 -0400
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:41963 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753144AbXEKBt1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 May 2007 21:49:27 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:38577 helo=yoghurt)
	by ch-smtp02.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1HmKEN-00082E-7z; Fri, 11 May 2007 03:47:42 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HmK6x-0003T2-56; Fri, 11 May 2007 03:39:59 +0200
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HmKEN-00082E-7z.
X-Scan-Signature: ch-smtp02.sth.basefarm.net 1HmKEN-00082E-7z 6cf1e89e50da439ad050a7441266416e
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46927>

The first and last patches of this series implements the things Petr
asked for (automatic patch naming with "stg new", and uncommitting to
a specified committish). Number 2 and 3 are small cleanups; 4 is a
refactoring that's useful in its own right, but also makes it easier
to do 5.

--=20
Karl Hasselstr=C3=B6m, kha@treskal.com
      www.treskal.com/kalle
