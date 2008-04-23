From: Christoph Duelli <duelli@melosgmbh.de>
Subject: history of a renamed file
Date: Wed, 23 Apr 2008 15:02:33 +0200
Message-ID: <480F3369.5080203@melosgmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 15:06:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Joeeq-0001jj-7e
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 15:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645AbYDWNEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 09:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752634AbYDWNEV
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 09:04:21 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:54020 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848AbYDWNEU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 09:04:20 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: hvKqOO6Ph79JHUJJIwMxXgzUdNi1LqfccsoS0yxp1bU6IJpbRdTLsu3mhpkbx1G98iOfud8=
Received: from mail.melosgmbh.de
	(p5B07A59E.dip0.t-ipconnect.de [91.7.165.158])
	by post.webmailer.de (mrclete mo33) (RZmta 16.27)
	with ESMTP id c00b27k3NBNGED for <git@vger.kernel.org>;
	Wed, 23 Apr 2008 15:04:17 +0200 (MEST)
	(envelope-from: <duelli@melosgmbh.de>)
X-Spam-Status: No, hits=0.0 required=4.0
	tests=AWL: 0.035,BAYES_00: -1.665,TOTAL_SCORE: -1.630
X-Spam-Level: 
Received: from [172.27.1.229] ([172.27.1.229])
	(authenticated user duelli@melosgmbh.de)
	by mail.melosgmbh.de (Kerio MailServer 6.4.1 patch 1)
	for git@vger.kernel.org;
	Wed, 23 Apr 2008 15:04:14 +0200
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80214>

Given a repo that contains a file x.c
that got renamed from
some/path/x.c
to
new/location/x.c

Is it possible (ideally with gitk) to view the complete history of what 
is now new/location/x.c *including* the history of changes that occurred 
when it stil was some/path/x.c?
When I say "gitk new/location/x.c" I get just the changes made starting 
with the rename.
When I call "gitk" and look for the changeset, the rename is detected, 
though. Therefore I hope that it is somehow possible to obtain the 
complete file-specific history without truncation at renames.

Any ideas?

Thank you, best regards
Christoph
