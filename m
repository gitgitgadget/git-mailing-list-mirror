From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: [ANNOUNCE] Stacked GIT 0.14.3
Date: Mon, 9 Jun 2008 00:10:47 +0100
Message-ID: <b0943d9e0806081610n6f504a4wc2af285aa2c48d1a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 09 01:11:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5U35-0005sD-C1
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 01:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755921AbYFHXKu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jun 2008 19:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755893AbYFHXKt
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 19:10:49 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:9905 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755843AbYFHXKt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jun 2008 19:10:49 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1590436waf.23
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 16:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=KOlUEYwx+ALC1Hz6TmIpXopumwLYT3GcIbalWXY/WZU=;
        b=FNWXHK5cTw0fAHxssSwAdkA4HFQ6l/svchthVnCqXV4mrQslPkiNZQkeRL673Gdfsk
         ECkKEfd/QkUlrngGYSZLEd/6jAOBCxN01N8LYKIG871LzSw4ReHu9Dx9J7/u04XnY41G
         g5za8HTUi8ktrlSTD9IZcV65cw1fpK/Kq7qEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Djyj9k1nH08fhJJo5oKyd9urkrfsUnlD0ACjJpQXDg/lWjHsY40nceGmrgGDKocK5Q
         0r37VJawFXtJr3S+Srd6MjiiNlXe4WSvfVAaMxMulS2VN3flGzwYcMJmyQJ228rn66q8
         xgdFDExtnMzoT18a+uWWRQXiSMI5tL0byVD74=
Received: by 10.115.32.1 with SMTP id k1mr2587891waj.107.1212966647524;
        Sun, 08 Jun 2008 16:10:47 -0700 (PDT)
Received: by 10.114.171.16 with HTTP; Sun, 8 Jun 2008 16:10:47 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84343>

Stacked GIT 0.14.3 release is available from http://www.procode.org/stg=
it/.

StGIT is a Python application providing similar functionality to Quilt
(i.e. pushing/popping patches to/from a stack) on top of GIT. These
operations are performed using GIT commands and the patches are stored
as GIT commit objects, allowing easy merging of the StGIT patches into
other repositories using standard GIT functionality.

This is a maintenance release including bug-fixes for the "refresh"
command, handling of file names with non-ASCII characters and user
interface enhancements for "export" and "sync".

Acknowledgements:

Karl Hasselstr=F6m (6):
      Fix problems in t1000-branch-create
      Make t1003-new executable
      Add rebase test for when upstream has deleted a non-ASCII file
      Handle changed files with non-ASCII names
      Test for another filename quoting issue in tree_status()
      Handle refresh of changed files with non-ASCII names

Catalin Marinas (4):
      Fix the sync'ing of unapplied patches only
      Allow export to write unapplied files as well
      Fix "refresh" failure with moved files (bug 11661)
      Release 0.14.3

--=20
Catalin
