From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] sequencer.c: abbreviate hashs placed in the middle of messages
Date: Fri, 8 May 2015 19:26:16 +0200
Message-ID: <CAN0XMOLhkTMWDr+eOsb5H8YiC1b7Nk0OKTSfi02ocr1unwFjfw@mail.gmail.com>
References: <1431104035-2056-1-git-send-email-ralf.thielow@gmail.com>
	<CAPig+cSeNn0r7N6vp+qs4NTNwfYx5p-zUX3tkifuXLu+nB2yNQ@mail.gmail.com>
	<xmqqbnhvm1f5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 19:26:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yqm2Y-0005pB-ME
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 19:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbbEHR0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 13:26:18 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:38547 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932068AbbEHR0R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 13:26:17 -0400
Received: by wiun10 with SMTP id n10so34858931wiu.1
        for <git@vger.kernel.org>; Fri, 08 May 2015 10:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PvSLm/K8tD+LNtbT0t3snvjwAOWPxZfZG3nKYZDH184=;
        b=x0F0xXnuwpYr6LwL2o0SqF0H6Ykj+UFTKcNx/SUuCSxwqfPJQ9bOPA3d8HpLUEWtAv
         EMms3u0ygY7JScf6Q4WnrrKve1Jsgb0Dkyq+6seiLWcDnfZLva5N7fwztMqwpk2hSheD
         9KcVnOxsTTLnG/fDaqlpMWeUNl2yWncwQivNXL+zynca6H7EeTGWEfq810V+vU45fb7X
         sI2aZnEPz34BrGTREeKOba9CKotEI0xP9LZFdTEHW3eNd6/kpmPwDOpolB27KhnKfBPo
         rDHIxJxole3vbMoOSDzEZz5lU/u9WVX9TU0VvYK9WSSvZoS0QvFCA2Ksc1k3WyE2CJZv
         pvhA==
X-Received: by 10.180.74.144 with SMTP id t16mr8010631wiv.33.1431105976663;
 Fri, 08 May 2015 10:26:16 -0700 (PDT)
Received: by 10.194.72.6 with HTTP; Fri, 8 May 2015 10:26:16 -0700 (PDT)
In-Reply-To: <xmqqbnhvm1f5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268629>

Junio C Hamano <gitster@pobox.com> wrote:

> If identifying the exact commit has value, on the other hand, we can
> rephrase it like this:
>
>         error(_("no -m option was given to pick a merge '%s'", ...));
>
> to place it not in the middle.  We can do similar rephrasing for
> other messages as well.
>
>>> -                       return error(_("Commit %s does not have parent %d"),
>>> -                               sha1_to_hex(commit->object.sha1), opts->mainline);
>
>         error(_("No parent %d for commit '%s'", opts->mainline, ...);
>
>>> -               return error(_("Mainline was specified but commit %s is not a merge."),
>>> -                       sha1_to_hex(commit->object.sha1));
>
>         error(_("-m option was given for non-merge commit '%s'", ...);

The %s can be placed to somewhere else in translations.
