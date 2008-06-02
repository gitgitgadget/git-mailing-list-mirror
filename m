From: Thomas Christensen <thomasc@thomaschristensen.org>
Subject: [Bug] vfat: Not a git archive
Date: Mon, 02 Jun 2008 12:20:13 +0200
Message-ID: <873anwt9ya.fsf@debian.erik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 02 12:21:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K379w-0007EL-M8
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 12:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbYFBKUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 06:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbYFBKUI
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 06:20:08 -0400
Received: from main.gmane.org ([80.91.229.2]:40291 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751233AbYFBKUH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 06:20:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1K3790-0007ly-DX
	for git@vger.kernel.org; Mon, 02 Jun 2008 10:20:02 +0000
Received: from 194.239.24.50 ([194.239.24.50])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 10:20:02 +0000
Received: from thomasc by 194.239.24.50 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 10:20:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 194.239.24.50
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:VnJYVovjDFEGfWi7Ks3/0sMaVBo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83508>

Hi,

I am having this issue on Debian with kernel 2.6.25 (2.6.24 works fine)
and git 1.5.5.3.

  $ git push /media/KINGSTON/foo.git
  fatal: '/media/KINGSTON/foo.git': unable to chdir or not a git archive
  fatal: The remote end hung up unexpectedly

A notable difference between these 2 kernels is this line:

  [   62.575939] FAT: utf8 is not a recommended IO charset for FAT
  filesystems, filesystem will be case sensitive!

which appears in 2.6.25.

If this bug should be filed against Debian I will do so.

	Thomas
