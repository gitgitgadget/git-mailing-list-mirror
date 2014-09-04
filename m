From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2014, #01; Tue, 2)
Date: Thu, 4 Sep 2014 20:46:53 +0700
Message-ID: <CACsJy8C_=aNX9LT2V_zhw++tC22C5SDfwbpTS=juONMxwcV9pA@mail.gmail.com>
References: <xmqqzjehy8vx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 15:47:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPXNp-0004CP-DV
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 15:47:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbaIDNrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 09:47:24 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:41043 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbaIDNrY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 09:47:24 -0400
Received: by mail-ie0-f173.google.com with SMTP id lx4so11777739iec.32
        for <git@vger.kernel.org>; Thu, 04 Sep 2014 06:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=4LbzaT6oDpHiGcMYX22s1k4l2zOkKJooEeckBObkH90=;
        b=yWLuZUYuWfbxNdwwDAlZHN+Qt5bqX7Yswm2Dj/HXtCTL6V2Gk5lEGoyEQROTPvjnCb
         dKnZg+BL3hgFPxtwFN4P9lrwNwJ71uaxE9MqSElxL74ybgvkGsI1JasKzDnY1smktqkK
         MMq6p3CN3xHB7aoqHOxkfNIq3b7UDTvjRCstlre28YeqTJ5ByoJS8rmhO1Qz7/8Oz88N
         I1oGYQDFu7CUxKhjWrkANh09fC+d0igSeOefnLQiUYcYwpv03V1FejH7dMLJryqwKizc
         8eLD9TgYNxBl3wwQQgFTBg617zQ4QnEGNyDg5pH/dX7l5DgA43QUPq5t3bszQzhrE7Eo
         Qz+w==
X-Received: by 10.50.61.145 with SMTP id p17mr6923124igr.41.1409838443587;
 Thu, 04 Sep 2014 06:47:23 -0700 (PDT)
Received: by 10.107.3.152 with HTTP; Thu, 4 Sep 2014 06:46:53 -0700 (PDT)
In-Reply-To: <xmqqzjehy8vx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256442>

On Wed, Sep 3, 2014 at 5:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> * nd/multiple-work-trees (2014-07-29) 39 commits
>
>  Reroll posted, but haven't picked up yet.  How would this interact
>  with rr/transaction series which is pretty much all about the refs?

Haven't checked out that topic yet. But ref changes in
multiple-work-trees are to make sure ref path construction goess
through git_path(), and some cleaning up after strbuf_git_path() is
introduced. So basically textual conflicts only.
-- 
Duy
