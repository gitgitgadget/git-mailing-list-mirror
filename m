From: Scott Batchelor <scott.batchelor@gmail.com>
Subject: Git diff-file bug?
Date: Fri, 28 Sep 2012 19:55:10 +0100
Message-ID: <CAEkqydxRy3ukSWyQ53Tiosq+DMWWLG=AVuZk+Jm79Y5SaRmeDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 22:04:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THgnV-00079c-Ek
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 22:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031828Ab2I1UEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 16:04:07 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:41899 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758885Ab2I1SzL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 14:55:11 -0400
Received: by ieak13 with SMTP id k13so8112088iea.19
        for <git@vger.kernel.org>; Fri, 28 Sep 2012 11:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=nA2C0bfMc3P2fh9+Zm/qs6XXOWEa3+zIVm/9u73inQo=;
        b=ZZS18iwHPeAKvOtmhk2U8FchOeqrTHCTJm9axSilYOD65iq/zvaGSUe/emRyfn/5fu
         sAbkzQi3htyKDf/7Cyw/bdvmz5iS/Yu34cNeLU+oT7cE2fZk8+NFQRXQgJTPDHdAoxTN
         d/jgv+Xyzc9qaz4/N0LsjPgC6apsTrT9PLfEW4IIGF2tJTU+RzYIShuDEhqjR+fZTyHj
         hlplUuJR8xjTSCsBQglkkZN4dmUDw6ixd2Z8d5aQ4SjyNM/g8tuyU96LkKPnMbmC6Nd8
         WOUBzULPPF//duyxl47nS8k1v/c5mE7zD1n/iDqh4RueHTMDZeHqzXr2+PkU1DtpHT9f
         NXsw==
Received: by 10.50.7.135 with SMTP id j7mr2513080iga.34.1348858510972; Fri, 28
 Sep 2012 11:55:10 -0700 (PDT)
Received: by 10.50.22.68 with HTTP; Fri, 28 Sep 2012 11:55:10 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206607>

Hello.
I'm fairly new to git and am witnessing some strange behavior with git
that I suspect may be a bug. Can anyone set my mind at rest.

Every so often (I've not quite figured out the exact set of
circumstances yet)  "git diff-files" shows that every file in my repo
is modified, when I expect none to be. If I type "git status" (which
shows what I expect - no files modified) and then "git diff-files"
again, git now shows that no files have been modified (which is what I
expect). It's like "git status" is resetting something that "git
diff-files" uses.

I'm trying to figure out what the problem with "git diff-files" is
because gitk uses it under the hood, and I think that gitk is
reporting  erroneous changes (which are also reset by performing a
"git status" in the repo) in the "patch" files list.

Any thoughts? I'm using git 1.7.11.4 on SLES 10.3.

Thanks,
Scott.
