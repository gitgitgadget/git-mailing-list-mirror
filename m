From: Liu Liu <i@liuliu.me>
Subject: any way to re-release git's block sha1 implementation under a
 different license?
Date: Thu, 6 Dec 2012 23:51:49 -0800
Message-ID: <CAFBatg3AcjOjQqKJrRe_fkva8OD=F=5aS7kczF3e1ePw_KcJng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 07 08:52:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgsjV-0000tJ-IS
	for gcvg-git-2@plane.gmane.org; Fri, 07 Dec 2012 08:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855Ab2LGHwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2012 02:52:12 -0500
Received: from mail-pa0-f46.google.com ([209.85.220.46]:44703 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755480Ab2LGHwM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2012 02:52:12 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so287703pad.19
        for <git@vger.kernel.org>; Thu, 06 Dec 2012 23:52:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :x-gm-message-state;
        bh=aTLPD+RNB3X71g+UFZAhtsNS7B4LIBkI3UlBldot+5c=;
        b=CD9DP+f0PkKYZAG/dI8rMTnUtv1YkK48eO7H5vXjJGP5w0+72JYxNlp15zm2georwn
         7XosfR76+iYjFpKaT859YHM8LS7+TLV4nTvovxxy6U7lj9PUslDUSbovxpnHgZfTQ/a1
         sGoPkOYIOLfztVh2nGNJwsCKa/6Ol6Dc2WIDSQ37vcYWMpKCn8bGiDeLfmbyLhD2hdOJ
         VDTw//rpw/IQcsvxCOQPW0GCXcxqRRHej9Zcyy4BGPZFYsLANNuH5k4qcRXSpSpynQwS
         ouRtF0/+feSE0DDga/N5AeMAtk65G/NX/FFAWrJtvKmTQNoFYY4SNSLpxIxnAxvOBdkG
         Dm8A==
Received: by 10.66.83.6 with SMTP id m6mr11242447pay.52.1354866731675;
        Thu, 06 Dec 2012 23:52:11 -0800 (PST)
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com [209.85.220.46])
        by mx.google.com with ESMTPS id c2sm6156343pax.28.2012.12.06.23.52.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Dec 2012 23:52:10 -0800 (PST)
Received: by mail-pa0-f46.google.com with SMTP id bh2so287674pad.19
        for <git@vger.kernel.org>; Thu, 06 Dec 2012 23:52:09 -0800 (PST)
Received: by 10.68.217.137 with SMTP id oy9mr13604282pbc.50.1354866729397;
 Thu, 06 Dec 2012 23:52:09 -0800 (PST)
Received: by 10.68.10.3 with HTTP; Thu, 6 Dec 2012 23:51:49 -0800 (PST)
X-Gm-Message-State: ALoCoQmrv/MKY2S28PVrmQ/ltxf9Bw8o5Ix8K09g+GnutQXAy5tzluS2qRrY7zolTVwXJ7X+vHM4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211173>

Hi,

I am reaching out because in my personal project (
https://github.com/liuliu/ccv
), I used the block sha1 implementation (
https://github.com/git/git/blob/master/block-sha1/sha1.c) in git. It is a
fast, generalized and standalone implementation, however, since it is a
part of git, it is under GPL license. Is there any possibilities for the
original author/authors to release this particular piece of code under BSD
/ MIT or Apache license? Thanks!

---
Liu Liu
http://liuliu.me
http://facebook.com/liu.ll
