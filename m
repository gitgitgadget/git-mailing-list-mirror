From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git sub modules related
Date: Tue, 6 Jul 2010 13:59:02 -0400
Message-ID: <AANLkTil2ULzcREY2KsQtcHLmwT7or1lMo4Ju1cUYrq2o@mail.gmail.com>
References: <AANLkTinej91PZbh_axJqz92mI0Y3GUako8tuKtU24iwV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mahesh Vaidya <forvaidya@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 19:59:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWCQb-0006l0-TC
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 19:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977Ab0GFR7Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 13:59:24 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56892 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755549Ab0GFR7X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 13:59:23 -0400
Received: by pwi5 with SMTP id 5so2074082pwi.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 10:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=qqoQKDdV1eX+P2YZQg+QyyoI9VNVssFy4fX5s4r4rNw=;
        b=Q8+0SXx1kvnnbueP4TIb/2ttBj+/RppCvY0zpaX5S9bcVOOkDKN94+ADjQerRScwYu
         cfecSUfQN0jzGiJs5q56TD1oYAN8ICp6vEq5DevkGiUeSIFN9HVEzglLzh5tOwJc0VVA
         MQb+mZPEbk4kwpXdMsYF8M6trhqJppF/j73J4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DvBwqHW4oESeFsMCk5y+uzwQkwZOPwTsdx0uj//cnChgeNmBczmCY/IUFj3122GgP6
         nYuNTSce7SITFgXOSnm1qfVSNE7OAGM2mBH+WPjMuezNJUfb1uXwqVcDf3D6EfsoE2dw
         HLnMhWBkd5auXlicdGIUZ0KeWfvCVlTr+7xGg=
Received: by 10.142.187.19 with SMTP id k19mr6053026wff.16.1278439162497; Tue, 
	06 Jul 2010 10:59:22 -0700 (PDT)
Received: by 10.151.45.4 with HTTP; Tue, 6 Jul 2010 10:59:02 -0700 (PDT)
In-Reply-To: <AANLkTinej91PZbh_axJqz92mI0Y3GUako8tuKtU24iwV@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150380>

On Tue, Jul 6, 2010 at 1:45 PM, Mahesh Vaidya <forvaidya@gmail.com> wro=
te:
> Created a 'super' level module top and add 2 sub modules a and b (As
> given in manual); However I am not able to create a Global branch /
> Tag.
>
> super ---> a
> =A0 =A0 =A0 =A0 =A0|
> =A0 =A0 =A0 =A0 =A0---->b
>
> I am hoping to create a branch FOO which will recursively go in super=
,
> a and b; In that case how do need to associate tags and branch in
> super, a and b by a single artifact

As far as I know, there is no feature to do this automatically.  And
it would be kind of complicated to add, since you'd have to be able to
push that branch to multiple repositories at the same time, and so on.

I wrote git-subtree (http://github.com/apenwarr/git-subtree) to solve
exactly this sort of problem in my own projects.  It has a very
different workflow than submodules, but you might like it.

Have fun,

Avery
