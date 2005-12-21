From: Marcel Holtmann <marcel@holtmann.org>
Subject: Problem with the dump HTTP transport
Date: Wed, 21 Dec 2005 13:02:54 +0100
Message-ID: <1135166574.26233.64.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Dec 21 13:06:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ep2gi-0002oa-T5
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 13:03:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVLUMCz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 07:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbVLUMCz
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 07:02:55 -0500
Received: from coyote.holtmann.net ([217.160.111.169]:28090 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932386AbVLUMCy
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 07:02:54 -0500
Received: from blade (p5487C558.dip.t-dialin.net [84.135.197.88])
	by mail.holtmann.net (8.13.4/8.13.4/Debian-3) with ESMTP id jBLC3H6w012871
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 21 Dec 2005 13:03:18 +0100
To: git@vger.kernel.org
X-Mailer: Evolution 2.5.3 
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_96_XX 
	autolearn=no version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on coyote.holtmann.net
X-Virus-Scanned: ClamAV version 0.84, clamav-milter version 0.84e on coyote.holtmann.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13874>

Hi Junio,

after you released 1.0.0, I tried to pull it over HTTP, but it fails
with the following output:

# cg-update
Fetching head...
Fetching objects...
Getting alternates list for http://www.kernel.org/pub/scm/git/git.git/
Getting pack list for http://www.kernel.org/pub/scm/git/git.git/
error: Unable to find c2f3bf071ee90b01f2d629921bb04c4f798f02fa under http://www.kernel.org/pub/scm/git/git.git/

Cannot obtain needed object c2f3bf071ee90b01f2d629921bb04c4f798f02fa
while processing commit 0000000000000000000000000000000000000000.
cg-fetch: objects fetch failed

Both, git and cogito, are the latest versions from yesterday. So it
seems every time you repack, you need to do something extra to keep the
dump HTTP transport happy.

Regards

Marcel
