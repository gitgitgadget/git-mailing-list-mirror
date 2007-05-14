From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: git as a backup tool?
Date: Mon, 14 May 2007 13:48:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705141334120.20215@anakin>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 13:49:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnZ3D-0000M5-7x
	for gcvg-git@gmane.org; Mon, 14 May 2007 13:49:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032189AbXENLsv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 07:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032198AbXENLsu
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 07:48:50 -0400
Received: from hoefnix.telenet-ops.be ([195.130.132.54]:41016 "EHLO
	hoefnix.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032189AbXENLst (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 07:48:49 -0400
Received: from astra.telenet-ops.be (astra.telenet-ops.be [195.130.132.58])
	by hoefnix.telenet-ops.be (Postfix) with ESMTP id A670E9C2DD
	for <git@vger.kernel.org>; Mon, 14 May 2007 13:48:48 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by astra.telenet-ops.be (Postfix) with SMTP id 20AD3380E7;
	Mon, 14 May 2007 13:48:27 +0200 (CEST)
Received: from anakin.of.borg (d54C15D55.access.telenet.be [84.193.93.85])
	by astra.telenet-ops.be (Postfix) with ESMTP id 081D4380DD;
	Mon, 14 May 2007 13:48:27 +0200 (CEST)
Received: from anakin.of.borg (geert@localhost [127.0.0.1])
	by anakin.of.borg (8.13.8/8.13.8/Debian-3) with ESMTP id l4EBmQU3022519
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 May 2007 13:48:26 +0200
Received: from localhost (geert@localhost)
	by anakin.of.borg (8.13.8/8.13.8/Submit) with ESMTP id l4EBmQT8022516;
	Mon, 14 May 2007 13:48:26 +0200
X-Authentication-Warning: anakin.of.borg: geert owned process doing -bs
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47231>

	Hi,

Has anyone considered using git as a backup tool?  I.e.
  - put your whole file system in git
  - do `git add .; git commit -a' from cron
  - copy .git to external media once in a while
  - clean up old stuff (unused and older than xx days) from .git

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
