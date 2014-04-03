From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Fwd: [ANNOUNCE] WinGit - native x86/x64 Git for Windows
Date: Thu, 3 Apr 2014 17:03:14 +0200
Message-ID: <CAAH6HY_QkDdf9Leh2dZ-T_8UZa68xDL5e3N1go1Lgs-3fJZHmw@mail.gmail.com>
References: <20140403131850.GA24449@seldon>
	<CAAH6HY8DbQCMJhb4fY3-aLbriUHOS4zeizHjPy+FMmxuyHQxxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 03 17:03:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVjAm-0006Yj-EF
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 17:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbaDCPDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2014 11:03:15 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:43093 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbaDCPDO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2014 11:03:14 -0400
Received: by mail-ob0-f178.google.com with SMTP id wp18so2043319obc.37
        for <git@vger.kernel.org>; Thu, 03 Apr 2014 08:03:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=yzsDfVQBpUDJaVXlYHYF7TYx4cKfg071ML90DC5ct/o=;
        b=WknHH/5YKVrw4Q34nO3xN/TkB6CjsKBf16RQe6g436Anhr3PaBb8hcjVWwBFCaPeUw
         80daUo22080lCHGM9zHgDFOnzt6oHtRFFgghjm4+KAaKIvd72VBUjDgpDnxUEdhYGzkd
         ek+g7HdplqT5gPD5r6QlHTAJWXyYkfIYB/5WDYJGf1JHIVg04Oy3+4o55pQpNG8QUn99
         QslNCypYXTG5k9qLwu9aA4LPzmV67Yr6G8ye0yGhY2tUgVodPUDueCcrkIbOimvilbr7
         jJFSOWpNgbRZBTy/isgqHarCTWexp9qRbiNeCelpM1Sv2rPCUy7bHzxRDLyJB1PhOt+I
         B/vA==
X-Gm-Message-State: ALoCoQnammvObgX3WeKFCQD89LNuqAHdV/OF16MYhCDaC6FWSDDV5AxxusD2ve8/1d0/OiOMWjCG
X-Received: by 10.60.58.193 with SMTP id t1mr940042oeq.78.1396537394374; Thu,
 03 Apr 2014 08:03:14 -0700 (PDT)
Received: by 10.60.39.36 with HTTP; Thu, 3 Apr 2014 08:03:14 -0700 (PDT)
In-Reply-To: <CAAH6HY8DbQCMJhb4fY3-aLbriUHOS4zeizHjPy+FMmxuyHQxxQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245739>

>
> I know that build.sh is UGLY, especially openssl part.
>
> Unlike msysgit, WinGit is a pure-Windows binary build with MSVC.
>
> Like msysgit, WinGit also uses msys environment (sh/perl/etc) both during
> build-time and runtime.
>
> WinGit adds a few patches to Git itself on top of msysgit ones.
> Patches are required due to insufficient testing of MSVC builds
> (caused by total absence of any MSVC-built Git distributions).
>


I've created CMake files to be able to build git with MSVC without the
need for msys. I haven't tested it with latest git and didn't really
see the recent changes with respect to compilation with MSVC.

But, if you're interested, let me know.

Vincent
