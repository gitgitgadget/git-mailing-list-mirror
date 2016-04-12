From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v13 6/6] commit: add a commit.verbose config variable
Date: Wed, 13 Apr 2016 03:55:12 +0530
Message-ID: <CAFZEwPMvBBjp2=ydq1oRcdc-d7oT68mYWC=PFqKe4fv7brGkvw@mail.gmail.com>
References: <01020153faf9fc14-e6ad18fa-c892-4601-bab7-e2cc4cd9e100-000000@eu-west-1.amazonses.com>
	<01020153faf9fcd0-879c8263-6143-4ad2-a3b3-deb78c93246a-000000@eu-west-1.amazonses.com>
	<xmqqa8kyplkp.fsf@gitster.mtv.corp.google.com>
	<xmqqy48io6bh.fsf@gitster.mtv.corp.google.com>
	<xmqqtwj6o4ip.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 00:25:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq6kK-0004c4-Hk
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 00:25:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756996AbcDLWZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 18:25:14 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34614 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313AbcDLWZN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 18:25:13 -0400
Received: by mail-yw0-f196.google.com with SMTP id h6so4234083ywc.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 15:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=+hq+o+Gnyi7315E/rywNWS27kks3+funDPYG0zkVt0s=;
        b=Z+idQKZqILVNqFOGlr5ub3M7lv8cbN3Glwpv9NQN49CIW2tWj+In8vREVJiuhoflL8
         6P5+N+nxsb90BssuQWlitzyIN8y1juySk3gr6WZldLkBJ/Cxi5jtSupyIgmyKTv8HaA/
         cyXxDJfJP/M7XGbCFPz4tRSf9KrgQFdaaQ1l2S2b7gU9posgf/rrhDrD4EdVws0Hv9oE
         PwY+pcGvWtrE7j/8M1YjHdNsLl3csV+nlmMHkVpZwbvGyYuxGHI+fUHZFB9T7TnENZva
         j5kwNeCvYbhnJ4lOZQa2/q7IExIWlQXkIQ6j0wGTM5omAxHijIUmyk2p/VMrafPZtzRl
         NqZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=+hq+o+Gnyi7315E/rywNWS27kks3+funDPYG0zkVt0s=;
        b=AfYmz65vFTVHWR0rBvkM4oBTJZTaKzmf1hNxOxvFvtog4qqGMGopGybeepA9raj2ya
         Ucpua7R/LiwSewXz8h4wKfBJYA9zOGAGD2sraAvfUSMJTTmOPQbRLPRFiwKlko42cp8d
         mV5qD+aHDvKH+RJihDTn/E/Tk1IiWGoA5H9sjzQmz1HN5HSCGC2apsfN6XIo7dVsMzNi
         gaBclT3Y0TtRkEH9qpzDsRhXSinp9fWj1rBfZn7GVsFQgnX+fOtlqS8xxLjr7uQvkhyr
         gSZLN57Dnx7Z4PsCgX1tLWo47yi/y65wqhGBSDIGRsqezKU5DgypR42F6gOaGjC78TU4
         WR3A==
X-Gm-Message-State: AOPr4FUtO54qZx7W8xL/Mic22pYJ2ph8tEPn/JJUBdcmSKvCUqAb2i38uwDHAGrbtWcDjoSZQzpzOqxRcqEfxQ==
X-Received: by 10.129.93.193 with SMTP id r184mr3120930ywb.68.1460499912102;
 Tue, 12 Apr 2016 15:25:12 -0700 (PDT)
Received: by 10.13.219.81 with HTTP; Tue, 12 Apr 2016 15:25:12 -0700 (PDT)
In-Reply-To: <xmqqtwj6o4ip.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291303>

On Wed, Apr 13, 2016 at 3:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Hmph, isn't this already in 'next', hence we cannot accept a
>>> replacement patch?
>>
>> As a one-time measure, I'll revert the previous one
>>
>> 50f0d20d (commit: add a commit.verbose config variable, 2016-03-14)
>>
>> out of 'next' and queue this one instead on 'pu'.
>
> I queued these 6 patches on 'master' and merged to 'pu', but it
> seems the series breaks t0040, so in the meantime, I ejected the
> whole thing.

I forgot to update the newly introduced tests in this series for the
new behaviour. I will send an re-roll
