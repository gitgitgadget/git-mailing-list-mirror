From: "Tim Sally" <tsally2@gmail.com>
Subject: Multiple SVN Repos Inside A Git Repo
Date: Tue, 2 Dec 2008 14:22:46 -0600
Message-ID: <4753154c0812021222t2886f986id2b775f90d4ea7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 21:24:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7bmx-0002aM-94
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 21:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbYLBUWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 15:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbYLBUWt
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 15:22:49 -0500
Received: from fk-out-0910.google.com ([209.85.128.185]:59900 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbYLBUWs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 15:22:48 -0500
Received: by fk-out-0910.google.com with SMTP id 18so2580794fkq.5
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 12:22:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=8aKvFHTqRVoUj7ER+Viof942C5AXrK2IaeOCE0n3ZrA=;
        b=TTql0AXbiVNz/43aE7G4QRObnAjNEx9aA7bPhmKK+MJzRpXzRGOUAsP1tI/rm18S6U
         qINocjFeE/JM/MYrXlEFKU4ZVYloMrECeuw1sdaKU8TUgfQq7+m75mOptaDZoTkvM6Rj
         PNuc62j3k1kuNisZLeZgZ/ADE9qFNSz/IH8KA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=JvGIvh7gfykKlc7mIyw1lnyRtNbyGv5ozDG83T3vM56N2yWVjtZT8vx6ZemnzdZlf7
         PVxcnSQg9dfhM2YczfT6yj23UIXYyJvnVNnwU/up9pfZcelqAymBT5inLcYc0R4yPNkp
         bOgoqmr0JdK+PkU1zHeC9p+Tcjx42BH5p3AuY=
Received: by 10.180.255.1 with SMTP id c1mr4387042bki.36.1228249366435;
        Tue, 02 Dec 2008 12:22:46 -0800 (PST)
Received: by 10.181.233.6 with HTTP; Tue, 2 Dec 2008 12:22:46 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102173>

Using git-svn, it is possible to have different parts of a git repo
correspond to a specific svn repo? From my understanding after reading
the documentation, you need one git repository per svn.  My example is
that I'm trying to set up a git repo to version control everything
from my classes, but each class has a separate svn repo.  Also, the
number of git repos I can create is limited, and I'd rather not
clutter everything up with many separate git-svn repos.

Example structure:

class/
.......... systems/
.......... algorithms/
.......... physics/

class is one central git repository, and systems, algorithms, and
physics contain data from three svn repositories.  Ideally, you could
commit/update to/from each svn repo individually, or all at once.

Tim
