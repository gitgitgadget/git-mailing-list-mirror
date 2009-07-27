From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Output from git diff-tree (documentation)
Date: Mon, 27 Jul 2009 21:54:19 +0200
Message-ID: <87hbwxaolw.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 27 22:52:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVXBq-0004MA-R4
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 22:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754747AbZG0Uwu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jul 2009 16:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754719AbZG0Uwt
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 16:52:49 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:33007 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752745AbZG0Uwt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 16:52:49 -0400
X-Greylist: delayed 1814 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jul 2009 16:52:49 EDT
Received: from mail.lysator.liu.se (localhost [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 27FDB40037;
	Mon, 27 Jul 2009 22:22:18 +0200 (CEST)
Received: by mail.lysator.liu.se (Postfix, from userid 1674)
	id 1C90F40089; Mon, 27 Jul 2009 22:22:18 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	bernadotte.lysator.liu.se
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=5.0 tests=AWL autolearn=disabled 
	version=3.1.7-deb3
Received: from krank (unknown [87.96.142.66])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id D64D540037;
	Mon, 27 Jul 2009 22:22:17 +0200 (CEST)
Received: by krank (Postfix, from userid 1000)
	id 58052DC2E7; Mon, 27 Jul 2009 22:22:50 +0200 (CEST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124191>

The "git diff-tree HEAD" command (with the default raw output) starts
by printing a hash, which seems to be the hash for the commit (HEAD in
this case).

I can't find any description of this in the documentation for
diff-tree.

The "output format" sectionis the generic diff-format.txt that
describes the format of the lines for the files that differ. Nothing
wrong with that, but it doesn't explain the initial line of diff-tree.

The documentation of the --stdin flag mentions some initial output,
but that is not relevant in this case.

--=20
David K=C3=A5gedal
