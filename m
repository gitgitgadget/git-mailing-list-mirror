From: David Mansfield <david@cobite.com>
Subject: git merge exit code semantics
Date: Wed, 16 Apr 2008 13:12:31 -0400
Organization: Cobite
Message-ID: <1208365951.16608.28.camel@gandalf.cobite.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 16 19:42:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmBCJ-0002Ma-1p
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 19:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbYDPRMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2008 13:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932291AbYDPRMj
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 13:12:39 -0400
Received: from 208.36.103.2.ptr.us.xo.net ([208.36.103.2]:49222 "EHLO
	iris.cobite.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1765948AbYDPRMi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 13:12:38 -0400
Received: from localhost (iris.cobite.com [127.0.0.1])
	by iris.cobite.com (Postfix) with ESMTP id AA516E1052
	for <git@vger.kernel.org>; Wed, 16 Apr 2008 13:12:37 -0400 (EDT)
X-Virus-Scanned: amavisd-new at cobite.com
Received: from iris.cobite.com ([127.0.0.1])
	by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MU-bJNoqulPM for <git@vger.kernel.org>;
	Wed, 16 Apr 2008 13:12:31 -0400 (EDT)
Received: from [208.222.80.105] (208.36.103.2.ptr.us.xo.net [208.36.103.2])
	by iris.cobite.com (Postfix) with ESMTP id 32B0EE104D
	for <git@vger.kernel.org>; Wed, 16 Apr 2008 13:12:31 -0400 (EDT)
X-Mailer: Evolution 2.12.3 (2.12.3-3.fc8) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79721>

Hi,

Is there any place I can find the semantics for exit code values for
'git-merge'? 

I would assume that '0' means merge was successful and '1' means there
was a conflict, but it doesn't state it (and should) in the
documentation.

After being confused by git-status, I felt I should ask.

If someone can explain it, I could probably cook up a patch for the
docs. 

David
