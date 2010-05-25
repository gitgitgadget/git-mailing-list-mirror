From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: What's cooking extra
Date: Tue, 25 May 2010 10:33:19 +0200
Message-ID: <20100525083319.GA588@localhost>
References: <20100522130916.GA28452@localhost>
 <50199F1F-3513-43A6-8990-957F3D0AF58C@gmail.com>
 <20100522222746.GA2694@localhost>
 <CDD31343-2352-434B-B875-2013DAF49CE7@gmail.com>
 <20100523115127.GA20443@localhost>
 <744D05D2-FC47-45E5-92A1-CD93B0901E0C@gmail.com>
 <20100524094905.GA10811@localhost>
 <986EE696-5997-40AD-929C-D82D40D7242E@gmail.com>
 <20100524221128.GA29588@localhost>
 <246B0C3F-EBD3-41EC-B0FD-300BD1DBF43E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Finn Arne Gangstad <finnag@pvv.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 25 10:33:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGpZw-00029N-0L
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 10:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754947Ab0EYIdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 04:33:31 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39522 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab0EYId3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 May 2010 04:33:29 -0400
Received: by fxm5 with SMTP id 5so3022802fxm.19
        for <git@vger.kernel.org>; Tue, 25 May 2010 01:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=whgrjycbym858cSCZXgrOY2cLjqnbZQX2cRh5vC2lDo=;
        b=HST7BkgrvRGHEonJxbqj64d63K7acJRqYaQVZVm+icLoFiG5QGsmPOwKZ7aSaNQntF
         1uG0A8N91iRRCZXPplrkjOt9wxpL421EZcn2FD9qquuTE5z44svDuOMrxdt9ss/lnyKt
         oR5MyPi/TFMMgFS16JVh1bwKrICyNjd03+hcc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=wKJrqrIMkoivNqkrHRtgblMlcU6fvYPoms93maFBpNn9IOw1d4UNTfua0twqbGmleA
         uVaVzrA8hEI8OKaI3tFeBLc4JozmkLIVe6806OqqwFwJtOxYU8NQ6vkDjn2Jr9T9mgjX
         Ynlni+nE5gIUhl6ctUSZyoLYgaTShouyz2RQQ=
Received: by 10.103.7.26 with SMTP id k26mr5061317mui.15.1274776408184;
        Tue, 25 May 2010 01:33:28 -0700 (PDT)
Received: from darc.lan (p549A4082.dip.t-dialin.net [84.154.64.130])
        by mx.google.com with ESMTPS id 7sm19135051mup.13.2010.05.25.01.33.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 May 2010 01:33:27 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OGpZf-0000R1-4m; Tue, 25 May 2010 10:33:19 +0200
Content-Disposition: inline
In-Reply-To: <246B0C3F-EBD3-41EC-B0FD-300BD1DBF43E@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147684>

On Tue, May 25, 2010 at 08:41:14AM +0200, Eyvind Bernhardsen wrote:

> On 25. mai 2010, at 00.11, Clemens Buchacher wrote:
>
> > And once we normalized the file to LF, why don't we also checkout
> > that version, or at least mark it as dirty in the index, so a reset
> > --hard will fix it up?
> 
> I dunno.  Won't it be even more confusing that the file is still
> dirty after you add it?  The problem with converting it in the
> working directory when you add is that it loses information: if
> you didnt' want that file to be converted, there's no way to
> revert (this is very bad if it's a file that contained a mix of
> CRLF and LF).

I was trying to illustrate this with a test script, but after
playing with this some more, I noticed that this is not a problem
with your changes, since I can reproduce with git v1.7.0.5:

#!/bin/sh

cd $(mktemp -d)
git init
git config core.autocrlf input
echo -n 'hi\r\nbye\r\n' > file
git add file
git commit -m initial

# no output
git diff --name-status

sleep 1
touch file
# file dirty
git diff --name-status
# at this point, reset --hard would convert 'file' to LF in the
# work tree

git update-index file
# no output
git diff --name-status

The same behavior can be observed with the 'eol=lf' attribute,
before and after normalizing the file.

Regards,
Clemens

---
$ sh -x testcrlf2.sh
+ set -e
+ mktemp -d
+ cd /tmp/tmp.Smnx0U7IT1
+ git init
Initialized empty Git repository in /tmp/tmp.Smnx0U7IT1/.git/
+ git config core.autocrlf input
+ echo -n hi\r\nbye\r\n
+ git add file
warning: CRLF will be replaced by LF in file.
+ git commit -m initial
[master (root-commit) d3be96f] initial
warning: CRLF will be replaced by LF in file.
 1 files changed, 2 insertions(+), 0 deletions(-)
 create mode 100644 file
+ git diff --name-status
+ sleep 1
+ touch file
+ git diff --name-status
M       file
+ git update-index file
warning: CRLF will be replaced by LF in file.
+ git diff --name-status
