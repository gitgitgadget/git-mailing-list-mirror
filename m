From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 00/32] refs backend
Date: Thu, 25 Feb 2016 14:27:55 -0500
Organization: Twitter
Message-ID: <1456428475.18017.38.camel@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
	 <CACsJy8DEtmYnmwENws0Hb_2Do_sQkKEaraz=vxgrCyTOV-3FVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 20:28:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ1a9-0004tu-Ry
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 20:28:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933667AbcBYT2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 14:28:01 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:35653 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933534AbcBYT17 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 14:27:59 -0500
Received: by mail-qg0-f51.google.com with SMTP id y89so48127959qge.2
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 11:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=AebDSq5eDnRcuShlN754xtwrBwSy09wAS9B7wKXrnbI=;
        b=DbMuFyGVVykDVzTBbDlathxDkUHXjkgnfZ4ISo8QqqV40/AD4UWkDE1IguKBJ7p7Wy
         xnnwByzMbjSgPP4Pr2QlGmVY8f0eG1Lnr3Hoaj+J6vWciS+d5+tHnzdM0NUVuVsSswbD
         xekQs6y/unNa8kDq/3nrwu525RYdj+9YhXMjHIbV0NGKEmQvAZNDRldiHoXGtozozYNz
         JH9gfPTp5agnehGQtSTTEOqCY2VdnvDpTGbsRaJrGeOLIRKEgYhWctJHdVBaQBhC0n0x
         SQGGWDxcEE6HNfdRTPx+QSxRXSpc8B4t88fyXn3H4sJq+dYH28tzsRS8RkdMgRVMFHUU
         2cPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=AebDSq5eDnRcuShlN754xtwrBwSy09wAS9B7wKXrnbI=;
        b=AMR9KNsV29GYXf5tKQsdD4duHO4EKmYTr+C0+dT974SVg9p+Kj+h92G4UXsCFANQUi
         qBttkc5p4oLJO3yQqMbEtRWjGFbLCZaCINMmGUd/hN8P5PZunJi9tibQ7qAyEjno+/q0
         2OMMrL1QRe4nnuE+fHSaa7ituC0ONTjoW5+SUKJKCCx0qc1Rv3FxCINbAYnl/MNpzKsH
         a3qU1u0mNLGqd4ht6sfrUWzSTX65QT+iREF42FK8X8U3f2Lyt3WpXKxkgQUgKor2tXBh
         A5+fJeYAbOKI88/81o53d7hRhwyiLB5ENARdWRjklBOQYdXm4Tivef4CcROP+Z7ZfM2e
         quqA==
X-Gm-Message-State: AG10YOT16DHFj/sZeepHAvoMeiIwCG8MEBcHIflM3dckBUfGymwNOXVQkqJ7JsbOfzI+NQ==
X-Received: by 10.140.166.198 with SMTP id m189mr59167184qhm.35.1456428477059;
        Thu, 25 Feb 2016 11:27:57 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id i14sm3889076qkh.6.2016.02.25.11.27.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Feb 2016 11:27:56 -0800 (PST)
In-Reply-To: <CACsJy8DEtmYnmwENws0Hb_2Do_sQkKEaraz=vxgrCyTOV-3FVg@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287419>

On Thu, 2016-02-25 at 19:57 +0700, Duy Nguyen wrote:
> A couple of build warnings I found, haven't really read the code yet.
> These two can easily be fixed
> 
> refs/lmdb-backend.c: In function 'lmdb_read_raw_ref':
> refs/lmdb-backend.c:554:16: warning: unused variable 'err' [-Wunused
> -variable]
>   struct strbuf err = STRBUF_INIT;
>                 ^
> refs/lmdb-backend.c: In function 'lmdb_do_for_each_ref':
> refs/lmdb-backend.c:1625:15: warning: unused variable 'c' [-Wunused
> -variable]
>    const char *c = resolve_ref_unsafe_submodule(submodule, refname,
> 0, oid.hash,
>                ^
> 
> -Wshadow also gives a bunch of warnings, mostly about "transaction"
> and "env". Whether you want to fix them is really up to you.
> --
> Duy

Will fix these, thanks.  I've now configured my config.mak to do -Wall
again, but -Wshadow produces a ton of complaints on the rest of git's
code.   We should probably fix those.
