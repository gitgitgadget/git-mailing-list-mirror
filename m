From: Vasily Titskiy <qehgt0@gmail.com>
Subject: Re: [PATCH v2] Ignore dirty submodule states during stash
Date: Tue, 17 May 2016 13:12:12 -0400
Message-ID: <CABSveYjmqrPY4OVrYnWeCrjAqZdqOaciCzQ2_soB4akOcQgZpQ@mail.gmail.com>
References: <20160517131635.GA5299@gmail.com> <xmqqmvnoy82r.fsf@gitster.mtv.corp.google.com>
 <CABSveYgsRU+L5qvY_evwekaRU7-oL_2Mmxt6L1u2dYM7Xfq2rw@mail.gmail.com> <xmqqa8joy5sv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 19:12:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2iXu-00050s-7G
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 19:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbcEQRMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 13:12:34 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:33930 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbcEQRMd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 13:12:33 -0400
Received: by mail-yw0-f175.google.com with SMTP id j74so22294574ywg.1
        for <git@vger.kernel.org>; Tue, 17 May 2016 10:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FoI8B5ytFLZlXw9Dqmdrp0MAaqzcwsFRuVGntAgUTC0=;
        b=Lta1d5oRv+E3u83TleNT7Grj0ilpOezac7R33hi2XDLXRnkbKFq7phrtz//p2FwycY
         A8IZkyTK0ebdG+d+JNQCiejQRQ0rY54jTdmzNhlKHujS5K5FCEpyyljLdBdzis9CoaSH
         ffe7WnbfdLOrnAXUd94wtq1RBYhard6H5m5qgSBwBuZ7mnHNlueKMRR5VNkJY70JpmVk
         pnD2SePabnIVsH886B+9N03ihEK65MGCVZ0XZLGCt+Y0A6nmCO9W7hyZuEEGM/zVOWa2
         aGVdN0aiT8DUVKLh6MhwBo2t2A20ablC3YO2Xz1NckDkQ8aZ8dzAqnndvi8awDCsv/Nh
         rkjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FoI8B5ytFLZlXw9Dqmdrp0MAaqzcwsFRuVGntAgUTC0=;
        b=C0usqbMQ02fxbJfigQfTBi8GfQ/acUSSNtUhdnJx5ADmITAWlB0sOWyhw2T06mi3pA
         WeOzVkyOQ9Pqp9gNH7mDFdWp2UUFskLC+V4U5VnRHg8WTgxgljomX8zObfrkhPPsh56K
         eAfka7v51n3KsON4n3iohtPbrzUpw0jxOK47/JgCwLMTbnlwSM3zx0JP5dNEnKCX8zYI
         wRwVpw5ADJlIvx8SoBhlhmwKldVf/v4rmJp3pYKbbVdWB8U4TO8a5AP7h+NY4hRHKQ8S
         CkHaF11md5BmbAv9ZxOUFdoppPTha9Z977uURkcKIqRFNo/86Pb20Q//xW9Bei3Pn5cX
         vXbQ==
X-Gm-Message-State: AOPr4FWg20j7X8/hFHKPTxCv7UqpufIVM+frDo1TwLfH2FBAk/YTP4jNwMi6OHoRktkaS6dJdWTg1OqO6aAIhw==
X-Received: by 10.129.152.11 with SMTP id p11mr1260923ywg.125.1463505151819;
 Tue, 17 May 2016 10:12:31 -0700 (PDT)
Received: by 10.37.203.145 with HTTP; Tue, 17 May 2016 10:12:12 -0700 (PDT)
In-Reply-To: <xmqqa8joy5sv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294879>

The command does nothing, so it's not needed. There is also a typo in
my patch description, so I'll resend it again with needed changes.
--
  Regards,
  Vasily Titskiy


On Tue, May 17, 2016 at 1:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Vasily Titskiy <qehgt0@gmail.com> writes:
>
>> You're right, it's redundant here. Should I resubmit the path without this line?
>
> I wasn't pointing out that it was not needed.  I was only asking
> what it was meant to do.
>
> If you now think it shouldn't have been there, that merely means
> your code was wrong.  It does not mean I'm right ;-)
>
> With that line removed, would the patch now becomes right?  Are
> there other bugs?
