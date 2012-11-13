From: =?Big5?B?pEG7xL5Z?= <ch3cooli@gmail.com>
Subject: Commit message problem of reverting multiple commits
Date: Tue, 13 Nov 2012 23:15:59 +0800
Message-ID: <CAHtLG6Qn68TFVnd_8LSf6OMqHZduAFgk0Hd46E3vKgFHCjpksQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 16:16:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYIDp-0002Pe-0b
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 16:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754563Ab2KMPQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 10:16:03 -0500
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63118 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753607Ab2KMPQB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 10:16:01 -0500
Received: by mail-lb0-f174.google.com with SMTP id gp3so265248lbb.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 07:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=pshDPU0TtlV6SBkRhyX8HZvC/pEke/BnFJXNuaxtJUE=;
        b=d/986Udkra8rQ1iB/GohLdCF1tvdiFHBwzHw6h2NUR78PAUOixPWRG8vyzF+be78KC
         KZh5CoJ9S15X6VGb3TxWy8+6m3wsu3XpgyFSAw7EMbNS3Y7DgZru3Ay0eWRMeCwr5h9/
         PnMx/CwiGaGSld/j6ifWTtxedMybhWcb+M7zn6ZoO78VLaMQ4nbWiwvVwQqTfL4EXSxh
         85dzNy33O/Utu8m0G7vpxompVm9Wmzpkeq10+XiZVpsbFsFF2/ua0/jKqApdQYYWLjFx
         Nq3ZOWHDkrK39gi537tV5Wvne+ap466wuYJuUFNdO75dDsnH2doR9Z86cFUlUzyClW9A
         vpbw==
Received: by 10.112.38.226 with SMTP id j2mr5997780lbk.128.1352819759906; Tue,
 13 Nov 2012 07:15:59 -0800 (PST)
Received: by 10.112.132.199 with HTTP; Tue, 13 Nov 2012 07:15:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209614>

Hi,

I ran git 1.8.0 command line

git revert --no-commit rev1 rev2

I see a prepared commit message like

Revert "<description from one commit>"
This reverts commit <SHA1 of one commit>.


The actual revert content is correct - it is all the relevant commits
that were selected. I expect the message to reflect this:

Revert "<description from commit1>", "<description from commit2>"
This reverts commits <SHA1 of commit1>, <SHA1 of commit2>.

Regards,
ch3cooli
