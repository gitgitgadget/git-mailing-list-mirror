From: =?UTF-8?B?UMOpdGVyIEFuZHLDoXMgRmVsdsOpZ2k=?= <petschy@gmail.com>
Subject: Question concerning svn -> git migration, merging
Date: Wed, 7 Jul 2010 14:29:20 +0200
Message-ID: <AANLkTimBNgyUpBbaIRCyDKsXsvsqEu3SWUVTqT7un1W5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 07 14:29:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWTkl-0002Dg-RF
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 14:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091Ab0GGM3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 08:29:23 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:53595 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438Ab0GGM3W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 08:29:22 -0400
Received: by ewy23 with SMTP id 23so2089278ewy.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 05:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=rzU9xbWHaySC2MhPXfe8gpYv0FcCjt6mq06vpkDafxw=;
        b=hEFeBzmql7+ZYpHOmZvImU23UFpqKwDaS/8wyapP+DE1GGBq7AuZThPtdiNohNbVU8
         lhaYQ2ex1spqT3PpEu5J42m6YVjuVhIdi+tnWa/sdQV8TmHQ+C2RKtRFhFKD6yA7m5BN
         b+Cf/Ci7jppL9PZuxrP0S11phXnfaOuyRbTlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=nZvoVkRarmFh1I5hSU9ExzQOGyO5vp37wyStb/DTC1p7Woas0XgI4tYnTGuZPLUxPA
         fpv63CqPlRIeNcdyse7jEuEoJYDDJtzZnhTYLALtzikgHY3o3xc5wunNEpDVblAvn3yz
         GOT+ZkuQmQBf5oh2JZaYtSfXlBt/JlQFjZO6M=
Received: by 10.213.9.67 with SMTP id k3mr5568909ebk.78.1278505760991; Wed, 07 
	Jul 2010 05:29:20 -0700 (PDT)
Received: by 10.213.20.3 with HTTP; Wed, 7 Jul 2010 05:29:20 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150467>

Hello,

I was happy with svn for a while, but recently I started a new branch
where I moved/renamed a few files, and merging became a less pleasant
experience: I have to manually generate diffs from the trunk and patch
the moved files on the branch (apart from remembering which revisions
were already merged).

I cloned the svn repo, checked out the branch, but when I try to merge
from master, I got a lot of conflicts. I guess this is because I did a
few merges already in svn (before the repo cloning), but git is not
aware of that. How could I merge the changes on trunk starting from a
specified revision number, so that only new stuff gets merged? If that
could be done, I would be happy with git-svn (future merges should be
easy), and never look back.

Please CC me in your reply, I'm not subscribed to the list.

Thanks, Peter
