From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Output from git diff
Date: Wed, 29 Jul 2009 19:20:25 +0200
Message-ID: <873a8fflt2.fsf@krank.kagedal.org>
References: <87hbwxaolw.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 19:20:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWCpf-0008Ly-W0
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 19:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbZG2RUn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 13:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbZG2RUm
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 13:20:42 -0400
Received: from main.gmane.org ([80.91.229.2]:37781 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbZG2RUm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 13:20:42 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MWCpT-0003Dz-Nu
	for git@vger.kernel.org; Wed, 29 Jul 2009 17:20:40 +0000
Received: from 95.209.165.17 ([95.209.165.17])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 17:20:39 +0000
Received: from davidk by 95.209.165.17 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 17:20:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 95.209.165.17
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Cancel-Lock: sha1:DE6+CfP3trf4bLx1MmFO/suhpsk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124373>

Here is another diff output question. The updated documentation in
diff-format.txt still claims that the output from the diff commands
has this format:

:100644 100644 bcd1234... 0123456... M file0

This is true for "git diff --raw", but diff-tree and friends print
full 40-char hashes.

I can get diff-tree to use abbreviated hashes with --abbrev, but how
do I tell diff to stop abbreviating?

And what should the documentation really say?

--=20
David K=C3=A5gedal
