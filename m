From: Steven Line <sline00@gmail.com>
Subject: git svn clone terminating prematurely (I think)
Date: Tue, 10 Jan 2012 17:02:09 -0700
Message-ID: <CAJ1a7SrkDOyNRv8Spo4xvoKjP4zaXteim4h3JGcWU-nYDugx9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 01:02:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkldy-0006kz-IW
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 01:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756622Ab2AKACO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 19:02:14 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45489 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576Ab2AKACM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 19:02:12 -0500
Received: by eaad14 with SMTP id d14so46477eaa.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 16:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=zKMJol+1SoGvy93FRo8zwbxuu7rTIESmDB+rP+oL5Rg=;
        b=FXDDpEGbgujWrDHL5W0t98LFe8dlzeEk50P2az/E/zIJQffuRh5gXeCWYEVMh/heAL
         l2RczhOB/Wcr5L12B3MnJM/aQ1Y1Mf45ZsrYOO0X6nRcfwUhmcB2A/VJ2YmBkmmunYXy
         V5zWR7eUBMgki+Evm/iOnl1VMfRJnCusnHWNU=
Received: by 10.112.84.163 with SMTP id a3mr4923711lbz.53.1326240129778; Tue,
 10 Jan 2012 16:02:09 -0800 (PST)
Received: by 10.152.128.132 with HTTP; Tue, 10 Jan 2012 16:02:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188307>

Reposting this with a better subject than (unknown) . . .

Hi All,

First off I am a new user to git, I'm not a git developer or power
user.  Am I in the right mailing list?  If not could somebody point me
where I could get some help from experienced git people?

Here's the problem:
I need some help getting my subversion repository cloned over to git.
Our svn repository has about 12,000 commits, when I run
git svn clone -s  -A authors.txt
svn+ssh://csvn <at> source.res.ourdomain.com/home/svn/sem sem
It runs for about 2h 15m then completes with no error messages. I have
also cloned starting at revision 6300, about the middle of the svn
repository, and I get the same results as below.

After cloning, I cd into the sem directory and run

$ git log
fatal: bad default revision 'HEAD'

$ git log --all  # this seems to work

$ git branch -a # shows only about half the branches that should have
been cloned

$ ls -al sem
total 6
drwxr-xr-x   3 git      other        512 Jan 10 20:58 ./
drwxr-xr-x   6 git      root         512 Jan 10 20:58 ../
drwxr-xr-x   9 git      other        512 Jan 10 23:13 .git/

I think this means the clone terminated prematurely but other than
that I'm stuck. There were no error messages from the clone.  Could
somebody give me some suggestions on what to try?  I haven't found the
answer via google yet.

Thank you for any help.

-- 
Steven Line
303-910-1212
sline00@gmail.com
