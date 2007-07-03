From: "Steve French" <smfrench@gmail.com>
Subject: git-svnexport
Date: Tue, 3 Jul 2007 14:31:47 -0500
Message-ID: <524f69650707031231y2ab7b9a3o7769f64b9876326@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 21:31:52 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5o6J-00038J-TZ
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 21:31:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757323AbXGCTbt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 15:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757321AbXGCTbt
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 15:31:49 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:26597 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756229AbXGCTbs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 15:31:48 -0400
Received: by py-out-1112.google.com with SMTP id u77so3440969pyb
        for <git@vger.kernel.org>; Tue, 03 Jul 2007 12:31:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=l3CypnBSjusy7dKd5deeP4wgDlgKu7vKgCIPV0jC6LYilEPosAewPIXwB+D7BY8cc7x4tcdp2N22wug1U0nlg7CTwRo76m1Gx+ohvU3htRkJrNW6jacnInkuvQVtPbUhH0myIhNa0zS+es/rhQTmNJ66O7tsNl960Vnki/gXdyA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TOxJepp+lMDSthtFge4d2OS0AqAQFprQVUWxb0qdzocemmk3LFLMZYchlkXAFrTOLbb/QgF5uuRXsNIu5CnllIDwusv7PUKiPbP13iqj0cgo8FpZB8oYJkMxjOPjBRSJPQrUm03a8q/bZTiVcTY+pH0wqVekmIRgOMETnl0U5yM=
Received: by 10.35.87.8 with SMTP id p8mr8360424pyl.1183491107897;
        Tue, 03 Jul 2007 12:31:47 -0700 (PDT)
Received: by 10.35.123.5 with HTTP; Tue, 3 Jul 2007 12:31:47 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51526>

I noticed a git-svnexport, but don't see an easy way to do the more
common task ... export a replica (via svn) of a kernel directory whose
master copy is in git (no changes come through svn, all changes come
through git).

The Samba team (jra and others) use svn and would like me to keep more
uptodate the svn branch (which I sync manually now by applying the
patches from the kernel git tree by hand) for the two cifs git trees.
Basically I need to do something like:

git log fs/cifs
save off each of the commits which hit fs/cifs which are not in the svn tree yet
patch and "svn checkin" each of the commits to the svn tree


Has anyone done any scripts to --- export -- to an svn tree from part
of a git tree?
I don't want to go to having my svn tree as the master and import into
git from svn.



-- 
Thanks,

Steve
