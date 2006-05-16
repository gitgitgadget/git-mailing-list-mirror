From: Santi <sbejar@gmail.com>
Subject: "git add $ignored_file" fail
Date: Wed, 17 May 2006 00:07:08 +0200
Message-ID: <8aa486160605161507w3a27152dq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed May 17 00:07:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg7hL-00045i-07
	for gcvg-git@gmane.org; Wed, 17 May 2006 00:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWEPWHL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 18:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWEPWHK
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 18:07:10 -0400
Received: from wx-out-0102.google.com ([66.249.82.203]:42092 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932205AbWEPWHJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 May 2006 18:07:09 -0400
Received: by wx-out-0102.google.com with SMTP id s6so59892wxc
        for <git@vger.kernel.org>; Tue, 16 May 2006 15:07:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=jNE4C33xTw5VC0UISRhj7exHe/tcPBKFCiDYW8Nmn9dd6rgmyduVzoGqgdodWY89T7hPH5n7sk/s33F8XXGjYGVstNAvlCjkmkJ7gEPTYid6QI2ZySujG4M8u22efD1nOHXnM+cJUSssNiQdLw5dLVQGESm3uzX/3S4qDhmRnHc=
Received: by 10.70.46.14 with SMTP id t14mr275963wxt;
        Tue, 16 May 2006 15:07:08 -0700 (PDT)
Received: by 10.70.20.2 with HTTP; Tue, 16 May 2006 15:07:08 -0700 (PDT)
To: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20139>

Hi *,

      When you try to add ignored files with the git-add command it
fails because the call to:

git-ls-files -z \
        --exclude-from="$GIT_DIR/info/exclude" \
        --others --exclude-per-directory=.gitignore

      does not output this file because it is ignored. I know I can do it with:

git-update-index --add $ignored_file

I understand the behaviour of git-ls-files but I think it is no the
expected for git-add, at least for me.

    Thanks

    Santi
