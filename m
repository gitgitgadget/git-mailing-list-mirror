From: "Tony Stubbs" <antony.stubbs@gmail.com>
Subject: git svn rebase - could not detach HEAD
Date: Thu, 7 Aug 2008 18:49:29 +1200
Message-ID: <f7d8f60b0808062349q92fffb9l33de5550250e4e13@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 07 08:50:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQzKW-0001Vm-G0
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 08:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbYHGGtb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 02:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752953AbYHGGtb
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 02:49:31 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:56193 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826AbYHGGta (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 02:49:30 -0400
Received: by rv-out-0506.google.com with SMTP id k40so324696rvb.1
        for <git@vger.kernel.org>; Wed, 06 Aug 2008 23:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=O4XNu9bF8lqMooQ+4Kw/d1UzfLW6vyAsM9kVMfMrOb4=;
        b=plbgy/AGZLArw57UYdHqKlZ0u4xGMEUjL7EajrtcWwdmwulsSc6t3Hi+mRP7wNyVPi
         xtkXvmV6tV8aCoSOQckr6U46xH8UF9FnYfvryp7WL7CLXTu0FcRf86IkkJMbSkWGt4EW
         Sgvwy/+78+Kd6bLJo4dNoz24D8ozUMQL9oYgs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Ui29Izj1Ye+bjAbwTKYhxwG+m5NMkLL4iJfD5yvEvnf4ZEx9p39fKKnIliGhLMfZ3o
         PnbPjFrccB2RSBbyfxgNus3o+PuOnba9nRTEThKGxl5FWJKVUFnqid+RXWyhWwSCUDwy
         j5FLoi27DNxjHxqfk+FRB5GEsFyc/FA//nvzk=
Received: by 10.114.178.13 with SMTP id a13mr1130122waf.158.1218091769586;
        Wed, 06 Aug 2008 23:49:29 -0700 (PDT)
Received: by 10.114.157.2 with HTTP; Wed, 6 Aug 2008 23:49:29 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91559>

Having trouble rebasing against svn off a clean repo.

I am using windows / cygwin.

Here's the output:

stubbsa@VFNZV95336 /cygdrive/c/dev
$ git status
# On branch master
nothing to commit (working directory clean)

stubbsa@VFNZV95336 /cygdrive/c/dev
$ git svn rebase
First, rewinding head to replay your work on top of it...
could not detach HEAD
rebase refs/remotes/git-svn: command returned error: 1


stubbsa@VFNZV95336 /cygdrive/c/dev
$

I already tried asking on the channel...
Any ideas? I'm kind of stuck as I have commits I need to dcommit.

p.s. git stash also shows:
stubbsa@VFNZV95336 /cygdrive/c/dev
$ git stash
No local changes to save
