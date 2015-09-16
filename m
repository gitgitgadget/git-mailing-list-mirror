From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 04/67] fsck: don't fsck alternates for connectivity-only check
Date: Wed, 16 Sep 2015 15:14:24 -0400
Message-ID: <CAPig+cRtQG9km2xT_h8D02jUC_FLnp_QzBaX-+N7Bw01a1v5sg@mail.gmail.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915152428.GD29753@sigill.intra.peff.net>
	<f536d3d011ff1943c3cfcf90c9dce664@dscho.org>
	<xmqqtwquqlz2.fsf@gitster.mtv.corp.google.com>
	<20150916181237.GB17381@sigill.intra.peff.net>
	<xmqqwpvqp49e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 21:14:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcIA3-00009a-2d
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 21:14:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbbIPTO0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 15:14:26 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35992 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752002AbbIPTOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 15:14:25 -0400
Received: by vkfp126 with SMTP id p126so107640926vkf.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 12:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=G82aIq7In0UxWLetY8xQi5QHClu+hzU9kzziVlmKRDU=;
        b=kcXLyfF91XWb7V2q6f4dEk2v1Nrx6AFc8h1K5tqnAgG2BIL6fUrqezwEjohsvYjnOS
         8E1OimeSsQh7ULf6cs5MUCQXW7h8TQqVis84LBEzdpCv8uoq1ZvxeJ/r9MP+qmNvsyX/
         +5eT4IaeqZKt4b/DBfFpENBjQw6G0ZUsQH3Z+B3evv4wowFppe4fKf1dE+5CvALhJL0Z
         sGXPFffUmnbezQt4tcQRAvxU/x75ahXz3Cjrg9Ujom5OT0cGnfmaE4RiCLvnIGJTxCJd
         OdSniXZ5A6aWcxm56EcgdRgscF08ouhhMfSPlFDA9POBfyfAPsWsQtoj8FevXPzpxWCR
         0NtA==
X-Received: by 10.31.11.19 with SMTP id 19mr4636002vkl.84.1442430865037; Wed,
 16 Sep 2015 12:14:25 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Wed, 16 Sep 2015 12:14:24 -0700 (PDT)
In-Reply-To: <xmqqwpvqp49e.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: -1GMJzMsXErlyXD5JVUrX9iDHKU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278051>

On Wed, Sep 16, 2015 at 3:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> Speaking of which, how do you want the next round of patches? I'm
>> hesitant to spam the list with 67 patches again, when only a fraction
>> have changed (and for all but the _to/_r thing, I've posted my changes
>> already).
>
> Cannot tell yet, as I am only halfway thru myself.

I'm also only about halfway through, plus trying dealing with other topics...

> If there is a
> significant update based on discussions, it may be worth sending
> only those so that you can sooner make sure that the resulting
> change and those who reviewed the first iteration are all on the
> same page, but a full resend, before giving enouth time to those who
> are willing to but have not found time to review the whole thing,
> would be a wasted mental bandwidth for everybody, I suspect.
