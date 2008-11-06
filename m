From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: StGit: stgit mail configuration options
Date: Thu, 06 Nov 2008 11:21:20 +0100
Message-ID: <871vxptasf.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 11:22:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ky20Z-0001Pn-NW
	for gcvg-git-2@gmane.org; Thu, 06 Nov 2008 11:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754550AbYKFKVX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Nov 2008 05:21:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754557AbYKFKVX
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Nov 2008 05:21:23 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:50810 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754550AbYKFKVW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2008 05:21:22 -0500
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id CD97B40013;
	Thu,  6 Nov 2008 11:21:18 +0100 (CET)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id C234C4001B; Thu,  6 Nov 2008 11:21:18 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00 autolearn=ham 
	version=3.1.7-deb
Received: from krank (dns.vtab.com [62.20.90.195])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 7150240013;
	Thu,  6 Nov 2008 11:21:18 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id DF05BDC0AB; Thu,  6 Nov 2008 11:21:20 +0100 (CET)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100226>

The "stg mail" command uses a couple of configuration options that are
completely undocumented, and don't fit well together.

"stgit.autobcc" seems to give a default value for the --bcc option.

"stgit.mail.prefix seems to give a default value for the --prefix
option.

Shouldn't these both be stgit.* or stgit.mail.*? And shouldn't they be
documented? Or maybe removed?

And I propse that the autobcc option should be a boolean which means
that user.email should be used.

--=20
David K=C3=A5gedal
