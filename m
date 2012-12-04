From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: git-svn with non-standard repository layout
Date: Tue, 4 Dec 2012 18:29:30 +0100
Message-ID: <CAA01CspaYewmhTcYCWscsOWoNPvb6a=G1Ak0-=_spJSh6fsdHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 04 18:29:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfwJX-00072p-GV
	for gcvg-git-2@plane.gmane.org; Tue, 04 Dec 2012 18:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498Ab2LDR3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2012 12:29:32 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:61653 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab2LDR3b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2012 12:29:31 -0500
Received: by mail-qa0-f53.google.com with SMTP id a19so939892qad.19
        for <git@vger.kernel.org>; Tue, 04 Dec 2012 09:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=uGD18MnelNHA8GzforYr5UUQ+ozSGAcLiqHj5bUxLkw=;
        b=gpMqkbtOpow/zVzCsD+k85PzQjP2k06Ven93hzsNwz0tmJMcHKk0o+KG0+A+se/qGA
         fstS/gNUs1BDX5QSbFrpQ347Cnb51thINCe0emOExkdCi27LZJK3L9JtBHSJsufKJ0R2
         cSi+n+GZj9IlMNOZMpDlhYjJ2LbHyDjJagEmqwGPtG04X0upn+q8lIaHD+dXWgBuFI17
         aiQLst+6PcHqoc1FwL2DBdbS8T7IuY08BV/ml8dREgQjmIbOea0MAPHCpYIwx1Uj0hie
         2w2U2if4AqvULvFwEjw6pz9761BeF5vWa6PIHTdEMpvitO2zBmP6ttc6vrzJouuokiSZ
         66fg==
Received: by 10.224.71.16 with SMTP id f16mr24114669qaj.45.1354642170653; Tue,
 04 Dec 2012 09:29:30 -0800 (PST)
Received: by 10.49.26.132 with HTTP; Tue, 4 Dec 2012 09:29:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211090>

Hi,

Is there a way to handle svn repository with following layout?

repo/trunk
repo/branches/branch1
repo/branches/branch2
repo/branches/work/developer1/branch3
repo/branches/work/developer1/branch4
repo/branches/work/developer2/branch5

In default configuration it treats "work" dir as a branch. If I
configure it with branches = branches/work/*/* it recognizes them
correctly, but then the "normal" branch1, branch2 are lost.

Ideally, I'd have one git repo with trunk, branches/{branch1,branch2},
work/developerX/branchY branches...

Any ideas?

--
Piotr Krukowiecki
