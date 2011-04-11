From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: Tracking file metadata in git -- fix metastore or enhance git?
Date: Mon, 11 Apr 2011 02:12:16 +0200
Message-ID: <BANLkTik=+Ne8x4GvOBJcy2_7AUYBS9n3oA@mail.gmail.com>
References: <Pine.BSM.4.64L.1104071923580.4692@herc.mirbsd.org>
 <BANLkTink-c8JuxnMBCAmXiVwFkBxJrTucw@mail.gmail.com> <4D9EDCEA.9010903@drmicha.warpmail.net>
 <20110408185924.GA25840@elie> <Pine.BSM.4.64L.1104081903550.22999@herc.mirbsd.org>
 <20110408194548.GA26094@elie> <Pine.BSM.4.64L.1104081955490.22999@herc.mirbsd.org>
 <BANLkTi=3LPRzohnZStAogddpL5ZLehb97Q@mail.gmail.com> <20110409081108.GE13750@arachsys.com>
 <BANLkTim5DPjGjJ=SfnNfXpzCd6=PKnSs6g@mail.gmail.com> <20110410001518.GA6380@elie>
 <7v39lqzzn9.fsf@alter.siamese.dyndns.org> <BANLkTimbAmW+ueq1Z9PJN9opXggywdxdnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Harley J Pig <harleypig@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 11 02:12:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q94kR-0000wB-LD
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 02:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868Ab1DKAMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 20:12:39 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53443 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523Ab1DKAMj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 20:12:39 -0400
Received: by iwn34 with SMTP id 34so5132765iwn.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 17:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ej4HShsZgJfIm4shVAbvd9xGpHb5K6bq5igbdQtyGvc=;
        b=e7q83tlJ68HMtlECBpqN1KYrnGOXHcu4iSlng1lLzGFxlqv6WBVO+HabvLelhEezqw
         4JzObzxNb3p4jHqtA2K+DnteAoXufiUSKBkJ2xvUfVKixJrmyToGZzUzHVwvZzzp324/
         /ainMQSSVF2My91QEKO/A1lIpb9gZH5xG8IQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=T3Yk0/GhPYLOT+GR6FLNFQORAPvSjYabCs7p1bm+fQ9quSVvbKRxbXZskzj/uev8na
         YQtSVuKgV1LfOxUPjnQ18Xawil5vrfAQAv1j9fSail8itgP1+3EqMrvwOKpld0toUAcQ
         0Qn74T0abE6ewdhA1wTW9YThqb9hPGiU41Kco=
Received: by 10.43.61.69 with SMTP id wv5mr7302325icb.108.1302480758106; Sun,
 10 Apr 2011 17:12:38 -0700 (PDT)
Received: by 10.231.92.16 with HTTP; Sun, 10 Apr 2011 17:12:16 -0700 (PDT)
In-Reply-To: <BANLkTimbAmW+ueq1Z9PJN9opXggywdxdnA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171299>

FYI, Harley J Pig <harleypig@gmail.com> had this to say on the
vcs-home mailing list

> I've written a metastore clone for a project where we need to store a
> linux distribution in version control (legacy code).  I'm also using
> it for my personal vcs-home stuff.  It is a naive and bluntly
> straightforward way to do this, but it seems to be working.  You can
> find it at https://github.com/harleypig/gitperms
>
> I use git hooks and a central file to (re)store the metadata.  Maybe
> it can be of some use to someone else.


Richard
