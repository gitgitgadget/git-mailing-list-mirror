From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Unable to create temporary file '/var/git/tmv3-target-overlay.git/shallow_Un8ZOR':
 Permission denied
Date: Sat, 19 Sep 2015 09:26:21 +0700
Message-ID: <CACsJy8BLHw_n=PEHOGNah+-YrQgkVmie6m+PzpkNLHeV4tT4zg@mail.gmail.com>
References: <1440157010.1759.83.camel@transmode.se> <CACsJy8DEDgsG4C4KvuGop_=_wOvcOUZ644NiaQJef67rFNYmgg@mail.gmail.com>
 <1442245035.10125.18.camel@transmode.se> <CACsJy8BAOXWt2aVge7W8Mk9v0HbHHGkSQFwySeioam9r+n6z_Q@mail.gmail.com>
 <1442508864.21964.26.camel@transmode.se> <CACsJy8DFpLLtc7+Mix1d=Hy8h-duUqt4Y8WYsRL1nEryizoeww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Sat Sep 19 04:26:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zd7rd-0008Lp-FL
	for gcvg-git-2@plane.gmane.org; Sat, 19 Sep 2015 04:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642AbbISC0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 22:26:52 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:35092 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754589AbbISC0v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 22:26:51 -0400
Received: by ioiz6 with SMTP id z6so74097734ioi.2
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 19:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Iqq5B0HR8cEDqqdzo6+QCXo5TCUEl8wEkcf/5+sQwn8=;
        b=QiaPl/sWKFNb7WTbbBf2EhIePE71ZNpRhOwTpQZkim/HPIS69m48QphQooYUUmhESF
         AaveApxid924YTS14Z7NqQ2qaeESs/jfLBB2AB7omDUp0De9swB4YEQqUS724jmrm1og
         zfDOZG/dstrYV0RVOYmDE4yBGOowxxnFV4a3ny1HLtpbv4ambxS41tAyBANjVRgnNzaM
         bO/DnrYr5c4l8erumOqb6aSA4HYAIbQcwfYnvHSELRWtVAmPLJPThXWGngPICnbh2cxF
         HIFsu4jL0zTfedXAC5z6LaVeqloNvuvZaFVr10lrqUn77VWO23cCFZF8L/1b8vVgpTks
         eiPw==
X-Received: by 10.107.131.134 with SMTP id n6mr16868753ioi.192.1442629611115;
 Fri, 18 Sep 2015 19:26:51 -0700 (PDT)
Received: by 10.107.19.227 with HTTP; Fri, 18 Sep 2015 19:26:21 -0700 (PDT)
In-Reply-To: <CACsJy8DFpLLtc7+Mix1d=Hy8h-duUqt4Y8WYsRL1nEryizoeww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278229>

On Sat, Sep 19, 2015 at 9:21 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> Even if you disable gc --auto and run it periodically (with
> cron or something), it will write gc.pid.

Ignore this sentence. Of course you can run manual gc using a
different user and with write access.
-- 
Duy
