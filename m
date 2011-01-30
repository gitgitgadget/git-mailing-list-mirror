From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/2] Re: Remote branchs -- how can I check them out?
Date: Sun, 30 Jan 2011 15:32:58 -0600
Message-ID: <20110130213258.GA10039@burratino>
References: <AANLkTin3Tfcf=WJHJdSA9TwhFXQfaMrnm5+YEWWjo=qj@mail.gmail.com>
 <20110130160556.GI5713@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Sm/Do28=?= Paulo Melo de Sampaio <jpmelos@gmail.com>,
	GIT Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Jan 30 22:33:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pjety-0006mz-Iq
	for gcvg-git-2@lo.gmane.org; Sun, 30 Jan 2011 22:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344Ab1A3VdN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Jan 2011 16:33:13 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:32776 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159Ab1A3VdM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Jan 2011 16:33:12 -0500
Received: by ywe10 with SMTP id 10so1730460ywe.19
        for <git@vger.kernel.org>; Sun, 30 Jan 2011 13:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Xma6rOtwSvxDHwDhwfSDoN1fzyFCm1egKIwGFn1yAR8=;
        b=oyTbl+YACj8CvJkdKvQW07n+hjrCUFSwU6h0XD/25KMC/i4chsoo8ynDVo9Q1b97JH
         7NaZoOoNL3tvaWnVf2Wj0/o1Y31xF7HHoMgRCuEnJMtG3VyKJaKFDdIRhxr1C++sX1yL
         m8BZJCLfdVczUrKEeFaWcawgSAZLKYB19Hbjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kEbcmGvq2AuY6FXQ6N8gW1bb/zEg9t28O46s5TTFPAprKtWpluFQeiTa+J07drjHP7
         rfJah1Mh5zZS2PMCwPqYr15VwydABj1KmztG/10ZgLINC16dwZC/kwjXQzgXQUnf80sm
         RoHdm+c+RsDG9YAqGSI/+Z8iuHKrlcy+xgQIk=
Received: by 10.151.20.5 with SMTP id x5mr6825043ybi.382.1296423191959;
        Sun, 30 Jan 2011 13:33:11 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id q33sm13031749yba.19.2011.01.30.13.33.09
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 30 Jan 2011 13:33:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110130160556.GI5713@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165701>

Konstantin Khomoutov wrote:

> These branches are local to your repository. They are "remote" in the
> sense you're not supposed to modify them directly.
> So to inspect such a branch just use its full name ("origin/next" for
> instance) when working with commands like git-log.
>
> See [1], [2] for more info.
>
> Also your question appears to be quite basic which hints at that you did
> not read a good book on Git before using it.  So starting at [3] is
> recommended -- it mentions a bunch of good books and manuals

Pointing to good references is a valuable thing --- thank you for that.
But I also want to point out that if you need to read a book before Git
becomes usable then we are doing something wrong. :)

In this example, perhaps the "git branch" manual page needs some
improvement?

Jonathan Nieder (2):
  Documentation/branch: split description into subsections
  Documentation/branch: briefly explain what a branch is

 Documentation/git-branch.txt |   62 +++++++++++++++++++++++++-----------------
 1 files changed, 37 insertions(+), 25 deletions(-)
