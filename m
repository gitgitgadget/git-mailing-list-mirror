From: Kevin <ikke@ikke.info>
Subject: Re: confusion with some `git reset` commands
Date: Thu, 18 Dec 2014 09:23:09 +0100
Message-ID: <CAO54GHAVMSYCHAoqH1OOSaUeHBdSmqTvzJLWWUa0_bO3CLy4zg@mail.gmail.com>
References: <2055441.uOK6yH3IMG@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Arup Rakshit <aruprakshit@rocketmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 09:23:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1WMy-0003G0-Ka
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 09:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbaLRIXb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 03:23:31 -0500
Received: from mail-wi0-f177.google.com ([209.85.212.177]:41507 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501AbaLRIXa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 03:23:30 -0500
Received: by mail-wi0-f177.google.com with SMTP id l15so885046wiw.16
        for <git@vger.kernel.org>; Thu, 18 Dec 2014 00:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=XhIRljKAgXPKSjL8MDVj0olCuefzl3jjclyv4BQ02G4=;
        b=OkSDpkIJIuKQGHt5dPHwkYorMXW0ua2ARn6E98JFlAc2lmDNfzxbof9F7eDk6Bdm67
         KNWCS8gYqGBENqfOKRS6NZc1BcIu4wlvGg8e43jvxgi3l1iHtoMK2o1qXEVeneikuItC
         G0KNPSgVIC/uVuUC1iNt79tjkmppy1LGriZ9d7SrgMhwzwXSP6fRoC8eyiChyYBvs2nN
         WpGP3xg+xXGrWy+RHvsOs4qcK7XG13ShuvkByYivnlf+WDdWZDpg9GAWMkG30sDD0BlL
         lwPyHcrFNNSGTfOWh56oA/1cMMkxe0VZgT6Vsub31G/sOM6EWlOzJDO7k4G0L+PBtQeO
         9hCg==
X-Received: by 10.180.20.106 with SMTP id m10mr22048553wie.1.1418891009377;
 Thu, 18 Dec 2014 00:23:29 -0800 (PST)
Received: by 10.194.37.132 with HTTP; Thu, 18 Dec 2014 00:23:09 -0800 (PST)
In-Reply-To: <2055441.uOK6yH3IMG@linux-wzza.site>
X-Google-Sender-Auth: kpSQTWN3wvDgLoXgDy9sabwZ5sI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261518>

On Tue, Dec 16, 2014 at 7:39 PM, Arup Rakshit
<aruprakshit@rocketmail.com> wrote:
> Hi,
> ..
>
> But I am looking for any differences -
>
> a) git reset --soft and git reset --keep

git reset --keep is a safer version of git reset --hard. It will reset
the working tree. but will abort when it has to overwrite uncomitted
changes.

> b) git reset --hard and git reset --merge

git reset --merge does the same as hard, but keeps unstaged changes.
When unstaged changes would need to be overwritted, it also aborts.
