From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [ANNOUNCE] qgit-2.0
Date: Sun, 30 Sep 2007 09:13:39 +0200
Message-ID: <e5bfff550709300013t3475b1a9td483cbb373140213@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git <git@vger.kernel.org>, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 09:13:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibszt-0005mI-OJ
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 09:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202AbXI3HNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 03:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753163AbXI3HNm
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 03:13:42 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:46591 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbXI3HNk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 03:13:40 -0400
Received: by py-out-1112.google.com with SMTP id u77so6291909pyb
        for <git@vger.kernel.org>; Sun, 30 Sep 2007 00:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=hmKy/b80yWiWEaHeFA3npns0ykLF7jBR4iZIqgjjwVQ=;
        b=hdU4gPo9B5zL+s3cReo26dq604JVK8XFXJTH+qRBTs77jOvJm9Gz/zxTVh5VHjLpOXen/YrHI0dOD7LA51Blaunn/K+pGSSIqtC1FgeNcb1qbiKjvcg0BS0RKBTYZrpym91IFPu5bruUvPG39DXGMZsF3DrMXTy2Y0Ag9l8RyrY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uSEfUjPYfZVrzbkPMeNXSc6HG1WxlbrsShHyh0W0kZJcUKJbhT9b3ZZhWufpGjhAvS/dO3UFNStj1ONNffkD8KOfB1ycGVg4oU6E5aUWe/9C2iFdPuYBmM65+JN2IIZfYTc28bBlbQjSeFHXaZ3nlAe5N98ZYa+3+mTOXXXSeQM=
Received: by 10.114.199.1 with SMTP id w1mr1252670waf.1191136419169;
        Sun, 30 Sep 2007 00:13:39 -0700 (PDT)
Received: by 10.140.185.19 with HTTP; Sun, 30 Sep 2007 00:13:39 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59527>

This is the final qgit-2.0

With qgit you will be able to browse revision histories, view patch content
and changed files, graphically following different development branches.


IMPORTANT NOTE
git 1.5.3 or better is required, Qt 4.3 or better is required.


FEATURES

 - View revisions, diffs, files history, files annotation, archive tree.

 - Commit changes visually cherry picking modified files.

 - Apply or format patch series from selected commits, drag and
   drop commits between two instances of qgit.

 - Associate commands sequences, scripts and anything else executable
   to a custom action. Actions can be run from menu and corresponding
   output is grabbed by a terminal window.

  - qgit implements a GUI for the most common StGIT commands like push/pop
   and apply/format patches. You can also create new patches or refresh
   current top one using the same semantics of git commit, i.e. cherry
   picking single modified files.


NEW IN THIS RELEASE

This is the final public release of the shining new qgit 2.0 based on
the shining new Qt 4.3 libraries.

All the features of the stable series have been ported. In addition this
new release sports a better GUI both on visually side and on usability side.

Annotation code is much improved in speed and in power, as example
now follows file renames, try it on any git tree file to see a real example.

A new and much improved repository browsing experience is now possible,
in particular you don't need to switch to patch tab to view diff
content anymore. Patch information, together with patch description,
is shown in bottom left pane.

Finally, qgit works natively under Windows due to Qt 4.3 libraries.


The detailed list of changes is very long and interested people can
read from public qgit repository.

Although there are a lot of new features code is considered stable due
to have been very long in 'rc' state.


You can download the tarball from
http://sourceforge.net/projects/qgit

or clone the public git repository at
git://git.kernel.org/pub/scm/qgit/qgit4.git


Please, check the shipped README for detailed build and install information.


Have fun
Marco
