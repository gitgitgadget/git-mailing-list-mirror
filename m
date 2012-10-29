From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: git push tags
Date: Mon, 29 Oct 2012 09:12:52 +0100
Message-ID: <CAB9Jk9AOBGL785rSo1FLQd4pKpHRdvmJ21wWsZ=L0z7SF=6Suw@mail.gmail.com>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
	<508D7628.10509@kdbg.org>
	<CAEUsAPYREy=CvPxy_Mzh5icVQo3=NV-AMC096Op0WWODLPH47Q@mail.gmail.com>
	<4B8097A9D6854CDFA27E7CF6574B37BA@PhilipOakley>
	<CAB9Jk9BmMMDLsY=kU5o-c4XF6fN3O44h_vXe3d=WF-W9HTBh_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Chris Rorvick <chris@rorvick.com>, Johannes Sixt <j6t@kdbg.org>,
	git <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Oct 29 09:13:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSkT6-0004aK-0B
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 09:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106Ab2J2IMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 04:12:54 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46319 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757633Ab2J2IMx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 04:12:53 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4096503pbb.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 01:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=etV1OF/z2LQlRFrD3v1PFOYV6Yh5+2dGnh/cG+Ckhz4=;
        b=fSUylQATLxT+3OXJxEF83Cx9Is+PMBp4SJF3YkqxXcBLUFfppDsxr/hLjqAtIvvYBs
         lAzrw/inF2ZurtwMjt8wwZ3P2uX3h3ztDBLg39PAEwLiQwiixJJfcVGyp2gIs754cNMX
         aFgpHCD+mND73F4119JHjHeNFaSaemn20p4aZmbt/3maEtZ4OcB4fKIgCvYJsljzr4MT
         tsYnCZBaNut8pmayVDzTsgjzJSY5wI2ZeVX//QQqgxH9Nee7LLhl+S6b2RbCZwr4iMTs
         VhsmF0CH0WzseUTKvEcPOl68kMW6cXXxcSvrtR9UEksYYfVrjLEi6UI+OEHCCr+RSSkF
         SxRw==
Received: by 10.68.200.72 with SMTP id jq8mr90306963pbc.38.1351498372914; Mon,
 29 Oct 2012 01:12:52 -0700 (PDT)
Received: by 10.67.3.101 with HTTP; Mon, 29 Oct 2012 01:12:52 -0700 (PDT)
In-Reply-To: <CAB9Jk9BmMMDLsY=kU5o-c4XF6fN3O44h_vXe3d=WF-W9HTBh_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208603>

Hi,

to let the owner of a remote repository (one on which git-push
deposits objects) disallow
others to change tags, a key on its config file could be used.
An option on git-push, or environment variable, or key in config file
of the repo from which git-push takes objects do not help in enforcing
the policy not to update tags in the remote repo.

-Angelo
