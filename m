From: Jim Meyering <jim@meyering.net>
Subject: why the 'g' prefix on the SHA1 in git-describe output?
Date: Sat, 03 Nov 2007 13:25:26 +0100
Message-ID: <871wb7a53d.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 03 13:25:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoI4O-0007R4-AV
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 13:25:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753485AbXKCMZ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 08:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753474AbXKCMZ2
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 08:25:28 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:60500 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753199AbXKCMZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 08:25:27 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id C98B417B544
	for <git@vger.kernel.org>; Sat,  3 Nov 2007 13:25:26 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id B631517B552
	for <git@vger.kernel.org>; Sat,  3 Nov 2007 13:25:26 +0100 (CET)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 9571228740; Sat,  3 Nov 2007 13:25:26 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63255>

Hello,

Can anyone tell me what motivated adding the 'g' prefix on the SHA1 in
git-describe output?  Is there some version-parsing/comparing tool that
misbehaves on a component like the SHA1 that would otherwise start with a
digit but contain non-numeric bytes, too?

Why do I ask?  Because I'm using a bastardized version of GIT-VERSION-GEN
in coreutils' build-aux/git-version-gen, and removed the 'g' to shorten
the string by a byte.  If there's a good reason (i.e., other than vanity :-)
for the 'g', I'll propose comments for GIT-VERSION-GEN, so others
don't do what I've done.

Jim
