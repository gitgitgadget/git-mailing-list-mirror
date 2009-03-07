From: =?ISO-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 0/5] grep: color search patterns
Date: Sat, 07 Mar 2009 13:24:59 +0100
Message-ID: <1236428699.6486.41.camel@ubuntu.ubuntu-domain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Thiago Alves <thiago.salves@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 07 13:27:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfvbx-0007J5-PU
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 13:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752526AbZCGMZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Mar 2009 07:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752489AbZCGMZK
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Mar 2009 07:25:10 -0500
Received: from india601.server4you.de ([85.25.151.105]:55014 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478AbZCGMZI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2009 07:25:08 -0500
Received: from [10.0.1.101] (p57B7BF05.dip.t-dialin.net [87.183.191.5])
	by india601.server4you.de (Postfix) with ESMTPSA id 31E342F8057;
	Sat,  7 Mar 2009 13:25:05 +0100 (CET)
X-Mailer: Evolution 2.24.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112529>

Match coloring is a major missing feature of git grep.  It makes reading
the output much easier and brings grep onto the same visual level as the
other colorized git commands.

Two earlier attempts to implement this feature didn't go in.  They
didn't support support pattern expressions (--and, --or etc.) or
external greps, unlike this series.

[PATCH 1/5] grep: micro-optimize hit collection for AND nodes
[PATCH 2/5] grep: remove grep_opt argument from match_expr_eval()

   These are cleanup patches and unrelated to coloring.  They touch the
   same code, though, so it's a good idea to take this opportunity to
   beautify the code a bit before adding new features.

[PATCH 3/5] grep: add pmatch and eflags arguments to match_one_pattern()

   The two arguments added by this patch are used by the next one.

[PATCH 4/5] grep: color patterns in output

   Add color support to internal git grep.

[PATCH 5/5] grep: add support for coloring with external greps

   Extends color support to external greps.
