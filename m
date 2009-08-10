From: Rostislav Svoboda <rostislav.svoboda@gmail.com>
Subject: Re: .gitignore vs untracked working file
Date: Mon, 10 Aug 2009 12:17:02 +0200
Message-ID: <286817520908100317k4e98faf9n4e852b7abd4719fe@mail.gmail.com>
References: <286817520908100257n35b178ebu387161658554b4a@mail.gmail.com>
	 <20090810100148.GB22200@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org,
	=?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Mon Aug 10 12:17:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaRwH-0003zW-3U
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 12:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584AbZHJKRE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2009 06:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753536AbZHJKRE
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 06:17:04 -0400
Received: from mail-fx0-f228.google.com ([209.85.220.228]:48737 "EHLO
	mail-fx0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486AbZHJKRC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2009 06:17:02 -0400
Received: by fxm28 with SMTP id 28so817742fxm.17
        for <git@vger.kernel.org>; Mon, 10 Aug 2009 03:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=hO5cQl1NX5Pow/FxteJHyzk3o1h1sSbrioT3zJgA+V4=;
        b=F1Gsw3MBLisiXRCwhSsTPVwSgQe00uVHa8AmNhMIl0ExU+N7bYfUdOvb5A7/gVLicl
         TaaqMaOnJJ9mqzbvcpxQ1Zw1IzAAx/5wEbfJHFUcM6lS/ql/KKKCK3x9LTLFTNMJ91TJ
         fcb1RhKmDPWiRml+bhh6DRd7GJ2UNpB7cP+do=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=J2cqNHRx1t/rUNl5CtULiTIyUX8kgrclgdTdF1sXnyZrpdZ0UmVPNahrscr1fW9tPS
         6EnkrKJHAizEyYftUW8U4ITAg7/razF4HtvY8CpmQscj2TB2StGBdzPkfknhwgDsXuyC
         gzifz+W33taNhqSWAeCeLXXMw/tEgDI8mljNk=
Received: by 10.239.136.134 with SMTP id h6mr424194hbh.71.1249899422659; Mon, 
	10 Aug 2009 03:17:02 -0700 (PDT)
In-Reply-To: <20090810100148.GB22200@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125430>

2009/8/10 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>:
> Hello,
>
>> $ git checkout master
>> error: Untracked working tree file 'Project/bin/path/file.jjt' would
>> be overwritten by merge.
> What is the output of
>
>        $ git ls-files master bin/

Nothing:

$ git ls-files master bin/
$ git ls-files master Project/bin/
$ git ls-files mybranch bin/
$ git ls-files mybranch Project/bin/

$ ll 'Project/bin/path/file.jjt'
-rw-r--r--    1 bost  Administ     8233 May 10  2006 Project/bin/path/f=
ile.jjt
$ git ls-files ''Project/bin/path/file.jjt'

BTW the rule to ignore bin/ is exclusively in the .gitignore on the
branch mybranch not in the master branch. Might this be the problem?

Bost
