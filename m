From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: [ANNOUNCE] Stacked GIT 0.14.2
Date: Mon, 24 Mar 2008 19:59:00 +0000
Message-ID: <b0943d9e0803241259s5280cdc1o255a4412b3fa7bfc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 24 21:00:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdspr-0005Th-Qo
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 21:00:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbYCXT7I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2008 15:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752379AbYCXT7H
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 15:59:07 -0400
Received: from el-out-1112.google.com ([209.85.162.178]:8382 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbYCXT7E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2008 15:59:04 -0400
Received: by el-out-1112.google.com with SMTP id v27so1407705ele.17
        for <git@vger.kernel.org>; Mon, 24 Mar 2008 12:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=YFYxfsOYIIZSbGWN1nD3/iESnlTXjwSp7AVaPifD398=;
        b=TyRYLQYKZ+P4RE7PNp/WPD8bZ5zWo42zHDUzQ2qwSJapc/O4HG89o7uex7Cwl8WXzBmcOjgnNO5Lp4h3kmIxlQKUYlOHFibXwUKluPDV9XKpwTehusv7v1vBdudc1unIySiE4qwjUfW8TUgOscGG/AzTaCN0dOIlnhJJibADpLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=RJgxaSjBXqe1X8ssRKBiIjfj6+v62lyCPPpPWlG4bpRqis+3t0JkfTWdFyed0knDbJFcPo9QYyv/pRQP839x6C7eLHN3x38A2TVwDGGagM7TOB6csBw1DupR2UtQi3r0zZcRLEM0MTzEw8aoJ8jAwKdnGqOvQscKLVczLGvYhyQ=
Received: by 10.140.187.10 with SMTP id k10mr2538625rvf.86.1206388740084;
        Mon, 24 Mar 2008 12:59:00 -0700 (PDT)
Received: by 10.141.175.11 with HTTP; Mon, 24 Mar 2008 12:59:00 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78088>

Stacked GIT 0.14.2 release is available from http://www.procode.org/stg=
it/.

StGIT is a Python application providing similar functionality to Quilt
(i.e. pushing/popping patches to/from a stack) on top of GIT. These
operations are performed using GIT commands and the patches are stored
as GIT commit objects, allowing easy merging of the StGIT patches into
other repositories using standard GIT functionality.

This is a maintenance release including bug-fixes and a few user
interface enhancements. Acknowledgements:

Catalin Marinas (13):
      Don't set the default authdate if none specified
      Allow pick to import multiple patches
      Check for unnecessary push/pop in 'float'
      Allow the synchronisation of the unapplied patches
      Modify 'series' to use '#' instead of '|'
      Set umask to 0022 during the setup.py execution
      Refuse to send empty patches
      Add a boundary to parse_patches in pick.py
      Fix sync to push the popped patches back after sync'ing
      Remove the reordering side-effect of the latter sync changes
      Allow picking of one commit id
      Remove a newline from the e-mail template
      Release 0.14.2

Onno Kortmann (2):
      Simple rename of top-most patch
      Test the 'stg rename' command

Alex Chiang (1):
      Better "stg rebase" help text

Angus Salkeld (1):
      stg mail crashes when there is no patch description

Karl Hasselstr=F6m (1):
      Make documentation less confusing

Peter Oberndorfer (1):
      replace "git repo-config" usage by "git config"

Toby Allsopp (1):
      Fix "stg branch --delete" on a nonexistent branch

--=20
Catalin
