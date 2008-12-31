From: "Caleb Cushing" <xenoterracide@gmail.com>
Subject: git has modified files after clean checkout
Date: Wed, 31 Dec 2008 15:23:57 -0500
Message-ID: <81bfc67a0812311223g2b6e8476y84b23c19977dfd10@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 31 21:25:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LI7d7-0007rj-OK
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 21:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756276AbYLaUYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Dec 2008 15:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757250AbYLaUYD
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Dec 2008 15:24:03 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:42542 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757222AbYLaUYB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Dec 2008 15:24:01 -0500
Received: by bwz14 with SMTP id 14so18811143bwz.13
        for <git@vger.kernel.org>; Wed, 31 Dec 2008 12:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=6PBe/MqS+ypllQYBrQ23lSqvrdwfGRL9+Lg7wN1TSLU=;
        b=YxtPfamGfSoVu4R5av0ZyvmC/HXbaCTJEfnPaxLjaDW0lXkNs4zpxRgTTOQjOvQAEU
         NDSN+lkGeyabC/reg/f1dP7iDBcQErvqzK5kAKWnyGEXVl+6dDW8QjEszg4AeQjUmZkT
         IDpKIr0gLigVWr/GeRRFoMpfzwrQogjXMfw4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=fJwS3uWaIq+or/SAtuG+iA6VGbLD1x2gOPQv0xka5UC+xBGMmkJ7YVEfZzb0wKJZeU
         ZhywTrof3JpeE6fY2Ntg04DL19CVZytfRP+23PRsZX059upByeJfYHVyOItCys+8wBra
         /ib6s5DINa3Fsrf2w0va4+2ozH3htfYcFbXks=
Received: by 10.223.114.79 with SMTP id d15mr11802417faq.88.1230755038021;
        Wed, 31 Dec 2008 12:23:58 -0800 (PST)
Received: by 10.223.107.205 with HTTP; Wed, 31 Dec 2008 12:23:57 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104285>

here's what I did

rm -r portage
git clone git@github.com:xenoterracide/portage.git
cd portage
git checkout origin/regen2 -b regen2
git status

# On branch regen2
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:
x11-themes/metacity-themes/files/metacity-themes-1.0-gentoo.diff
#       modified:
x11-themes/metacity-themes/files/metacity-themes-1.2-gentoo.diff
#
no changes added to commit (use "git add" and/or "git commit -a")

why are there files claiming to be modified? this is a clean clone.
I've had this before I usually end up doing a git reset --hard HEAD,
but I'm thinking it's a bug, since I've seen it vary on the same clone
and sometimes even disappear.

git version 1.6.0.6
-- 
Caleb Cushing

http://xenoterracide.blogspot.com
