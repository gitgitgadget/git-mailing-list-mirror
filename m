From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Add NEED_WORK_TREE for more commands
Date: Sat, 27 Oct 2007 17:18:39 +0700
Message-ID: <20071027101839.GA26043@laptop>
References: <20071027081910.GA23381@laptop> <20071027090822.GA6789@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Oct 27 12:19:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iliky-0003fs-Ac
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 12:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbXJ0KSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 06:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbXJ0KSv
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 06:18:51 -0400
Received: from rv-out-0910.google.com ([209.85.198.187]:1304 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbXJ0KSu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 06:18:50 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1033871rvb
        for <git@vger.kernel.org>; Sat, 27 Oct 2007 03:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=s4rkTtUhF6jKBvz8KyXTBRhVJQ2jCcq2EdGq/MT+t68=;
        b=LJPSeqkWjrsZm85fXJZ9dx7nPeMXCU1dd/E3Zc7JItXIOu+MaGyVNzJHXZgEPDdv4UFkDfTJUIcxswBriJZk2Bmrnv5fcsgWOzI3Z80HIu2ksrEcQp3TnrVg+LEpuPkuyQVtcV2Y7PnU7qOub1fXSkIM7pHGLKqrBN6yVHXQYf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=WQa6MR0UoxfBVwX8y0SyqCTa6Ov+PS9ZLcdQrE94Df56Kez++0MY0/Qthn5ESxSAnHQemPGQJ9EAytpwkobN7hC78+oVS9Pzn2lfzLbgMxyuYz/P84p27yd9zXjb9/kkK1+uGPfw1Lc+OttoF5nkGS3Cy53MBTrpHtKVX71DyOI=
Received: by 10.141.19.16 with SMTP id w16mr1935030rvi.1193480329826;
        Sat, 27 Oct 2007 03:18:49 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.1.6])
        by mx.google.com with ESMTPS id k14sm7322043rvb.2007.10.27.03.18.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Oct 2007 03:18:48 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 27 Oct 2007 17:18:39 +0700
Content-Disposition: inline
In-Reply-To: <20071027090822.GA6789@glandium.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62483>

On Sat, Oct 27, 2007 at 11:08:22AM +0200, Mike Hommey wrote:
> On Sat, Oct 27, 2007 at 03:19:10PM +0700, Nguy???n Th??i Ng???c Duy wrote:
> > 
> > Signed-off-by: Nguy???n Th??i Ng???c Duy <pclouds@gmail.com>
> > ---
> >  git.c |   12 ++++++------
> >  1 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/git.c b/git.c
> > index 23a430c..9db40b3 100644
> > --- a/git.c
> > +++ b/git.c
> > +		{ "ls-files", cmd_ls_files, RUN_SETUP | NEED_WORK_TREE },
> > +		{ "update-index", cmd_update_index, RUN_SETUP | NEED_WORK_TREE },
> 
> At least these two work very fine without a working tree (and I *do*
> need them to work without a working tree).

How can you do that while both need index and a working directory to
operate?

> Mike

-- 
Duy
