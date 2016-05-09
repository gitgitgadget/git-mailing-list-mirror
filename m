From: Thierry Suzanne <thierry@yellownemo.com>
Subject: Re: Found possible branch point, then "Use of uninitialized value $u
 in substitution/concatenation"
Date: Mon, 9 May 2016 18:35:31 +0100
Message-ID: <CALZdSA8KU__QAywW8CoJ5=DVWPUOpyoo0Je83+6yU4CbS+PM6A@mail.gmail.com>
References: <CALZdSA_pDy=B-bgB-vjpi1yjgtse_-07ewXSX0_GsYhLfOUbzw@mail.gmail.com>
	<CAP8UFD0k0Kx306S3y-Kd5328j0MDNL+ewCJvXbsJ1nzsJYRdtg@mail.gmail.com>
	<CALZdSA_eF--tdDAPwEfopioB+X=n7Xti-ixGNJqEwvDdCwo2pg@mail.gmail.com>
	<CAP8UFD2dH+nDdpiURK=MePz-JiOOcv3V=NJWjdMYo--oyNZ04g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 19:37:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azp5l-0003rj-4I
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 19:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbcEIRfd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 13:35:33 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:36609 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbcEIRfc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 13:35:32 -0400
Received: by mail-ig0-f194.google.com with SMTP id c3so11984565igl.3
        for <git@vger.kernel.org>; Mon, 09 May 2016 10:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yellownemo-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=zFrdWxF7Sxm41OO5S1Vv6lunG4IB+wpk30nIeFN3G6A=;
        b=Mte1qWqFCpnV2q4QIeyJ6LOM2u/m2nCOdOM0dVZGHKiKbuv1eM5+9PKPq/xOQ5JZFC
         FHF8/TLDcONmhH3aEvMx6QRC/6atszzxgcqo/IoifZL1JAMSpSlQOjyQstSeeg3i0vbT
         lV/MwIaJrouFJMv0mJOJJ1frGoard+BXzHE7WjksbAfYLN9cleMnMiZSVKwUGpIdT50D
         cHP7vDC9ISdSnzQ18+KpPOGBOZDDJd6yRlwg64svFJ+ERJRddc9gqmQcpczgRe9ynt/7
         zMwB5FNgzvEIiUb+Gd419OXn8Oq16haPGUEifX8qVSHYuIOOLH6AEHNN/AetEbXbmpeS
         TLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=zFrdWxF7Sxm41OO5S1Vv6lunG4IB+wpk30nIeFN3G6A=;
        b=T4lm/hOdyX5wXbA5YN+Rqo0hgFbovQbnKTjCnaXzU6HhlBJB2zCSy94X+T57PbJuhv
         2jK/UUmwrQHkAEZ/lyl6cwqOn0ztcds5w1BIqTqt8oXZD2Q8XdOf6L0BJnL2UMZeYhCq
         rnlSh6vS0Pu7kGxmGc/TbU9HhKDixj0BrWXlcX1wLbfciHDGmOd1XSWOHYr1/6ylNB1m
         FnEjWK/+3wPPLifUOcaGKraV1euxoUXl4iijCbV9ZbahfIpaAVtG+LmETNUgVD09Yh5h
         H7s2LUMsxdvhmlAhUGjTT4PWXY8hjkFMQo8XrlvHOvN4aAFk3OkHy0Zzh5c5Rq7FU7Pu
         0oww==
X-Gm-Message-State: AOPr4FVQwXaqOCZyAh47D3+O0/NIkiRdfk2fzJeg84+W3Bnvs1MGdpaV4+GKhEDVNZqJx7RuTJGHW98UbUCRQg==
X-Received: by 10.50.10.165 with SMTP id j5mr12284153igb.29.1462815331531;
 Mon, 09 May 2016 10:35:31 -0700 (PDT)
Received: by 10.36.8.5 with HTTP; Mon, 9 May 2016 10:35:31 -0700 (PDT)
X-Originating-IP: [86.28.149.6]
In-Reply-To: <CAP8UFD2dH+nDdpiURK=MePz-JiOOcv3V=NJWjdMYo--oyNZ04g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294023>

On 7 May 2016 at 08:07, Christian Couder <christian.couder@gmail.com> wrote:
>
> On Fri, May 6, 2016 at 5:31 PM, Thierry Suzanne <thierry@yellownemo.com> wrote:
> > Sorry, can't help :(
>
> I just sent a patch. It would be nice if you could test it to confirm
> that you get a nicer error message.
>
> Also please reply below other people's comments, as customary on this list.


Hi,

Amended my local svn.pm file with your 2 lines.

First time:
------------------
C:\code\myproduct\trunk>git svn clone
https://mycompany.svn.beanstalkapp.com/myproduct --no-metadata -A
c:\temp\svn_to_git_users.txt
--trunk=https://mycompany.svn.beanstalkapp.com/myproduct
--tags=https://mycompany.svn.beanstalkapp.com/myproduct/tags
--branches=https://mycompany.svn.beanstalkapp.com/myproduct/branches
c:\code\Git_TestPatch
[....]
W: +empty_dir: branches/20080918_DBDEPLOY/vendor/src/csharp/MS WCSF
Contrib/src/Extensions/Silverlight
W: +empty_dir: branches/20080918_DBDEPLOY/vendor/src/csharp/MS WCSF
Contrib/src/Services
W: +empty_dir: branches/20080918_DBDEPLOY/vendor/src/csharp/RealWorldControls/References
r530 = c276e3b039d8e38759c6fb17443349732552d7a2 (refs/remotes/origin/trunk)
Found possible branch point:
https://mycompany.svn.beanstalkapp.com/myproduct/trunk =>
https://mycompany.svn.beanstalkapp.com/myproduct/branches/20080918_DBDEPLOY,
529
Initializing parent: refs/remotes/origin/20080918_DBDEPLOY@529
W: +empty_dir: trunk/etc
W: +empty_dir: trunk/src/csharp
[...]
W: +empty_dir: trunk/test
W: +empty_dir: trunk/vendor
r5 = c71eabc20ff1f4e3fd728727470a2fa5a3802891
(refs/remotes/origin/20080918_DBDEPLOY@529)
        A       src/database/tables/IllustrationRow.tbl
        A       src/database/tables/LegalEntity.tbl
        [...]
------------------

No error!
Ctrl+C to interrupt, ran exact same command again, this time the new error:
------------------
C:\code\myproduct\trunk>git svn clone
https://mycompany.svn.beanstalkapp.com/myproduct --no-metadata -A
c:\temp\svn_to_git_users.txt
--trunk=https://mycompany.svn.beanstalkapp.com/myproduct
--tags=https://mycompany.svn.beanstalkapp.com/myproduct/tags
--branches=https://mycompany.svn.beanstalkapp.com/myproduct/branches
c:\code\Git_TestPatch
Found possible branch point:
https://mycompany.svn.beanstalkapp.com/myproduct/trunk =>
https://mycompany.svn.beanstalkapp.com/myproduct/branches/20080918_DBDEPLOY,
529
refs/remotes/origin/20080918_DBDEPLOY@529: no associated commit metadata

C:\code\myproduct\trunk>
------------------

So the repro steps are potentially different. Anyway, thanks for
taking interest and handling the error nicely.

For the error message, as a beginner end user converting svn to git,
the message "no associated commit metadata" doesn't really make me
think my command line is wrong. But I'm sure with time this message
will appear on stackoverflow with its true meaning :-)

Thanks,
T
