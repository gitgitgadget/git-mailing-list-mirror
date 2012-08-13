From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 0/4] Re: cherry-pick and 'log --no-walk' and ordering
Date: Mon, 13 Aug 2012 15:01:39 -0700
Message-ID: <CAOeW2eEbN-n72cq4Ywt=o6uVFkBWB5L6jAn9Qx_FBwyZLJdjMQ@mail.gmail.com>
References: <7vpq6ygcy1.fsf@alter.siamese.dyndns.org>
	<50289e50.8458320a.7d31.3c46SMTPIN_ADDED@gmr-mx.google.com>
	<7vhas7fefs.fsf@alter.siamese.dyndns.org>
	<CAOeW2eHprw73+zqVbJRird1eE7ayU_KjCUSoieYsGi1rbL5QBQ@mail.gmail.com>
	<7vzk5yen99.fsf@alter.siamese.dyndns.org>
	<CAOeW2eF67Tj0Mq+g+-3UFyh_Xvt=ZcKDc9LjCKGwu9y2G39NBQ@mail.gmail.com>
	<7v1ujacwcd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 00:01:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T12hm-0007Em-PD
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 00:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753344Ab2HMWBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 18:01:41 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:47704 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240Ab2HMWBk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 18:01:40 -0400
Received: by ghrr11 with SMTP id r11so3606817ghr.19
        for <git@vger.kernel.org>; Mon, 13 Aug 2012 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9dISX2O/37fDFiSxVvGAoeZmesy6VqlhPe8iR9nBvoY=;
        b=dtxejKGePB+UYRHvHo8c6+U1P8oxmzdhAj2dMalUr1uH3OAY1/a1X0C8yX2v5n/BVs
         a141u6eH9yfh8iW1urMV4H4GPUCCQV3X7zGdULJvuUaRUxqgM2hw6YC72Qdvl4rXbLgH
         2bF2F+SOcTG9y01MUu/JbmAGZoKOoN/f1A2O3dYLMYABVx5TjS+g+FGi8w4vVPnCHcHI
         IOqqhcRbr+jsvsOV1Lwg0SLdsGi9m8uQX3brAiEysHrgmcyp2yFAGm8tKbOOkCmWDo+d
         duz+hBdX0aSpuw8AQPODP2ewQDORIBVrjEV+FlDUZuTIL+Nbk1n6GR/Nl8xB1RF9YEwn
         yrDA==
Received: by 10.66.85.201 with SMTP id j9mr18799604paz.40.1344895299926; Mon,
 13 Aug 2012 15:01:39 -0700 (PDT)
Received: by 10.68.120.112 with HTTP; Mon, 13 Aug 2012 15:01:39 -0700 (PDT)
In-Reply-To: <7v1ujacwcd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203371>

On Mon, Aug 13, 2012 at 2:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:
>
>> Makes sense. The shortlog example is a good example of sorting that
>> completely reorders the commit graph sometimes even making sense for
>> ranges. Thanks!
>
> By the way, does this topic relate to the long stalled "rebase"
> topic from you, and if so how?

Yes, but only through the first patch in the series. Unless I'm
mistaken, I would can get a list of revisions to rebase using
git-patch-id, but to convert that into a instruction list with running
git-log on each commit, I planned to use 'git rev-list --format=...
--no-walk=unsorted --stdin', which of course doesn't exist before
patch 1/4.

The rest of the current series is a little fuzzy to me, especially the
confusion about reversing or not. Feel free to split out patch 1 into
a separate topic if you like, or however you would handle that.
