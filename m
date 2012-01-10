From: Steven Line <sline00@gmail.com>
Subject: (unknown)
Date: Tue, 10 Jan 2012 16:56:28 -0700
Message-ID: <CAJ1a7SqErXtmnS1=_O_BjbrKVMNWeKyenGruqQjcDZZy_jb9sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 00:56:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RklYn-0004d4-Nx
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 00:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757124Ab2AJX4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 18:56:40 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:57790 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881Ab2AJX43 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 18:56:29 -0500
Received: by eekd4 with SMTP id d4so32386eek.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 15:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=SmnZbzWNXulz1chWV77yCtAPDdJf6qSZc86lCR36260=;
        b=iRXuBNxDPWaGk2aL1Mta3O+hd+RVjVXHIP5TFoPGe2Jfrrc3ypL28HMlHUllv/9xwg
         dSZnsFnVQ6Y/kQNA//ssQVJc4hqA6i6MqCrEAWC8HGDNg+56nCgFW1FXFlYvJ0SUwUYs
         CHuXwJ6bpv/Q4rWjO1Xq/Wz9YaulBjFYSe8UA=
Received: by 10.152.113.101 with SMTP id ix5mr9750966lab.16.1326239788395;
 Tue, 10 Jan 2012 15:56:28 -0800 (PST)
Received: by 10.152.128.132 with HTTP; Tue, 10 Jan 2012 15:56:28 -0800 (PST)
Subject: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188306>

Hi All,

First off I am a new user to git, I'm not a git developer or power
user.  Am I in the right mailing list?  If not could somebody point me
where I could get some help from experienced git people?

Here's the problem:
I need some help getting my subversion repository cloned over to git.
Our svn repository has about 12,000 commits, when I run
git svn clone -s  -A authors.txt
svn+ssh://csvn@source.res.ourdomain.com/home/svn/sem sem
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
