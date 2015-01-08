From: Minty <mintywalker@gmail.com>
Subject: Re: git svn import failure : write .git/Git_svn_hash_BmjclS: Bad file descriptor
Date: Thu, 8 Jan 2015 17:51:40 +0000
Message-ID: <CANBgh6gJ3dFK7uxWQKYu83H_Hz_LNPpomnNM_mULCe7Om=5aDg@mail.gmail.com>
References: <CANBgh6jyvbquuAwpWuuG4mJ3uZgajchcsJnttn4tN+LNE6EK+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 18:52:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9HFK-0007fq-Hi
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 18:51:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756823AbbAHRvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 12:51:42 -0500
Received: from mail-qc0-f181.google.com ([209.85.216.181]:55812 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbbAHRvl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 12:51:41 -0500
Received: by mail-qc0-f181.google.com with SMTP id m20so3397900qcx.12
        for <git@vger.kernel.org>; Thu, 08 Jan 2015 09:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=9fIe79vEkeClaUqs6CaVDdxHHkae8T2O4vTrQ8/t1Po=;
        b=YurM9SP+Xg95djIcxYWYb6aDSJ+EJVYJBoAgITpl/wGubC1qn+qHR7TdZzjxuz2yqD
         iIg5xDDrvGFgRLR3Ywp9oAWdmH3kKU1RYNY+Mm254uliRaBbg90yF6ggCWDhKj8X5oOu
         fc24KSyvFW68yVlx2KBEDOGQ0AuldAUoL41Xx0j5HFY85YT1sInjyo9p1JjCbCfnE5uQ
         HZRuJlQBPikpsPQaBTlPn/xWU1Dk2+/JN7Cx2O9AyfARUzEw9IJsmjagl6Zxa5GaYB9t
         IEJ9/N4rXa1Qgyn7x9YxzvHMKk5EwK/wIVXeYO83tUXISVa+Mhj0mOjzCRyMc9FjXsCL
         FKSA==
X-Received: by 10.140.100.248 with SMTP id s111mr17263073qge.44.1420739500225;
 Thu, 08 Jan 2015 09:51:40 -0800 (PST)
Received: by 10.229.90.197 with HTTP; Thu, 8 Jan 2015 09:51:40 -0800 (PST)
In-Reply-To: <CANBgh6jyvbquuAwpWuuG4mJ3uZgajchcsJnttn4tN+LNE6EK+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262201>

On Thu, Jan 8, 2015 at 12:43 PM, Minty <mintywalker@gmail.com> wrote:
> git svn clone https://www.example.com/dshfkjhfsjhsdkjfhsdf/nameofrepo
>
> r869 = 9823c89bbdfa9d51aeb0a16c539049ae96nd5d62 (refs/remotes/git-svn)
>     D    path/to/stuff/Example1.java
>     D    path/to/stuff/Example2.java
> W: -empty_dir: path/to/stuff/Example1.java
> W: -empty_dir: path/to/stuff/Example2.java
> r870 = b1f06434b0b2f37a11be2ee5dfc6175bjs348545 (refs/remotes/git-svn)
> write .git/Git_svn_hash_BmjclS: Bad file descriptor
>  at /opt/local/lib/perl5/vendor_perl/5.16.3/darwin-thread-multi-2level/SVN/Ra.pm
> line 623.

fyi - tried the same repo, same command under Ubuntu 14.04, using the
stock git-svn deb & it worked.

happy to help try debugging the problem on MacOS if anyone wants to
give me a pointer, but otherwise I'm good.

Thanks.
