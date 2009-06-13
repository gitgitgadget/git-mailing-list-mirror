From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: running git as root
Date: Sat, 13 Jun 2009 17:42:10 +0200
Message-ID: <4A33C8D2.5080808@drmicha.warpmail.net>
References: <3a3d9e520906130825k25815c9atafde301d9fbc1da2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Nelissen <marcone@xs4all.nl>
X-From: git-owner@vger.kernel.org Sat Jun 13 17:43:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFVO4-0004jO-4x
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 17:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169AbZFMPnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 11:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752928AbZFMPnJ
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 11:43:09 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:33864 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752338AbZFMPnI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Jun 2009 11:43:08 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id D1EBF35E53F;
	Sat, 13 Jun 2009 11:43:08 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Sat, 13 Jun 2009 11:43:08 -0400
X-Sasl-enc: HDy++56jAmRXYnxY85e6lNydKacKmblQ81DLjychX8rY 1244907788
Received: from localhost.localdomain (p5485A135.dip0.t-ipconnect.de [84.133.161.53])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3AE0431530;
	Sat, 13 Jun 2009 11:43:08 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1pre) Gecko/20090609 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <3a3d9e520906130825k25815c9atafde301d9fbc1da2@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121504>

Marco Nelissen venit, vidit, dixit 13.06.2009 17:25:
> When running as root, git fails a number of test cases that expect it
> to fail on read-only repositories (for example 't0004-unwritable.sh').
> I was thinking of either changing the code so that it checks
> permissions itself when opening files as root, or add a prerequisite
> to those test cases so that they are skipped when running as root.
> What would be the preferred way?

The preferred ways is to build git as non-root user. This is true even
more so for running the test suite.

Michael
