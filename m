From: Tait <git.git@t41t.com>
Subject: Re: using gvim as editor on Windows
Date: Thu, 11 Mar 2010 01:04:24 -0800
Message-ID: <20100311090424.GV2480@ece.pdx.edu>
References: <20100306070628.GM2480@ece.pdx.edu> <201003061317.38422.markus.heidelberg@web.de> <20100308185439.GO2480@ece.pdx.edu> <201003090032.10037.markus.heidelberg@web.de> <20100309024523.GU2480@ece.pdx.edu> <7vzl2hw972.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 10:05:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpeKD-0006lQ-Vt
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 10:05:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750Ab0CKJEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 04:04:55 -0500
Received: from ehlo.cat.pdx.edu ([131.252.208.106]:36531 "EHLO
	ehlo.cat.pdx.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129Ab0CKJEx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 04:04:53 -0500
Received: from nemo.ece.pdx.edu (root@nemo.ece.pdx.edu [131.252.209.162])
	by ehlo.cat.pdx.edu (8.14.2/8.14.2/Debian-2build1) with ESMTP id o2B94Pn0028536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 11 Mar 2010 01:04:25 -0800
Received: from nemo.ece.pdx.edu (tait@localhost [127.0.0.1])
	by nemo.ece.pdx.edu (8.13.6/8.13.1) with ESMTP id o2B94P0E000281;
	Thu, 11 Mar 2010 01:04:25 -0800 (PST)
Received: (from tait@localhost)
	by nemo.ece.pdx.edu (8.13.6/8.12.6/Submit) id o2B94OIl000273;
	Thu, 11 Mar 2010 01:04:24 -0800 (PST)
X-Authentication-Warning: nemo.ece.pdx.edu: tait set sender to git.git@t41t.com using -f
Content-Disposition: inline
In-Reply-To: <7vzl2hw972.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ehlo.cat.pdx.edu [131.252.208.106]); Thu, 11 Mar 2010 01:04:25 -0800 (PST)
X-Spam-Status: No, score=0.0 required=6.0 tests=none autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on ehlo.cat.pdx.edu
X-Virus-Scanned: clamav-milter 0.95.2 at ehlo.cat.pdx.edu
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141943>

> This says "if 'editor' is not exactly the string ':'", ...

Oh right; I ... yeah, something. (I've got no excuse for mis-thinking
that one.)

> If you end up with a file whose name literally is '$@', that probably
> means your "sh" did not expand it correctly.

It does expand the $@ when I add it explicitly to core.editor though. Maybe
it's the ""s. I'll have to figure out how to compile git for Windows
to try a patch.

Oddly enough, if I remove the : from the file path, it does work as
expected. Adding the : back introduces the faulty behavior described
earlier.

Tait
