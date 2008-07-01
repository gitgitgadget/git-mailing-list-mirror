From: "Neshama Parhoti" <pneshama@gmail.com>
Subject: git push requires a subsequent git reset --hard ?
Date: Tue, 1 Jul 2008 19:51:26 +0300
Message-ID: <912ec82a0807010951j9e970f2k9624682b33c8af7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 01 18:52:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDj5f-0007WR-Iz
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 18:52:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbYGAQva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2008 12:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbYGAQva
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Jul 2008 12:51:30 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:48872 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbYGAQv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2008 12:51:29 -0400
Received: by an-out-0708.google.com with SMTP id d40so420394and.103
        for <git@vger.kernel.org>; Tue, 01 Jul 2008 09:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=YViiboHTcLaOimaIew7QuJAELx1hZiAoLptlxoHeOmc=;
        b=tk9gJjIhQzBr3aGnOs5kBvzdB8ddZw3S3EyqwXHhOax0SGDjgkEW/CTnXezK2VYCIp
         HB548xCCCbEO4ZjswtYW7Q9k4pBhlxfEgBxAgTvhMfFJK4aMv1Q1vHH3Inb05Yq5OLtn
         r3dGE1F9VVsaL1kToL6JWfzdQnQnKKoRYFoV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=hvyi/0PXmsJVqFMEeiwkQw7T78D+BSE3iymr39kHHK4NDBpmrpqfnmxEeL1cUfC7ZF
         46FDGU9jbc/0sp22fp5qv2qHtKagofsl1UDktowsnuZy/OU5XxjC0nIM5H+TfTpYRvYs
         GftPS/4k7Blln8duGjrjqGJqz3dGrV+o7S5yA=
Received: by 10.100.215.5 with SMTP id n5mr6133946ang.99.1214931088938;
        Tue, 01 Jul 2008 09:51:28 -0700 (PDT)
Received: by 10.100.134.20 with HTTP; Tue, 1 Jul 2008 09:51:26 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87054>

Hi all,

I took with me a copy of a local repository to a week away from my station
(just rsync'ed it to my laptop).

On my return, I just "git push myuser@my-station:/my/git/repo" from my laptop.
It seemed to work with no probs.
On my station the git repo got the new commits, as I can see in
git-log, but the actual files were left untouched.

So I need to do something like "git reset --hard HEAD" to get
the changes into the local files.

Is that considered normal ?

or did I do something wrong ?

Thanks,
pnesh
