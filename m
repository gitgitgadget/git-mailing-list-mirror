From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] clean: style fix for 9f93e46 (git-clean: use a
 git-add-interactive ...)
Date: Wed, 7 Jan 2015 19:35:44 +0700
Message-ID: <CACsJy8BdQtbLMJ1EmS+i2TzZYaGbZ-PAkB3CPdFOjZtE13LN+g@mail.gmail.com>
References: <1420464563-5579-1-git-send-email-pclouds@gmail.com> <xmqq4ms3pvle.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 13:40:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8pqZ-0004Om-Tu
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 13:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519AbbAGMgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2015 07:36:16 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:61587 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048AbbAGMgP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2015 07:36:15 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so3365486ier.0
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 04:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HlUOI++4FafJHnFO0BkhKXiYdeFSQY9DA4zURNcwL9U=;
        b=Zn2Yflv3fdp1epfuBWNit3u8wEFjmseLmcr/wq90xrK6EdZXePjJjqFfWfh+AlcsfC
         wdDJ/8Nkrc8eGvRN8KteEbGBanug1ezjgAxf8hhKYEpLY/ZzLUJes7tAJIQHnkk92G2n
         ZlKgI5675rMrWlmiIzsEg6Y+oSh7VLKSLIMJSEBHGEBEQL9Hdy8impPOT/nr9iMh3oS3
         Gil2flKcE57IPLmB9YK53NXSBtNGjZWNOFy0jN4NwsNOIa92cruJS1xQCNKScbRWdHlb
         URNI4FWJOKe+6DbA5+Ej7Q1L0AcyLnx5wgCRS/88Vy3nnQceQK5OzwuBt2hhvbB35PS2
         xEkg==
X-Received: by 10.50.107.7 with SMTP id gy7mr3274422igb.49.1420634175024; Wed,
 07 Jan 2015 04:36:15 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Wed, 7 Jan 2015 04:35:44 -0800 (PST)
In-Reply-To: <xmqq4ms3pvle.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262130>

On Wed, Jan 7, 2015 at 2:17 AM, Junio C Hamano <gitster@pobox.com> wrote:
> When I do a SQUASH???, I expect the original authors use it as a
> hint in their rerolls, but because this series has seen no comments
> so far (no interests???), I do not foresee or expect you to feel a
> need for rerolling at this point.  If you agree that the remainder
> of the SQUASH??? (shown below) is sensible, I'll turn it into a
> "fixup!" for cc44d4fe (untracked cache: load from UNTR index
> extension, 2014-12-08) and requeue.

No there will be a reroll. I was going through the comments and this
is the easiest piece. Glad to hear it's already in 'maint'. The
remaining change in your SQUASH??? will be squashed in the right
patch.
-- 
Duy
