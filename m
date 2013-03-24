From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] user-manual: Fix the interactive rebase example commit range
Date: Sun, 24 Mar 2013 16:00:17 -0400
Message-ID: <CAPig+cS5_YLpNO559ZFTg8SAVrOPAaUmhA6tKOeMG+hv3D3SPA@mail.gmail.com>
References: <7vobfg3tw8.fsf@alter.siamese.dyndns.org>
	<c29df638e260ab104bf940cc41ce5d75713707a8.1364127610.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sun Mar 24 21:00:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJr62-0001lh-Rn
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 21:00:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707Ab3CXUAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 16:00:20 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:58776 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754674Ab3CXUAT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 16:00:19 -0400
Received: by mail-la0-f49.google.com with SMTP id fs13so10162721lab.36
        for <git@vger.kernel.org>; Sun, 24 Mar 2013 13:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=I22Xx6gaks2E+I6jljF/6RiEtAv2wI8a3g5uGizdfnw=;
        b=a8G6ZHIDjzsrdCqeRjYtyDUlnw1Ivax6/USn1zgrVlTcUu4MhTeKqh43oN54JbGecE
         gSurKQKXJCI+azSILxQjtwqKnkzIViImjsNo9YKubCIcEAEBAFU7RNwURZWEMVDRS/zE
         9aYBC3FlgURrcJphU2KrXPZHb5WLlnJClsFpp6yi3nGgwcoLvwPKfMgMqc8FVPc1m5fv
         kSGREn6cqZuIne4xTwWdCwl6fYrkjofRYT0Rgn7QiNP/hVwWg7U0Yn186AB9hhfKToOP
         zadfO4baESykwOa1FU/7IWJ5ncwdvfO9N7oVPEPtqw0PXK4FStXd8eOc/MijUTzSZO2f
         ulpw==
X-Received: by 10.152.123.34 with SMTP id lx2mr4676530lab.52.1364155217474;
 Sun, 24 Mar 2013 13:00:17 -0700 (PDT)
Received: by 10.114.1.43 with HTTP; Sun, 24 Mar 2013 13:00:17 -0700 (PDT)
In-Reply-To: <c29df638e260ab104bf940cc41ce5d75713707a8.1364127610.git.wking@tremily.us>
X-Google-Sender-Auth: 4z8tONv7pjslJyIbAUo4N72HBto
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218974>

On Sun, Mar 24, 2013 at 8:23 AM, W. Trevor King <wking@tremily.us> wrote:
> 6c26bf4 (user-manual: Reorganize the reroll sections, adding 'git
> rebase -i', 2013-02-19) used deadbee as the oldest commit in the pick
> list, but as the final commit in the rebased range, due to sloppy
> duplication and extension from git-rebase.txt.  This fixes that by
> adding a new HEAD commit.
>
> I also reworded the example commit summaries (onelines), because I
> think my initial mistake may have been to to misinterpreting "this

s/to to/due to/

> commit" as "HEAD" without thinking things through ;).
