From: Manuel Doninger <manuel.doninger@googlemail.com>
Subject: Re: Mercurial over Git no success
Date: Mon, 14 Feb 2011 22:50:09 +0100
Message-ID: <AANLkTinro_sSV52aZATAPFAm1SLRq8i4Q1kA2W+wqqH3@mail.gmail.com>
References: <1297717305.19327@davidwbrown.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: david@davidwbrown.name
X-From: git-owner@vger.kernel.org Mon Feb 14 22:55:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp6O4-0003ZZ-1t
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 22:55:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375Ab1BNVzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 16:55:11 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:45063 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079Ab1BNVzJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 16:55:09 -0500
Received: by vxb37 with SMTP id 37so2981433vxb.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 13:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:dkim-signature:domainkey-signature:mime-version
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=KnK2CII+rE80RstnjYujLVSsWgKdkFZGv1bXYCV6mm4=;
        b=NRf/CHpapbksw257Pg2zk1qq+7tw83YnCPNewMaMerP962PdeCAzg2IpAG0PuhCYvf
         PgTbXIM7KZHLzx5Bfq4hisIA7QivKJXMnljgBp7rJfFArvYG4mlr1ABXzGWnMvVnBFRx
         H8kr+eSuOCTObZTLpDIZL6nb4R08k4Xl1qs18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=dfaf98GQ9647OBTfHnLsVI6wYu4/3lXsfoqzz/IQXpVFy6NKPWUJj0n9zGLmQwSaqM
         LydomfIpysSGkkn+T0nn36jLBFFwPDVaa9iMLNbmxshJID5yvjDIsnnTThlV3StgdaR3
         MandFuY9nAof2aMRqPm4WUGdNFIH1oHgJTyiA=
Received: by 10.220.198.135 with SMTP id eo7mr1643785vcb.194.1297720381959;
        Mon, 14 Feb 2011 13:53:01 -0800 (PST)
Received: from mail-vx0-f174.google.com ([209.85.220.174])
        by mx.google.com with ESMTPS id b26sm2193072vby.13.2011.02.14.13.53.01
        (version=SSLv3 cipher=OTHER);
        Mon, 14 Feb 2011 13:53:01 -0800 (PST)
Received: by vxb37 with SMTP id 37so2980101vxb.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 13:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=KnK2CII+rE80RstnjYujLVSsWgKdkFZGv1bXYCV6mm4=;
        b=WS5v7Ocbage167qzeqUGXN3znYaUfOGM9HhS2chyzlqxmWgP+3jWmY1ygvxLVhtDkV
         C8bQsZPDx14JAElpQMmlxs3KQcdOYtoA3MmNF5S5O4+3YYrDb8I1QUgIyXYSS7NLMntV
         Qlz5QlWfr72Ndp8uyrKo4sTuFyqM1SivpqHdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=JOS5MV6z7hModyBTOimYPOlZ5tRGFT9VOSPNSJT9Gl6ARR1x42yA+TV0ZOcLdHoMAI
         Yd4CbYpl7UZO+pTkDvptO6qTUfav4yHuWcalCTc08/MP6kzxKeARoe2McIUw8/RAV0Rm
         l4OcxJVU/x5c5beKRJUbPJkKRKwxs11k03gKQ=
Received: by 10.220.179.67 with SMTP id bp3mr1696999vcb.155.1297720304090;
 Mon, 14 Feb 2011 13:51:44 -0800 (PST)
Received: by 10.220.60.199 with HTTP; Mon, 14 Feb 2011 13:50:09 -0800 (PST)
In-Reply-To: <1297717305.19327@davidwbrown.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166778>

According to the Install-section in the Pro Git book, you have to
install some other libraries. See http://progit.org/book/ch1-4.html

Manuel

On Mon, Feb 14, 2011 at 22:01,  <david@davidwbrown.name> wrote:
> Hello Gitters, long ago when first starting the project I'm currently running at my company I looked around for a VCS/SCM that would be anywhere better than: CVS/SVN. At first I looked at Git but could not get a version to run on my Ubuntu box. So, I had to settle for Hg. Now, that I'm several months into the web app dev I'm responsible for the hired help has convinced me to switch to Git. Now, I'm back at the same old problem I had months ago that forced me to give up on using Git. Unlike a lot of Unix/Linux based software the usual:
>
> ./configure
> make
> make install
>
> Does not work for building Git on my local Ubuntu box (10.10 BTW). Some non-innocuous error condition as follows:
>
> cannot find zlib.h
>
> Pls advise. David.
>
