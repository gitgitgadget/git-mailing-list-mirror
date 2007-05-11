From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: Anyone running GIT on native Windows
Date: Fri, 11 May 2007 18:34:21 +0200
Organization: eudaptics software gmbh
Message-ID: <46449B0D.5FCD66F1@eudaptics.com>
References: <2b6901c78faa$cf9aa7e0$0200a8c0@AMD2500>		 <7vejlufmhd.fsf@assigned-by-dhcp.cox.net>		 <2b7f01c78fb1$be4dc6a0$0200a8c0@AMD2500>		 <463ECEF4.625F3633@eudaptics.com> <e5bfff550705070448t7813d064mbac82abb45591888@mail.gmail.com> <463F14FF.F8DF11EB@eudaptics.com> <46415106.5040401@xs4all.nl> <46417351.6BBA9313@eudaptics.com> <4643EA77.4040803@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Fri May 11 18:34:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmY4L-0004RI-W4
	for gcvg-git@gmane.org; Fri, 11 May 2007 18:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759720AbXEKQeK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 12:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760254AbXEKQeJ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 12:34:09 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:34279 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759720AbXEKQeI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 12:34:08 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.44)
	id 1HmY4B-0004nG-WF; Fri, 11 May 2007 18:34:04 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 858516EF; Fri, 11 May 2007 18:34:03 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.033
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46962>

Han-Wen Nienhuys wrote:
> http://lilypond.org/git/binaries/mingw/git-1.5.1-1.mingw.exe

This resulted in a mostly working git toolset after I've done this in
addition to installing it:

- Installed MSYS (of course ;)
- Install libiconv-2.dll, which can be found in
diffutils-2.8.7-1-dep.zip from
http://sourceforge.net/project/showfiles.php?group_id=2435 (available in
Section Snapshot->MSYS) (rename libiconv2.dll to libiconv-2.dll)
- Set the path to MSYS and Git manually.

For extra bonus points, I should also have installed
bash-3.1-MSYS-1.0.11-snapshot.tar.bz2 (without which 'git am' fails) and
msysDTK-1.0.1.exe for ssh and perl, but I haven't.

gitk and git-gui are untested; they need tcltk-8.4.1-1.exe, of course.

-- Hannes
