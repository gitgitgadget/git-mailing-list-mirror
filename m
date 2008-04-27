From: "Kelvie Wong" <kelvie@ieee.org>
Subject: Re: Merge *to* branch instead of merge *from* branch?
Date: Sat, 26 Apr 2008 19:19:23 -0700
Message-ID: <94ccbe710804261919u5aa5406cnd26f2eb4ff44990a@mail.gmail.com>
References: <alpine.DEB.1.00.0804270037220.1149@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Peter Karlsson" <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Sun Apr 27 04:20:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpwUt-0005hU-0S
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 04:20:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbYD0CTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 22:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753363AbYD0CTY
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 22:19:24 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:6178 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbYD0CTY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 22:19:24 -0400
Received: by wa-out-1112.google.com with SMTP id m16so6984631waf.23
        for <git@vger.kernel.org>; Sat, 26 Apr 2008 19:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=r2VpKOkNOIbgHfRltGV/WKbLGWZhWM0sekduKHVHpVU=;
        b=gYUcfWzk/W9agGAI39rztBSi2WPF+kozbwJ/7Z19TT33Sis/6xuZs60hLAZE2YN4VBfZQrzBXxh9/z1YeilnuWjJ3PvHTJlypGIXJafwqtKDB7Oy5bMh0M9HiGuYwRH51BSSQs4PCjR7laEovBWAdbZidnpE22QMaZGdhXTO76U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=VSQ8xeB54/qE3P0OdyzXrgJxmOaWggNG5jPcfeZYEYTOtU/GEgYEFmJFmjl/33lByjCiqnPKZHnkwSx860gpdD8368960I6D72VpTPAHZniW5Vk3BnDJR6+cVh29LcPSMs4qnBS8hJeuOuU+xZQdnBflQ0Pef5DqGtbB1cSzXto=
Received: by 10.114.109.1 with SMTP id h1mr1259546wac.35.1209262763887;
        Sat, 26 Apr 2008 19:19:23 -0700 (PDT)
Received: by 10.114.81.12 with HTTP; Sat, 26 Apr 2008 19:19:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0804270037220.1149@perkele.intern.softwolves.pp.se>
Content-Disposition: inline
X-Google-Sender-Auth: 403fa67717adf013
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80404>

On Sat, Apr 26, 2008 at 3:42 PM, Peter Karlsson <peter@softwolves.pp.se> wrote:
> Hi!
>
>  My most common use-case of Git is currently somewhere along the lines of
>
>   git checkout master # start from here
>   git checkout -b new_branch
>   ...edit...
>   ...commit...
>   git merge master # to make sure I have the latest changes
>   ...make sure it all works...
>   git checkout master
>   git merge new_branch # fast-forwards master to new_branch's HEAD
>
>  Is there any way of not having to do the "git checkout master" first?
> Basically I want a flag to merge or checkout saying that I want to merge my
> branch into the branch I'm switching to. I can't seem to find any such flag.
>

I believe what you are looking for is in in the "push" command.

git push . new_branch:master # pushes your changes into master.

-- 
Kelvie Wong
