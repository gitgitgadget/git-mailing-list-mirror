From: David <davvid@gmail.com>
Subject: [ANNOUNCE] ugit: the pythonic git gui
Date: Fri, 28 Dec 2007 14:49:18 -0800
Message-ID: <402731c90712281449g3d0c4f53w48c65dc8883bbbb3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 28 23:49:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8O1T-0001z9-IS
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 23:49:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbXL1WtV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 17:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbXL1WtV
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 17:49:21 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:49794 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbXL1WtU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 17:49:20 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1898533ugc.16
        for <git@vger.kernel.org>; Fri, 28 Dec 2007 14:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=xz6lyUKnDcaVlGlCUPgcWV8HQ0NHGgMzX50fjQ+pNNg=;
        b=B4JvgYD5ZazzLygkpwRO9aXVQZOylsPjdssUZyxwlVMeRp2DljZUt5bXUr2OnO/S7NLzyOkKxwGiRI5vB8zzjneNsm/8ap9Jinh1JRBSFOMbs0P8sSLow4fAxFz3dxGwn7AfDbOf0/ddzRpnzaTz5h+s3M6vqbpoybonwZ0xn8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=W7zaJ4rFgSRIrxeyjzg/s2Iw/gfPhwhHB+xE36X0IEd4doEhyojhhrOKAL26zCiDpM3oymQyBLAQeC6lQAjMl6SSZxsq8SS7xPL5pdjo0N+ZipRtTuKSYJZPUaPK9am3UlRClSvVKu85JhNwff1qg4p+47VGnToBNAx5jcbihlk=
Received: by 10.67.116.2 with SMTP id t2mr8341688ugm.62.1198882158445;
        Fri, 28 Dec 2007 14:49:18 -0800 (PST)
Received: by 10.67.118.1 with HTTP; Fri, 28 Dec 2007 14:49:18 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69302>

ugit, the pyqt-based git gui, has been taking shape as of late.

First off, I'd like to thank everyone that replied with suggestions
and criticism.  This list is extremely helpful with regards to
providing honest software critiques.

New features since the last announcement (almost all of which were
mentioned in one way or another on this list):

* inotify support (we've removed the "Rescan" button)
* Patch hunk un/staging
* Allows un/staging selected patch hunk lines (without --unidiff-zero)
* Prepped for i18n ("env LANG=ja_JP ugit" looks pretty cool now)
* I'm a westerner, so the unstaged list is now on the left and the
staged list is on the right (thanks Jason)
* Optimizations to improve the interactivity of the patch browser
* Misc. fixes for MacOS and Windows (thanks Steffan and Sebastian)
* Uses default system colors whenever possible [no more darkness] (thanks Alex)
* No longer requires PYTHONPATH

Source code (requires pyqt4-dev-tools to build):
http://repo.or.cz/w/ugit.git

Tarballs (require a stock pyqt-4.3 installation):
http://ugit.justroots.com/

I'll try and get some .deb, .rpm, etc. action happening soon.

p.s.
If you read ugit as "(f)uh-git" or "ugly-git", then that's good since
I think that falls in line with the git style ;-)
