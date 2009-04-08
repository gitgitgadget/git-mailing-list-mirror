From: Frank Li <lznuaa@gmail.com>
Subject: [ANNOUNCE] TortoiseGit 0.5.1.0 release
Date: Wed, 8 Apr 2009 12:58:39 +0800
Message-ID: <1976ea660904072158u25ddc65cw5f912a58d46bd741@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: tortoisegit-dev <tortoisegit-dev@googlegroups.com>,
	tortoisegit-users@googlegroups.com, git@vger.kernel.org,
	tortoisegit-announce@googlegroups.com, tortoisegit@googlegroups.com
X-From: git-owner@vger.kernel.org Wed Apr 08 07:00:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrPtY-0001ZV-C7
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 07:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752561AbZDHE6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 00:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752144AbZDHE6l
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 00:58:41 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:4454 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752087AbZDHE6l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 00:58:41 -0400
Received: by qw-out-2122.google.com with SMTP id 8so3399691qwh.37
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 21:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=B5f/aFI0KOAkMlb62EJkf+m/zhjzqw/KEe3hyVQ6I3I=;
        b=i4Q9K4bfGnFhWyjtOh0sJfrYlDre4SMvXed+1OtyAw/9ouYf1hR0GenfxdBqH7cgqc
         dPzenqFhp3P4S5a4BzbN6Hv7tsNBsyoHSS4GNrjoGfQw5TrYfy//MC+07V5mHwXeDr+S
         QgVpd3LQ2YUP0tFCM8d0U1iynBfVtUDq0uHH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=DWqaH/f1QO8pjLriii0rYx00rWKjfrr1zRSwfJZ+YD3kcTYQXDdOXSQ7GRnCHh0BaG
         sLP17gAl5CY0HXH21JCzq99bHD4teTWSRN5vZMLpxFHTmPQU42LiMF9JQBl9ABe38bnu
         +N4H0/BRQJLbPUtCxGyhqLXx1gkELqZsHVlUk=
Received: by 10.229.84.72 with SMTP id i8mr450627qcl.63.1239166719579; Tue, 07 
	Apr 2009 21:58:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116033>

32bit version: http://tortoisegit.googlecode.com/files/TortoiseGit-0.5.1.0-32bit.msi
64bit version: http://tortoisegit.googlecode.com/files/TortoiseGit-0.5.1.0-64bit.msi

Version 0.5.1.0 version(external)
Fix:
               TortoiseMerge Crash at 64bit system.

Version 0.5.0.0 version(internal)
Features:
       *Submodule Support.
        Support submodule add, sync and update.
                "Submodule Sync" is located in explore context
external menu, which need press "shift" key when right click.

       *Improve show log speed at big repository, such as git.git

       *OpenSSH can prompt password dialog

       *Clone, pull push support both OpenSSH and Plink.
        Support both key and password mode.
        Show progress when clone at git and SSH protocol.

       *Stash Save\Apply support

       *Reflog support. Need press "shift" to show reflog menu item at
context menu.

       *Add save special version to another file at file list, such as
log dailog.

       *Add external diff merge and undiff setting at settings page

       *Add Diff with workcopy at file list

       *Add MessageBox Tell user Revert Finished

       *Add Notepad2 to setup script to view text file

       *Add view in notepad2 at file list

       *Add Copy File list to clipboard

       *Choose Default SSH client when install TortoiseGit

       *Add user config and remote manage at setting dialog

       *Pull and push can autoload putty private key.


Bug Fix:
       *Fixed Issue 55:  "resolved" function doesn't delete temporary files.
       *Fix: Issue 57:  Data duplication when Clicking Check repository in
Check for modification dialog
       *Fix GetString error when edit at HistoryCombo
       *win2k context menu fix (had an issue when shift key was pressed)
       *Fix crash in logviewer on invalid time strings
       *Issue 61:  Add/Commit of files with umlauts in filename not working
