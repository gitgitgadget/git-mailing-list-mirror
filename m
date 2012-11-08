From: Simon Rozet <simon@rozet.name>
Subject: Re: Revert option for git add --patch
Date: Wed, 7 Nov 2012 17:00:17 -0800
Message-ID: <CAHAYOozgUaV=GH8zOaJn1xLSM_M-aKmFovcOEVzYpNTBW6ifgQ@mail.gmail.com>
References: <CAPXHQbOxNG0XN80rH6mM6iSVtCtU26Yio_XQ=5ofBHBpZN3VyQ@mail.gmail.com>
 <CAPXHQbN0x-o_4rQO-Lq_gDTqs=beBE5XrrzJ1Th+7G2Lq7Dh_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 02:01:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWGUc-0006my-7a
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 02:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754716Ab2KHBBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2012 20:01:00 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47000 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754701Ab2KHBA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2012 20:00:59 -0500
Received: by mail-ee0-f46.google.com with SMTP id b15so1259956eek.19
        for <git@vger.kernel.org>; Wed, 07 Nov 2012 17:00:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:x-gm-message-state;
        bh=BLJFJQOkI/C8tQOsnxyT/GTKLrl03DKgZ/Cuirz3ELE=;
        b=K71zDP8nTYkrEC8yaBLg6j59hUS+h2YG4PuMrX3taUiNC8eskwjL3urjSbeTfWSxH2
         moWERFdA1J8fBZToMOa57JQo8SWeuerzdJoXZEPcBH9cSkI4GUsCM3BhnDYQKrSTyx0t
         9uGKRlssmOyhK3eFC6gXOdDXmagJf5PN3ya5YAhdf1Phhb9HtnK+hyGupAY2nz+8+iaJ
         2Jz4gOanRTdSxPWPpoCzBUK3Da2+YAYmXFVltZF7iHVoBEF0hhy+glrUurOFrsDc6V7g
         9Ye0vuvnTD9pdZPe2HnXPyfQskELW+nr9gizqgZpUZC9J3WMoZ6OFukG5dzFZWV3ZbL0
         Wo5g==
Received: by 10.14.221.8 with SMTP id q8mr21368401eep.28.1352336458588; Wed,
 07 Nov 2012 17:00:58 -0800 (PST)
Received: by 10.223.132.200 with HTTP; Wed, 7 Nov 2012 17:00:17 -0800 (PST)
In-Reply-To: <CAPXHQbN0x-o_4rQO-Lq_gDTqs=beBE5XrrzJ1Th+7G2Lq7Dh_Q@mail.gmail.com>
X-Gm-Message-State: ALoCoQmqe04XLfnGCoUX6dtRsdfLK7LZVdUAhK3ephDRXweshN1rcepmgw6PF13yVjIJUQ6qESJs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209148>

help

On Wed, Nov 7, 2012 at 3:54 PM, Nathan Broadbent <nathan.f77@gmail.com> wrote:
> Hi,
>
> I would like to propose a revert option for 'git add --patch', that
> reverts the hunk. I often use `git add -p` to skip whitespace changes
> when preparing a patch, and a 'revert' option would save me from
> running 'git checkout <file>' after I've staged the desired changes.
>
> I would propose adding r and R options for the 'Stage this hunk' menu,
> with the following actions:
>
> r: Revert this hunk
> R: Revert this hunk and all other remaining hunks
>
> e.g. Stage this hunk [y/n/a/d/K/j/J/e/r/R?]?
>
>
> Please let me know if you think this is a good idea.
>
>
> Best,
> Nathan
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
