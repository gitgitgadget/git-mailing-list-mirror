From: Lars Hjemli <hjemli@gmail.com>
Subject: [ANNOUNCE] CGIT 0.8.2.1
Date: Sun, 15 Mar 2009 09:41:09 +0100
Message-ID: <8c5c35580903150141t7014d1e7mbe9dcc80bcfeac2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 15 09:42:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lilvd-0002pu-JE
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 09:42:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbZCOIlN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2009 04:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbZCOIlN
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 04:41:13 -0400
Received: from mail-ew0-f177.google.com ([209.85.219.177]:47334 "EHLO
	mail-ew0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbZCOIlM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 04:41:12 -0400
Received: by ewy25 with SMTP id 25so3092173ewy.37
        for <git@vger.kernel.org>; Sun, 15 Mar 2009 01:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=qe9Mq6SG/K/85fCtIBmRYLwRd0tqxVCYwLhM9tkl68E=;
        b=U1KSIFEKzG5CDCKEYohFO/VgtH9MRcOz9M2nVHFkgKiQZvCQ6l3LcDnUEuOVSKMc/G
         FDqIvWhHpspLZ4ygG4/SwTY6FMM3hEa5eRlkWR8+QIs7+wKXJSjrPDJcwVRCxAAz5p3V
         qgNoMqJtKwUyB5ErklZCIZV6yFXTGnYEPkThw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=e37jBXmzvO6iTYwFKBW5qvVl0oIkn3QVMTqwnqmk0sMvSmhA+Er1kap+SbRZYwqv93
         tWye6dLaXFUgiJmD+uULATHRsyvUaWU7+GH0mQpsqGNUl/+dLt5caozn5IYYUlDaqzcN
         6OPzxVlh8L0s/PB1stYVSSw/4BLIaUiI8MQyY=
Received: by 10.210.90.20 with SMTP id n20mr2424218ebb.77.1237106469193; Sun, 
	15 Mar 2009 01:41:09 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113277>

A new bugfix-release of cgit, a fast webinterface for git, is now available:

Clone:   git://hjemli.net/pub/git/cgit
Browse:  http://hjemli.net/git/cgit

Shortlog since v0.8.2:
Eric Wong (1):
      fix segfault when displaying empty blobs

Lars Hjemli (3):
      ui-tree: escape ascii-text properly in hexdump view
      ui-snapshot: avoid segfault when no filename is specified
      CGIT 0.8.2.1
