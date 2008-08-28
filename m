From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [QGIT RFC] Unit tests for QGit
Date: Thu, 28 Aug 2008 13:29:25 +0200
Message-ID: <e5bfff550808280429h63496f9byfa4454af7adb0e86@mail.gmail.com>
References: <20080808211318.GA4396@efreet.light.src>
	 <e5bfff550808170846y522cc6a8w59b696be39df311b@mail.gmail.com>
	 <20080817195839.GB4542@efreet.light.src>
	 <e5bfff550808171330w28dda6a2m32b0e51b1ef73cdc@mail.gmail.com>
	 <20080818180048.GA15520@efreet.light.src>
	 <e5bfff550808190753t4f99ddb6q83886dbca27dbf03@mail.gmail.com>
	 <20080827201819.GD15520@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Aug 28 13:30:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYfhy-0005gu-Sz
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 13:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681AbYH1L31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 07:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753468AbYH1L31
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 07:29:27 -0400
Received: from rv-out-0506.google.com ([209.85.198.229]:33189 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319AbYH1L30 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 07:29:26 -0400
Received: by rv-out-0506.google.com with SMTP id k40so355987rvb.1
        for <git@vger.kernel.org>; Thu, 28 Aug 2008 04:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kC0sr3UaQyijUIV+H3fWwKuxt0gIcwsv/vxC5JDx1U8=;
        b=VI+w9vHvYnJ8lwXW3n1rAkqbbunPZcN2z8t1u9x3sHhy+HfTDIe/Ztb0iviBrxlgC0
         z4moYr34L3Gy70V1/Fx8+dzfS553C1uKug6qYdpnCvwZByAhN3RTldHp0GTHEoDEyFPm
         tuusi285SzK0Csymqv9ciTwpJ78NXg5scdPKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=NtF7Swzw0Sn+/AbAc8s9NOtZqeSfsgtqQGwJDxJReoaTk8DVqhPFNr3h5mVDTrGs5N
         +hUpwAcr6i3mHdLxCZaj2jtNg5CLFrfw+Bjr2UXUoYqkYwHjfw4bCk3KWkGxl2k6WkO/
         lGZCt0YFQge21KHQZzc1S/IWNOZKkkKFM9zX0=
Received: by 10.114.157.3 with SMTP id f3mr1160820wae.40.1219922965438;
        Thu, 28 Aug 2008 04:29:25 -0700 (PDT)
Received: by 10.114.174.5 with HTTP; Thu, 28 Aug 2008 04:29:25 -0700 (PDT)
In-Reply-To: <20080827201819.GD15520@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 27, 2008 at 10:18 PM, Jan Hudec <bulb@ucw.cz> wrote:
>
> Actually, I just wrote a first simple test for it. I didn't find this (now
> the stg branch finds out properly), but I found another problem -- when
> switching from non-stgit branch to a stgit one, Git::init will not notice,
> because the path didn't change, so the check is not re-run. Applies to the
> other direction too, of course.
>

I have never tested on repos where some branches are under stgit and
others are not. Actually I even didn't know it was possible.

The command:

isStGIT = run("stg branch", &stgCurBranch); // slow command

is used to check if a repo is under StGit control, i.e  'stg init' has
been run in the repo working directory (it doesn't mean that there are
StGit patches applied or unapplied, could be also without them).

So It's not very clear to me what does it mean "switching from
non-stgit branch to a stgit one"

Thanks
Marco
