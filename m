From: Cliff Brake <cliff.brake@gmail.com>
Subject: submodule questions
Date: Fri, 28 May 2010 16:45:10 -0400
Message-ID: <AANLkTilWHMkf5e7PBgnrI1tsGUYOldnv6AWKU3GG02u2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 28 22:45:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OI6Qg-0006uj-9O
	for gcvg-git-2@lo.gmane.org; Fri, 28 May 2010 22:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758727Ab0E1UpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 May 2010 16:45:13 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45532 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603Ab0E1UpM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 16:45:12 -0400
Received: by wyb36 with SMTP id 36so61970wyb.19
        for <git@vger.kernel.org>; Fri, 28 May 2010 13:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=83dcHTAY2elCI748FqKGiWjW80f6Qz5ZvHa6L59WE8Q=;
        b=dLZfk7ZlY9mh5EmFgCuBQ6lV1BkQRPY7yC9SkXS5PGG9rsmRhOJ/4hv4WmT6o/tGqZ
         /fIDv5BjhzWRRdDXbQB4VU2PZjz2kZqPK/+DX6dn5RDIwLq3UmeW1Mn00q67w/AXb9JY
         dLJyLNDcVtesZhBSDgdH8xeKogDahYyo6jxaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=rFqohiOZ4V1PKJHeD6Y882fgl5SxHNhMrdOcYavXzWUjBj2/Kuxa8k3M/yEEOZ3yhR
         VzrzVxQbBI8hzLuddXKs1mj/J3ZaerbWA7AFUzTA11+SIctFrpVxC6D3oCeQ+gppRGft
         1eSfrHwJzAZT7dkPxeyBxt/Q/OCtkMJS8G9Tw=
Received: by 10.216.165.75 with SMTP id d53mr1950630wel.76.1275079510927; Fri, 
	28 May 2010 13:45:10 -0700 (PDT)
Received: by 10.216.49.206 with HTTP; Fri, 28 May 2010 13:45:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147939>

Hello,

I've been trying to understand git submodules.

1) What is the purpose for the submodule lines in .git/config?
2) should 'git submodule sync' update the .git/config with submodule
info, or what exactly does 'git submodule sync' do?

I read the following:
http://therealadam.com/archive/2008/05/08/changing-git-submodule-urls/
 The author claims that:

    * Fork/create your own version of the submodule in question
    * Change the URL for the submodule in .git/config and .gitmodules
    * Cross your fingers and hope for the best

Does not work, but in my experience it does.  On machine #1, I did the
following:

1) created a new branch in the submodule dir, pushed the changes to a new repo.
2) modified .gitmodules to point to the new repo
3) push the changes in the parent repo

On Machine #2:

1) git pull
2) git submodules sync
3) git submodules update

Everything seemed to work.  However, the .git/config submodule entry
still points to the old location, even though 'git submodule update'
seemed to work.  Hence my confusion about what .git/config submodule
entries are for.

Thanks,
Cliff
