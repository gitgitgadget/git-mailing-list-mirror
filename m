From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 00/10] remote-hg: fixes and cleanups
Date: Mon, 13 May 2013 22:34:18 -0500
Message-ID: <CAMP44s134n9az4anLAnNH6DLT92kAJjW3_rYUx1hGZJ6ECWAYA@mail.gmail.com>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
	<7vfvxql66j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 14 05:34:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc60O-0005Ry-KL
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 05:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755702Ab3ENDeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 23:34:20 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:38990 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338Ab3ENDeU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 23:34:20 -0400
Received: by mail-lb0-f181.google.com with SMTP id w10so115066lbi.26
        for <git@vger.kernel.org>; Mon, 13 May 2013 20:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=rGBU6H9Mn6Rk29Qz2JXs2ArMH2UfPU385fTE9WXtehY=;
        b=hPEoZfqB0XecHVIUAKMwe6mfyzV29bQ7wMbabl1j5IHrl4zcaWMzvGoCqVQOjfgxB7
         s1kXixgtJv5vLxGkMvHSuGf/Nhs4v3kUc+mBWleBIi9yJu+o7RRV0lUB8CuUL0iYzbG7
         ooB4eP2StTFmVzUVZMKsCIeudELxbiBLusPsYan45MWo+B/tnC/cpeSDi6/GnEbjBMBO
         DFBOUUt6++vC8vF52pivDZlS5fkVX8ZwXFCHkyzgK2Mxr2/Oh1XfS/a8XLgRZbqsqxup
         SeGwwVM/wYSOP0A0miriRK33ly6d3O4hL8BwwBjKrWwp7csOlAzA4eYSfWDA9e1dzp9T
         0Hfg==
X-Received: by 10.112.135.70 with SMTP id pq6mr14426691lbb.82.1368502458362;
 Mon, 13 May 2013 20:34:18 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 13 May 2013 20:34:18 -0700 (PDT)
In-Reply-To: <7vfvxql66j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224233>

On Mon, May 13, 2013 at 8:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Since the last series is not merged to master yet, I decided to add more cleanups.
>
> Because nothing new will go to 'master' past -rc1 by default, unless
> you are working on fixing or finding 1.8.3 regressions, this is a
> good time to polish things that are meant for the next cycle.

I know, I've been polishing a bunch of patches for the next cycle for
a long time.

> Folks interested in working remote-hg, please try it out, so that we
> can have a polished one soon after 1.8.3 ships (I am not saying this
> round is not polished---I haven't even looked at the patches).
>
> And others, please spend time on testing the 1.8.3-rc2 to make sure
> what we are going to ship is free of embarrassing regressions.

The whole purpose of this series is to avoid regressions, that's why I
sent them for 1.8.3. I thought I made it clear[1] that we would want
these patches in, to avoid regressions, unless it's desirable that we
end up pushing garbage to a remote repository.

Cheers.

[1] http://article.gmane.org/gmane.comp.version-control.git/224224

-- 
Felipe Contreras
