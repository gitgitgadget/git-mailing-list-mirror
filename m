From: Caleb Cushing <xenoterracide@gmail.com>
Subject: how do I resolve this merge manually + mergetool bug
Date: Tue, 24 Feb 2009 01:04:23 -0500
Message-ID: <81bfc67a0902232204y7a1e9a91x6cbf751319664734@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 07:06:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbqQU-0007hw-Dt
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 07:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbZBXGE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 01:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752732AbZBXGE0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 01:04:26 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:17544 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbZBXGE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 01:04:26 -0500
Received: by qw-out-2122.google.com with SMTP id 5so1647892qwi.37
        for <git@vger.kernel.org>; Mon, 23 Feb 2009 22:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=sB65gLk5Pk8Kt4ETYJY5GuKtqTAlREDcDP6VhteBOgk=;
        b=A7xVnXlqZTVSoxMW1Roep5NVYY3j/tPfab9nVUCdUb/+k0r8Sts5E9bPSph3+hgWmg
         pbJbJjkqjdNQgPiOrvDe1vrKEY4J7gKcWOIa9mch6+guHbTHlhzQgBJ22k3b4c8LzkpI
         vp4woZO4i/U/TOSc/Oh3yM6dx5ITgQe0HQtU4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=vLSVN59IiMmk3XaMAsUIURgx54sUss06rONaoyzNmpyqRVS+gO+bXduBbqqOl+ec+Z
         be1HOuxYCKHignxwBApUg4G5kWQCN0paOtyNhLH9Jv50JceHC45BRFC0HlyAJC2m7r/g
         De4snpfW7Bg4IkgfrtDEAx/Oz7D2WDZCHiaGI=
Received: by 10.229.86.196 with SMTP id t4mr1767797qcl.39.1235455463811; Mon, 
	23 Feb 2009 22:04:23 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111216>

#       unmerged:   profiles/package.mask

on the remote package.mask is a file locally it is a directory.

I need to know how I can resolve this merge without mergetool as
currently mergetool doesn't handle it well.

I want to delete the remote version of package.mask

tried:

git rm :3:profiles/package.mask
fatal: pathspec ':3:profiles/package.mask' did not match any files

mergetool will move my directory to a backup directory if I tell it to
delete package.mask it doesn't move the directory back into place, if
I tell it to use the remote version it obviously copies it into
place... I'd be ok if when I told it to delete it, it restored the
directory from backup.

regardless of mergetools problems I'd like to know how to fix this
merge without mergetool.
-- 
Caleb Cushing

http://xenoterracide.blogspot.com
