From: Daniel Pittman <daniel@rimspace.net>
Subject: Test that every revision builds before pushing changes?
Date: Thu, 26 Mar 2009 17:29:58 +1100
Organization: I know I put it down here, somewhere.
Message-ID: <87myb8aja1.fsf@rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 07:36:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmjCi-00068R-RS
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 07:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbZCZGfI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 02:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbZCZGfI
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 02:35:08 -0400
Received: from main.gmane.org ([80.91.229.2]:48170 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751611AbZCZGfH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 02:35:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LmjB9-0005Lm-0i
	for git@vger.kernel.org; Thu, 26 Mar 2009 06:35:03 +0000
Received: from sdcarl02.strategicdata.com.au ([203.214.67.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 06:35:03 +0000
Received: from daniel by sdcarl02.strategicdata.com.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 06:35:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sdcarl02.strategicdata.com.au
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:Z5DPdMvKhx5OC5S9+vyPYfWYsV0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114738>

G'day.

I would like to ensure that my commits are fully bisectable before I
commit them to an upstream repository, at least to the limits of an
automatic tool for testing them.

'git bisect run' is similar: it can automatically locate the breaking i=
n
a test suite, for example, but that doesn't help me in the case of thre=
e
commits, A (good), B (bad) and C (good, fixing B).

I would much rather, in this case, use rebase to fix B so that it, too,
builds before I push the changes and pollute a public repository with a
broken changeset =E2=80=94 and make bisect that much harder to use in f=
uture.

Regards,
        Daniel
