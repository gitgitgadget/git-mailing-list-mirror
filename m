From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Major git-svn fail
Date: Fri, 29 Jan 2010 11:08:38 +0800
Message-ID: <be6fef0d1001281908t53f66031udf917bf02eedcf9f@mail.gmail.com>
References: <20100129015016.GD759@hlagh.dongs>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Rafael Kitover <rkitover@io.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 04:08:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NahDx-0003Zx-CB
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 04:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756626Ab0A2DIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 22:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756613Ab0A2DIk
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 22:08:40 -0500
Received: from mail-iw0-f172.google.com ([209.85.223.172]:48540 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756612Ab0A2DIj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 22:08:39 -0500
Received: by iwn2 with SMTP id 2so831458iwn.19
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 19:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=anK0XbeTd00l3QgUcI2w5gkuot4IH16QBPGIoS/VPD4=;
        b=WgJRyoGA5sbs4VIIK6PaLgGVnEgm3A4HkACm9+CNNgOmaQ6wY15SuUlpn4lb8IzEpa
         pk+0gCiLTxyggRSpZNp88a1oUqijjSgZ1FYoXTpVboBEDmLfBK7SIo0LC6W7MYgl2wkg
         v+RCWUxLGHzNO26PwZ9jULQswTwvNanJUtgO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=ApUoty/ZZ5tzvgiBVsQtY7dnnR6ofh8SjZ3c8MNBbjqjHaG308XBfsTTyPmYzBo2Cj
         mjv6OSOqtwIneW+R8NObUNtbWbI3yzrNMrDYht8YaVgpma92Q1XYzRnaUdzfGo2Tf5i/
         sFSxN5jv6vt6dBonXuXePUpUAnbbHrLZRVQxQ=
Received: by 10.231.59.5 with SMTP id j5mr427378ibh.6.1264734518311; Thu, 28 
	Jan 2010 19:08:38 -0800 (PST)
In-Reply-To: <20100129015016.GD759@hlagh.dongs>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138298>

Hi,

On Fri, Jan 29, 2010 at 9:50 AM, Rafael Kitover <rkitover@io.com> wrote:
> This is the command I'm using and the results:
> git svn clone --authors-file=sl-authors.txt
> --branches='http://dev.catalyst.perl.org/repos/bast/branches/DBIx-Class-Schema-Loader/'
> --tags='http://dev.catalyst.perl.org/repos/bast/DBIx-Class-Schema-Loader/tags/'
> --trunk='http://dev.catalyst.perl.org/repos/bast/trunk/DBIx-Class-Schema-Loader'
> 'http://dev.catalyst.perl.org/repos/bast/trunk/DBIx-Class-Schema-Loader'
> sl
> Initialized empty Git repository in
> /home/rkitover/src/git-conversion/sl/.git/
> Using higher level of URL:
> http://dev.catalyst.perl.org/repos/bast/trunk/DBIx-Class-Schema-Loader
> => http://dev.catalyst.perl.org/repos/bast
> perl:
> /tmp/buildd/subversion-1.6.9dfsg/subversion/libsvn_subr/path.c:115:
> svn_path_join: Assertion `svn_path_is_canonical(component, pool)'
> failed.
> error: git-svn died of signal 6
>
> The authors file I'm using is:
> http://cachemiss.com/files/sl-authors.txt

I ran this:

  $ git svn --version
  git-svn version 1.6.6.1.436.gaba7d (svn 1.6.6)

  $ git svn clone --authors-file=sl-authors.txt \
  --branches=http://dev.catalyst.perl.org/repos/bast/branches/DBIx-Class-Schema-Loader/
\
  --tags=http://dev.catalyst.perl.org/repos/bast/tags/ \
  --trunk=http://dev.catalyst.perl.org/repos/bast/trunk/ \
  http://dev.catalyst.perl.org/repos/bast/

This is what I got:

  Initialized empty Git repository in /home/Owner/tmp/foo/bast/.git/
  Using higher level of URL:
http://dev.catalyst.perl.org/repos/bast/trunk =>
http://dev.catalyst.perl.org/repos/bast
  r1 = f48f2e41631e82bec48ad96ec206faf0b5893226 (refs/remotes/trunk)
  ....

Looks ok.

-- 
Cheers,
Ray Chuan
