From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Bug?: import-tars misbehaves on Subversion tarballs
Date: Tue, 24 Apr 2007 09:39:07 +0200
Message-ID: <20070424073907.GA22121@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Loeffler <zvpunry@zvpunry.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 09:41:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgFeE-0007UF-6M
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 09:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161694AbXDXHlL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Apr 2007 03:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161696AbXDXHlL
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 03:41:11 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1231 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161694AbXDXHlK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 03:41:10 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HgFcC-000682-00; Tue, 24 Apr 2007 08:39:08 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45422>

import-tars behaves very oddly when I try to import the Subversion
tarballs. (For example,
http://subversion.tigris.org/downloads/subversion-1.4.3.tar.bz2
triggers this problem.) It creates two toplevel directories,
subversion-1.4.3 and subversion-1.4.3subversion. The former seems to
contain at least almost all files; the latter has only a handful of
files, all with very long names.

When I unpack it with GNU tar, I get all the files under a single
"subversion-1.4.3" directory, as expected.

Could it simply be that import-tars can't handle long filenames
somehow? (This is pure speculation, since I know absolutely nothing
about the tar format.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
