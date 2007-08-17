From: Mike Hommey <mh@glandium.org>
Subject: Can't figure out some sense from the git-commit-tree man page
Date: Fri, 17 Aug 2007 18:30:34 +0200
Organization: glandium.org
Message-ID: <20070817163034.GA11151@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 18:31:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IM4jL-0002KQ-2d
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 18:31:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523AbXHQQbT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 17 Aug 2007 12:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752368AbXHQQbS
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 12:31:18 -0400
Received: from vawad.err.no ([85.19.200.177]:47268 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724AbXHQQbS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2007 12:31:18 -0400
Received: from aputeaux-153-1-51-63.w82-124.abo.wanadoo.fr ([82.124.11.63] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IM4j3-0006Qm-KF
	for git@vger.kernel.org; Fri, 17 Aug 2007 18:31:13 +0200
Received: from mh by namakemono.glandium.org with local (Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1IM4iY-00035Q-FE
	for git@vger.kernel.org; Fri, 17 Aug 2007 18:30:34 +0200
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Spam-Status: (score 0.0): Status=No hits=0.0 required=5.0 tests=none version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56063>

Hi,

The git-commit-tree man page reads:
  A commit encapsulates:

  =B7   all parent object ids

  =B7   author name, email and date

  =B7   committer name and email and the commit time.
  If not provided, "git-commit-tree" uses your name, hostname and domai=
n to
  provide author and committer info. This can be overridden by either
  .git/config file, or using the following environment variables.
  (...)

The "If not provided" part doesn't make sense. If you're not setting th=
e
author and committer in your config or environment, how are you suppose=
d
to provide it ?

Naively, I tried sending a "git-cat-file commit" looking text to stdin,
but it just ended up in the changelog, which was actually no surprise.

Mike
