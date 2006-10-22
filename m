From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 2/2] Allow deletion of several patches at once
Date: Sun, 22 Oct 2006 15:01:45 +0200
Message-ID: <20061022130145.GB21084@diana.vm.bytemark.co.uk>
References: <20061022125337.15194.64831.stgit@localhost> <20061022125816.15194.3341.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 15:01:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbcxZ-0000xV-UI
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 15:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbWJVNBr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 22 Oct 2006 09:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbWJVNBr
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 09:01:47 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:35080 "EHLO
	diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1751792AbWJVNBq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 09:01:46 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1GbcxV-0005wR-00; Sun, 22 Oct 2006 14:01:45 +0100
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <20061022125816.15194.3341.stgit@localhost>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29732>

On 2006-10-22 14:58:16 +0200, Karl Hasselstr=F6m wrote:

>  t/t1600-delete-one.sh    |  109 ++++++++++++++++++++++++++++++++++++=
++++++++++
>  t/t1600-delete.sh        |  109 ------------------------------------=
----------

By the way, this is why I complained about StGIT's lack of rename
support earlier. This is a file move with maybe three of 109 lines
changed, but you won't be able to see that without importing the patch
and examining it with the git tools. :-(

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
