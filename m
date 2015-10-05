From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Broken link in the git basics introduction
Date: Mon, 05 Oct 2015 10:36:43 -0700
Message-ID: <xmqq4mi5z07o.fsf@gitster.mtv.corp.google.com>
References: <loom.20151005T104946-649@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Botazzo <mikebotazzo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 19:36:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zj9gv-0005aR-UL
	for gcvg-git-2@plane.gmane.org; Mon, 05 Oct 2015 19:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbbJERgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 13:36:46 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34969 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbbJERgp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 13:36:45 -0400
Received: by pacfv12 with SMTP id fv12so186465586pac.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ZJlg+nqO/9GrY9G/2QYS5keLoo0frztdwZqizUjlR6s=;
        b=lz6ex3yfZUNoW9MHyMztIWXb5/XgAH/L998Cx9jSH72uWUffDhfGbo21ymCrP7a5Mz
         yYRskhFJrvyk/HaKu3ubAMlGyMQjnUhjgwBCB+oxCHUeyGCm3KPOLguZf+GctfZnCG6P
         /+hGUyiuPYbMp7Tad4i9pe2PsGTdkxfeVvIc8DaAciNdN/3gbDCA3uSuPgMcEQFoPkOc
         yZn3AkYBKTJgtbxE8WD8UUZzZUl9Ta19dRKmkVS0HKhz5lNw9CYG0g250kwhML9m0fVw
         cm2Hx1E4BPiOulLkCTAgglz85Sh1yjeOGWhAA62I8259++R4M1KDvejcpUhgu/4SRsTk
         6gFA==
X-Received: by 10.66.131.81 with SMTP id ok17mr40515402pab.150.1444066605088;
        Mon, 05 Oct 2015 10:36:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:60e8:cc09:ddf4:4eed])
        by smtp.gmail.com with ESMTPSA id i9sm28718470pbq.84.2015.10.05.10.36.44
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 05 Oct 2015 10:36:44 -0700 (PDT)
In-Reply-To: <loom.20151005T104946-649@post.gmane.org> (Mike Botazzo's message
	of "Mon, 5 Oct 2015 08:51:45 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279063>

Mike Botazzo <mikebotazzo@gmail.com> writes:

> I was reading the git introduction in the git-scm website and the link inside
>  the section 'Git Generally Only Adds Data' (Undoing Things) was broken.
> Webpage: https://git-scm.com/book/en/v2/Getting-Started-Git-Basics
> Broken link:  https://git-scm.com/book/en/v2/1-git-basics/_undoing

The page has this on its left-hand-pane:

    The source of this book is hosted on GitHub.
    Patches, suggestions and comments are welcome.

It seems all three in-text links on the page are broken: "Git
Branching", "Undoing Things", and "Git Basics".  They all lead to
404.


https://github.com/progit/progit2/issues/429
