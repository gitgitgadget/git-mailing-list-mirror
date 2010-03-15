From: =?utf-8?Q?=C5=81ukasz_Stelmach?= <lukasz.stelmach@iem.pw.edu.pl>
Subject: merging unmanaged working tree
Date: Mon, 15 Mar 2010 12:34:14 +0100
Message-ID: <87ljdtkedl.fsf@dasa3.iem.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 12:46:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr8kx-0003QN-Ex
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 12:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936144Ab0COLql convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 07:46:41 -0400
Received: from charlie.iem.pw.edu.pl ([194.29.147.5]:50795 "EHLO
	charlie.iem.pw.edu.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936138Ab0COLqk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 07:46:40 -0400
X-Greylist: delayed 742 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Mar 2010 07:46:40 EDT
Received: from localhost (dasa3.iem.pw.edu.pl [194.29.147.110])
	by charlie.iem.pw.edu.pl (8.11.7p1+Sun/8.10.2) with ESMTP id o2FBOJ916304
	for <git@vger.kernel.org>; Mon, 15 Mar 2010 12:24:20 +0100 (CET)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142205>

Hello.

Is there a method to (dry?) run git-merge to detect conflicts
on:

* current HEAD (or working tree)
* selected previous revision (the one used to "branch")
* directory tree (or a single file) "branched" with git-archive

I'd like to synchronize portable working tree but don't want to keep
history in it.

--=20
Mi=C5=82ego dnia,
=C5=81ukasz Stelmach
