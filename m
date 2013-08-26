From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-svn - canonicalize: Assertion `*src != '/'' failed.
Date: Mon, 26 Aug 2013 10:42:42 -0700
Message-ID: <20130826174242.GT4110@google.com>
References: <521B8D61.8040608@gmail.com>
 <20130826172853.GR4110@google.com>
 <CAKRnqNK4ZftcejAHjCcnFukr=Dm_U109uFmXEmXT+VpeW4DCBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Development <git@vger.kernel.org>
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 26 19:42:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE0oV-0000AP-IR
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 19:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101Ab3HZRmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 13:42:47 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:53948 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957Ab3HZRmq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 13:42:46 -0400
Received: by mail-pa0-f51.google.com with SMTP id lf1so3701321pab.24
        for <git@vger.kernel.org>; Mon, 26 Aug 2013 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zqNfHT4ZmrY+OwWKDjWMC5mxvI+q9jMOxA7VRQ82+I0=;
        b=tQOBavujITDudaIlPDBP1obPY/dTjbO646pgMLKbOGHgtqLL9L/8wtTbwolObggXQQ
         IrxVBZtSV0DCYw588RX5CYuNteIXz4FearKncSzaFeeE2XISfpsHN13Y0gLxGlrnMEZC
         89/26JmZU32+D0ZM4WdPeYvKxJLB5eT9Qs+LB19qH1h2BB/3KPByEwabdknn25uV+pg9
         5+6agxPR61P6mWfCZ72FHJy0jAm4R04yofpe6Go1b00xKOGlRAXCGi3bk2Y/8oL/nBa7
         umRTSM5EjS6X92CbvvdV6bwB3Tqo7f+fxY0FYEUCrsDjvO8vVTJ1dJiJw54T8FK9B8u+
         yaYQ==
X-Received: by 10.68.137.1 with SMTP id qe1mr16904563pbb.25.1377538966228;
        Mon, 26 Aug 2013 10:42:46 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ef10sm21405616pac.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 26 Aug 2013 10:42:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKRnqNK4ZftcejAHjCcnFukr=Dm_U109uFmXEmXT+VpeW4DCBA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233012>

Bruce Korb wrote:

> $ git svn --version
> git-svn version 1.8.1.4 (svn 1.7.11)

Hm.  Two ideas:

 * Does 1.8.2 or newer work better?  (It contains v1.8.2-rc0~110^2,
   "git-svn: do not escape certain characters in paths", 2013-01-17,
   which at first glance looks unlikely to help but might be worth a
   try.)

 * Does "git svn clone file://$PWD/private-lustre-svn $PWD/private-lustre-git"
   work?

Ciao,
Jonathan
