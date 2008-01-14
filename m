From: "Paul Umbers" <paul.umbers@gmail.com>
Subject: Git Cygwin - unable to create any repository - help!
Date: Mon, 14 Jan 2008 10:21:44 -0700
Message-ID: <a5eb9c330801140921m63b1b8a9pe67bf6f0d2e58dba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 14 18:22:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JET1C-0004XR-2F
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 18:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550AbYANRVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 12:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbYANRVq
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 12:21:46 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:61442 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbYANRVp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 12:21:45 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3770403wah.23
        for <git@vger.kernel.org>; Mon, 14 Jan 2008 09:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=7RfjwYg0gVfKHydKbqkyTixSX2JbBfTNPpfQfCI+z7A=;
        b=D82zd/YvjVyxevRX2PRI9xwSKGsFnhp8HqhY9L1WHszuTc+/fy3FHD/1MpYwpXmfCHR3Am6KbCjWaaV3R9e8OIrIfkyBb3HKLVn52ljEK/dvF+UQZpIXavxkeaoAeiRugRxwOJSUCT857SDTWWKYeZhilzbzH9KJOvep8GPzRok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Cwv9oRMYOp2WFFebUyhrbzFyobYH/U8Y1feZzPNHf+8Cma5yDbT3ajSHwPog//Jvwun+JgvMuy9ebmczGCRicU3JWWKuFcF6NCevtoRVoEb8kdO4mixqh7jvqR3cy2dh26rGD2GtcGgomgLSitqj2IyOIjeBWuCtEjv4b3StDZk=
Received: by 10.114.77.1 with SMTP id z1mr2183766waa.56.1200331304328;
        Mon, 14 Jan 2008 09:21:44 -0800 (PST)
Received: by 10.114.137.1 with HTTP; Mon, 14 Jan 2008 09:21:44 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70465>

Trying to create a repository under the cygwin install of git, windows
XP Pro. I can create the initial repository OK using "git init" and
add files using "git add .", but when I come to commit I get the
messages:

error: invalid object d9b06fceac52f6c24357e6a7f85c601
088381152
fatal: git-write-tree: error building trees

git-fsck gives me:

notice: HEAD points to an unborn branch (master)
notice: No default references
missing blob d9b06fceac52f6c24357e6a7f85c601088381152

This is with a simple repository of one directory containing one plain
ascii text file with some text in it. I get similar messages, with one
missing blob for each file or directory in the project, on more
complex projects. At home, I use git under Ubuntu linux and haven't
had any such problems.

The git/cygwin install followed the instruction for a cygwin binary
installation from the wiki and no problems were reported. I've been
unable to find online comments relating to this problem and am stuck.

Any suggestions?

Paul
