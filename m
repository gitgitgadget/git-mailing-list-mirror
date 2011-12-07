From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Odd issue - The Diffs That WILL NOT DIE.
Date: Wed, 7 Dec 2011 18:20:07 +0100
Message-ID: <CAGK7Mr7z6hqoda=pr3syzC5mO1+ZExMeD7sReeyRaYL5OMhemw@mail.gmail.com>
References: <CAJ8P3RBm=RhNf6LKLqprqX6Rqx0OgRnJR+=+-Qhg4PvpeqaUDg@mail.gmail.com>
 <20111206215102.GA3654@centaur.lab.cmartin.tk> <CAJ8P3RCPt9Kwi1F7_TEkZQhkm1mwR_TFKhYszS5LL50kXU8oNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org
To: Chris Patti <cpatti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 18:20:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYLAk-0006O1-Rx
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 18:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756637Ab1LGRUl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 12:20:41 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46070 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab1LGRUl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 12:20:41 -0500
Received: by iakc1 with SMTP id c1so1201724iak.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 09:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=o3BNI8xmMcVldk0w61YWp7DjxgqS6FqSu9yvKWFlDo0=;
        b=KSda2MZwvCYT9q+c7P6XJmPDEH81zxSvibKnJTXSDksAbcZp5335zSkFBA7llRaeHL
         l8I2kSIlKkOQNMIfLZCn8Z/a9L3tDe5h30UfV2i6E+OkE5oO+MRS84HK/P0FDQ83eKuG
         EkqjgoJUbgRX3o3JYLHjnslXbB8MvCu9TMGd8=
Received: by 10.231.82.131 with SMTP id b3mr4559142ibl.74.1323278440224; Wed,
 07 Dec 2011 09:20:40 -0800 (PST)
Received: by 10.50.189.166 with HTTP; Wed, 7 Dec 2011 09:20:07 -0800 (PST)
In-Reply-To: <CAJ8P3RCPt9Kwi1F7_TEkZQhkm1mwR_TFKhYszS5LL50kXU8oNQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186475>

> 11:35][admin@Hiram-Abiff-2:~/src]$ rm -rf framework/
> [11:44][admin@Hiram-Abiff-2:~/src]$ git clone
...snip...
> [11:51][admin@Hiram-Abiff-2:~/src]$ cd framework/
> [11:51][admin@Hiram-Abiff-2:~/src/framework(master)]$ git diff
...snip...

Can you paste the output of "git status" right after the "cd framework"?

Looks like you have some external process that goes and touches your
file after the git clone, or that git fails to check out the files
after cloning but isn't able to work out it failed to checkout those
files.

Philippe
