From: "Mikael Magnusson" <mikachu@gmail.com>
Subject: Re: git svn: Bad URL passed to RA layer: Unrecognized URL scheme
Date: Sun, 5 Oct 2008 21:44:38 +0200
Message-ID: <237967ef0810051244m51156925x26ae51db038dad49@mail.gmail.com>
References: <pan.2008.10.05.17.24.02.167465@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff Kowalczyk" <jtk@yahoo.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 21:45:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmZY6-0006EH-Vw
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 21:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755676AbYJETol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Oct 2008 15:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755560AbYJETol
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Oct 2008 15:44:41 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:27256 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755555AbYJETok (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2008 15:44:40 -0400
Received: by nf-out-0910.google.com with SMTP id d3so913831nfc.21
        for <git@vger.kernel.org>; Sun, 05 Oct 2008 12:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=IBZnp4Ukjdbq9VuwstxNxyHcl4XjgsyfSSQenNK4eOA=;
        b=fPlT85oB8c+WiZis5zAI4o6YZvl3IbH7HzOpUDsk0cSxFJzTFb+PfLHfVhBaSpbiQa
         FuLP6nQiN2E37sAJqXBqqG1hFfTaP/kyfidECGSkD64SpNrL/SBoEAMSFgyRvtGglsWx
         vICMtpa13RVwAvHbJ7g3LgqG7VqEWFEfFc2OE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Znta/LGJ5/MXOsKdEjAFxB0cls4XPmE2tCY/zXjXXvaGIrv6nrzZOnsBZCujmy+xFC
         dMKR0Jblvs1UYDdDgwFKWkPsfPVoAW9PvdaiYAkBaRFQOUM6wvp/j+TGdqov5Mi9vI/P
         tNBqepYBfxUtokQaNck1wr5pGExh3JZo7uN4I=
Received: by 10.210.76.19 with SMTP id y19mr5101942eba.111.1223235878768;
        Sun, 05 Oct 2008 12:44:38 -0700 (PDT)
Received: by 10.210.19.20 with HTTP; Sun, 5 Oct 2008 12:44:38 -0700 (PDT)
In-Reply-To: <pan.2008.10.05.17.24.02.167465@yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97529>

2008/10/5 Jeff Kowalczyk <jtk@yahoo.com>:
> I made an ill-advised upgrade to from subversion-1.4.6 to
> subversion-1.5.2. While I had subversion-1.5.2 installed, git svn rebase
> ended with a 'segmentation fault' error.
>
> Now back at subversion-1.4.6, git repositories with svn remotes updated
> during the aforentioned upgrade now give an error:
>
> (master) $ git svn fetch
> Bad URL passed to RA layer: Unrecognized URL scheme for 'http://code.djangoproject.com/svn' at /usr/libexec/git-core/git-svn line 1400
>
> (master) $ git svn rebase
> Bad URL passed to RA layer: Unrecognized URL scheme for 'http://code.djangoproject.com/svn' at /usr/libexec/git-core/git-svn line 1909
>
> Others which were not updated recently work fine for git svn operations.
>
> How can I repair the affected git repositories?
>
> Thanks.

That somehow looks more like an svn error than a git error, does
svn checkout http://code.djangoproject.com/svn
work?

-- 
Mikael Magnusson
