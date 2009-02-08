From: Frank Li <lznuaa@gmail.com>
Subject: [ANNOUNCE] TortoiseGit 0.3.3.a8473 release
Date: Sun, 8 Feb 2009 15:34:56 +0800
Message-ID: <1976ea660902072334w335aeb9bud43e7cd2d8b7f5d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: tortoisegit-dev@googlegroups.com,
	tortoisegit-users@googlegroups.com,
	tortoisegit-annouce@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 08:40:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW4Hb-0006Hi-Jm
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 08:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbZBHHe7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 02:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbZBHHe6
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 02:34:58 -0500
Received: from yw-out-2324.google.com ([74.125.46.28]:48984 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbZBHHe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 02:34:57 -0500
Received: by yw-out-2324.google.com with SMTP id 5so237034ywh.1
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 23:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=74qgi5ryawfqRrg4jfeAPdXcwKYMC7fVWR9Sq2AuO+0=;
        b=LEyYbrz9iqHNwMN/I7wJyYMXgSo9uRU6LPaVq+cNZ9i8C7Ob+ixA4pF4rxSkrDxx9Z
         nlvkIqBU6diVjv8OlHWxTzDneZd4ptaH/HUWCKrC900AZhGrzt2nKsmWeKS2m9suCTP4
         ilI2V4gWeIH+AHSE8uedruobq9kuCEBIEQ8+I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=CuMZqJ0mwKj/kIDbFRMKeUGJ/oIiK0QF9aMiwRFyDvz7tLxE1nHNvbWG2lHFnc/ikv
         grrRiuoHiM91QsJHlp+jOwIR7Uj+RcSu35ZJWsdSf6UkmcREvtx5YEIrsVZgAkzklu8d
         vGSLc8HcT0wMT81hFXKD5QurPH4fipySIRmIg=
Received: by 10.151.46.17 with SMTP id y17mr2184627ybj.211.1234078496105; Sat, 
	07 Feb 2009 23:34:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108924>

TortoiseGit 0.3.3 released.
http://code.google.com/p/tortoisegit/downloads/list

This release included great new features:

 1.Show version tree in log dialog.
          Show version graphic tree at log list dialog. Use QGit style.

 2.Enable log cache to improve log show speed.

 3.Icon Overlay(XP olny)
   Show different icon overlay at git repository. Support File and
directory icon overlay.


 4.VS2008 Style Blame application.
          Show different back color according to line age. Show blame
file log list to know which line is newer.

 5.Enable conflict handle
    Show conflict status at any file list, such as commit dialog. User
just need right click and choose resolve conflict, tortoisemerge will
be launch.

 6.Related time show support.

 7.Setting dialog support.

 8.Enable TortoisePlink.
          Passwork dialog can prompt when use tortoiseplink as ssh client.

 9.Git Reset support.
   User can right click log list at log dialog. Choose reset to reset
current branch to chosen commit.

 10.Current handle renamed file at file list.

Fix bugs

 *Issue 20:  Add To Ignore from Commit dialog not working
 *Fix Issue 31 in tortoisegit: Init Repository, Commit dialog can not
show added file
 *Issue 30: Clone does not support UNC path to repository
 *Fix when setting ssh client is null. GIT_SSH environment variable is not clear
 *Fix Issue 29:  F5 should refresh TGit log
 *Fix log filter don't filter commit hash
 *Issue 25:  Log refresh does not pick up new tags on top line, or
move 'master' up
 *Fix Issue 27:  Deleted files not committed
 *Fix Issue 22 Error deleting file from context menu if filename contains spaces
 *Fix Issue 6 Add does not work.
 *Fix issue8. Clone of git via HTTP Creates repo in wrong location
 *Fix issue9. Error commit file with chinese filename.
 *Fix issue10. Switch and Create Branch drop-downs only display 25 items
 *Fix issue13. Create branch fail if branch name is invalidate
 *Fix issue14. Commit dialog don't report error when no message input
 *Fix issue16. Commit dialog, F5 don't work.
 *Fix "explore to" in context menu in commit dialog.
 *Fix redraw all when loading thread finish load log.

Known issue:
 *Git clone can't support git protocol. SSH need enable TortoisePLink
as SSH client. User should use setting dialog network page to setup
TortoisePLink as SSH client.
 *Git clone can't capture TortoisePLink output. So there are no
progress info during download from remote repository.
 *When File overlay enable, explore may be crash at very very special
case. Detail info,please see,
http://code.google.com/p/tortoisegit/issues/detail?id=34. If you meet
frequently, you can disable file overlay by setting dialog to set
overylay is none.
