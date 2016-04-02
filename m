From: =?UTF-8?B?44Oe44OD44OB44On44Kz5aSq6YOO?= <mebius1080p@gmail.com>
Subject: git 2.8.0 tarball rpmbuild error
Date: Sun, 3 Apr 2016 00:48:53 +0900
Message-ID: <CAHHSH-JrPiXnkdpU0cP6KE46hUr3-ZiSjW5FDMpV2HGmSou8kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 02 17:49:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amNnM-0001KW-Pc
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 17:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbcDBPsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 11:48:55 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36486 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314AbcDBPsy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 11:48:54 -0400
Received: by mail-ob0-f177.google.com with SMTP id j9so21978153obd.3
        for <git@vger.kernel.org>; Sat, 02 Apr 2016 08:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=GIMOlss51fIcVCwvjHTSqE93mxZnyxd2S5RVxHZpk94=;
        b=Nh4GnauFA52yo5c3yQolXuQsaHrnGvvc5GoVPDsRYtadTkGE3c7MOwMwREMWmAhRv2
         zluyv6fHsdUmEz64GtYBO9fCMgpzzKIct0I+dAOJ016atTVBMVFLYPSrxs/AERrhmORF
         7AfsZRyVehg4P5U8dID/Zu2mjGAcifjipDv/0037d2SrQc+qeMqPrt8vI1JsEk051BSe
         ffN7uFgV5msrXyI4mwQ55J3P41rnUiPAz4pBxsYdnofyg1365cYHRJ+MUghyBsYpqWFH
         zf06atFc1aEa0KXA9riWYov59hF9hkdZE+hPmTxf2XAeHPAXwSSy0ojWpuLePLgc+bcn
         bbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GIMOlss51fIcVCwvjHTSqE93mxZnyxd2S5RVxHZpk94=;
        b=IR4CZ48qkFWVPTcZW6bH+gjC1jwSNhUG/Z0X798iU5BuVPPg5yqAXbzxZ7ZH6qPYs6
         mpjPHZLwZJcpf5STMNBdO0Sk/ZOJVBsI3QnN4cXbXIiU6ei5sqCV/5OSRU/YYJMyC6t8
         e1YHnaAzdP4M288XLnC+QDXgN2fJxc1MiUAgCvTtl2uumFFzNDbCv1fNSXO56p07HLSe
         8xIjdDJcaQeMXbRW+2hjqV0oD2T+bObiC4akfkcoPtus56RPWmIe3X7c1OLYNWPcTaj1
         mmPnpUGAYff+/zStlB01s48wjfBTmAmnCFwLkUA5eo1GC56PXDFrsShHsEWsoWbEpvgC
         kCJA==
X-Gm-Message-State: AD7BkJKx78P6lkCN+WrDrQaKk0irFtMZdVauoQnZ1+mnKJ492nX013NKEFNnrM2ZBYIHNy6ZZiOyOT7hoUCvAQ==
X-Received: by 10.182.70.100 with SMTP id l4mr6187058obu.62.1459612133410;
 Sat, 02 Apr 2016 08:48:53 -0700 (PDT)
Received: by 10.157.43.99 with HTTP; Sat, 2 Apr 2016 08:48:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290591>

hi
I downloaded tarball (tar.gz) from git web site and tried to make rpm file.
But, when I run command "$rpmbuild -tb --clean git-2.8.0.tar.gz",
error message is displayed and rpm file creation stopped.
The error message is looks like this:
cp -pr README ~/rpmbuild/BUILDROOT/git-2.8.0-1.el7.centos.x86_64/usr/share/doc/git-2.8.0
cp: cannot stat 'README': No such file or directory

It looks like README file does not exist on expected directory.

Im using Centos 7.2.
I hope this bug will fix soon.
thank you
