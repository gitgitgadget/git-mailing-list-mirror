From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: stgit bug: pulling file deletion patch leaves copy of file
Date: Mon, 8 May 2006 14:41:27 +0200
Message-ID: <20060508124127.GA30662@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 08 14:41:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fd53S-0003ea-2R
	for gcvg-git@gmane.org; Mon, 08 May 2006 14:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbWEHMle convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 8 May 2006 08:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWEHMle
	(ORCPT <rfc822;git-outgoing>); Mon, 8 May 2006 08:41:34 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:34578 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S932091AbWEHMld (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 May 2006 08:41:33 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Fd53H-00080U-00; Mon, 08 May 2006 13:41:27 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19765>

When I pull (with -m) a branch that has accepted a patch of mine which
deletes a file, stgit does the right thing wrt detecting the applied
patch, etc. But it leaves an untracked copy of the deleted file in my
working directory, which I get to delete.

I suspect this file should be deleted -- but isn't -- by the patch
merge detection code that undoes the application of the reverse of my
patch.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
