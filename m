From: rick23@gmx.net
Subject: Umlaut in filename makes troubles
Date: Tue, 1 Dec 2009 08:15:08 +0100
Message-ID: <200912010815.14515.rick23@gmx.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 01 08:15:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFMxO-0002A3-1P
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 08:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752389AbZLAHPS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 02:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751978AbZLAHPS
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 02:15:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:52915 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751821AbZLAHPR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 02:15:17 -0500
Received: (qmail invoked by alias); 01 Dec 2009 07:15:22 -0000
Received: from 85-127-8-251.dynamic.xdsl-line.inode.at (EHLO sauron.localnet) [85.127.8.251]
  by mail.gmx.net (mp009) with SMTP; 01 Dec 2009 08:15:22 +0100
X-Authenticated: #525550
X-Provags-ID: V01U2FsdGVkX1/x6J49cQvx+Ol2KJP07vOXakpOmvhSmo4OnL9frG
	jeZzpHiuUz08DU
User-Agent: KMail/1.11.4 (Linux/2.6.31.1; KDE/4.2.4; x86_64; ; )
Content-Disposition: inline
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134167>

I have problems with my repository under slackware vs. windows. I=20
created a repo in linux and every time I use it under msysgit, the=20
files containing umlauts in the filename are marked as deleted (and=20
vice versa).

=46or instance: the repo perfectly synced under msysgit leads to:

user@sauron:/media/disk-2$ git status |grep Auszug
#       deleted:    "trunk/007_Literatur/Auszug aus Ergonomische=20
Untersuchung des Lenkgef\374hles.docx"
#       "trunk/007_Literatur/Auszug aus Ergonomische Untersuchung des=20
Lenkgef\303\274hles.docx"

in linux. But the file exists and is displayed correctly in the shell=20
or in dolphin (my filemanager under X):

user@sauron:/media/disk-2$ ls trunk/007_Literatur/Auszug*
trunk/007_Literatur/Auszug aus Ergonomische Untersuchung des=20
Lenkgef=C3=BChles.docx

Can you please give me a hint what to do?

TIA
