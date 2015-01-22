From: =?UTF-8?Q?Nico_Schl=C3=B6mer?= <nico.schloemer@gmail.com>
Subject: error closing pipe: Bad file descriptor at /usr/share/perl5/Git/SVN/Fetcher.pm
 line 335.
Date: Thu, 22 Jan 2015 14:11:34 +0100
Message-ID: <CAK6Z60couQodKaAktF4r5GBiff=T-Nkjp5AkUBd1EC97JqVtxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 22 14:12:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEHYH-0001N6-A3
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 14:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbbAVNL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 08:11:58 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:39277 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbbAVNL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 08:11:56 -0500
Received: by mail-lb0-f182.google.com with SMTP id l4so1391534lbv.13
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 05:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=oXdUpJoQNaHR4/b1HiCeoebbt4ajdyhJ9/9BzPix4mE=;
        b=0E9xfyUzUi5l4wohbsuH+Ev9VdcieGgF49YSDXzstfOUV6/jSoEcGuWYU4lNRcXmu1
         cJrm57EkLh03h1/uzZazw7dfVkGZZ5BQZfqwabBgWLWp82k5oeLCCzQi0wPKFWcXvL+S
         D3Ih5dK5OC+bH7miGIOV9XXC21moKLHvFZxLKzhhylDqtNkQ8OV4Ep27Wfd7NEcHekMK
         9t49ax7PylxKXWMF4bta8S7wqyb6sBT9RmY4fonDadcMbHlXYtLtFir/UXw/bd+tm74D
         AGdN/1/eAIIIMRhw1hpqZFoPhgpsMZgCXIBzs4wXmXxIG2ivZ5wXjGBslJxTrtZgaclT
         yTOQ==
X-Received: by 10.112.30.71 with SMTP id q7mr1424525lbh.41.1421932315398; Thu,
 22 Jan 2015 05:11:55 -0800 (PST)
Received: by 10.114.91.132 with HTTP; Thu, 22 Jan 2015 05:11:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262832>

Hi all,

When cloning
```
$ git svn clone https://geuz.org/svn/gmsh/trunk
```
I'm getting the error
```
[...]
r100 = e2a9b5baa2cebb18591ecb04ff350410d52f36de (refs/remotes/git-svn)
error closing pipe: Bad file descriptor at
/usr/share/perl5/Git/SVN/Fetcher.pm line 335.
error closing pipe: Bad file descriptor at
/usr/share/perl5/Git/SVN/Fetcher.pm line 335.
out pipe went bad at /usr/share/perl5/Git.pm line 955.
```
after 99 commits were successfully checked out.

Apparently, this problem has popped up before in a different context [1].

This is with
```
$ git --version
git version 2.2.2
```
What I can do to help debugging this?

Cheers,
Nico


[1] http://git.661346.n2.nabble.com/git-svn-exits-with-error-error-closing-pipe-Bad-file-descriptor-tt7592213.html#none
