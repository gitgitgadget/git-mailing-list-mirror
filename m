From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: renames in StGIT
Date: Sun, 22 Oct 2006 03:39:43 +0200
Message-ID: <20061022013943.GA16341@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 22 03:39:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbSJb-00052Y-4Y
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 03:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161151AbWJVBjr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 21 Oct 2006 21:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161527AbWJVBjr
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 21:39:47 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:59652 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1161151AbWJVBjr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 21:39:47 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1GbSJU-0004Qi-00; Sun, 22 Oct 2006 02:39:44 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29704>

It doesn't seem like StGIT uses any of git's rename tracking stuff.
Specifically, pushing patches doesn't seem to use rename-aware
merging, and there is no way to tell diff to detect renames and
copies.

Should this perhaps be an item in the TODO list?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
