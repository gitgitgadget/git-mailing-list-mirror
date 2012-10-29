From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: git push tags
Date: Mon, 29 Oct 2012 12:31:49 +0100
Message-ID: <CAB9Jk9CLXgHiLz6P8EeO2NyfzHWZ=x3Kkj7+eZ2_Sby19eE0Ag@mail.gmail.com>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
	<508D7628.10509@kdbg.org>
	<CAEUsAPYREy=CvPxy_Mzh5icVQo3=NV-AMC096Op0WWODLPH47Q@mail.gmail.com>
	<4B8097A9D6854CDFA27E7CF6574B37BA@PhilipOakley>
	<CAB9Jk9BmMMDLsY=kU5o-c4XF6fN3O44h_vXe3d=WF-W9HTBh_g@mail.gmail.com>
	<CAB9Jk9AOBGL785rSo1FLQd4pKpHRdvmJ21wWsZ=L0z7SF=6Suw@mail.gmail.com>
	<508E532F.2010109@alum.mit.edu>
	<20121029103837.GA14614@sigill.intra.peff.net>
	<CAM9Z-nkf84cV2bYp=NL8an5DjvwP+jL7icb+jwizjHeaq40VhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Chris Rorvick <chris@rorvick.com>,
	Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>
To: Drew Northup <n1xim.email@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 29 12:32:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSnZb-0005sj-GK
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 12:32:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758757Ab2J2Lbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 07:31:51 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38331 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758747Ab2J2Lbu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 07:31:50 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4202564pbb.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 04:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yiqwCpkx6NU87BI38OUPQ8Hw5mMb3JIshbnK/1mtM/I=;
        b=aLlT93Zsqob5PGvcWUoVE7565+0d7kIAY40AxmES6VqUAKra31NJBEn2eSq8dt6KCG
         Ki4d7+dDkGb+5QZOwEcei0SaRjpMnp5sOTD+lYVTM/swmuVU4lETqcn9BO58VK66HEdc
         PxNHkWHFLBIXZNQLFOeSA0eyCSqfyVGdluUTv6PPfxKCiEqmmHjoX5xuqxVw/SEqHcY+
         jfrrc5+fnfsvEWdL/VdS4xqMRqVa+QmXKi65xBeFaL2KNwBM+tKrk3Leba5Pb08SCRSK
         sgB3tlv7LSBnJq3+IDcfrEuMlRH2aVN/9zAuwI+7V1wTedz1qA7sWWnEmIP15mPSSKsA
         ammA==
Received: by 10.66.86.228 with SMTP id s4mr72009819paz.15.1351510309918; Mon,
 29 Oct 2012 04:31:49 -0700 (PDT)
Received: by 10.67.3.101 with HTTP; Mon, 29 Oct 2012 04:31:49 -0700 (PDT)
In-Reply-To: <CAM9Z-nkf84cV2bYp=NL8an5DjvwP+jL7icb+jwizjHeaq40VhA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208618>

Hi Drew,

sure. That is a good starting point. I would suggest to block tag
updates of existing tags if a dedicated option is present in the
config of the remote repo, like, e.g. pushOverwriteTags.

-Angelo
