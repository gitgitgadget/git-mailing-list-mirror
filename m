From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 14/18] reset: Make reset remove the sequencer state
Date: Mon, 8 Aug 2011 09:27:28 +0200
Message-ID: <CAP8UFD0FfPqFpp1Fvg+ESkt1euqua6n_WPa3BSoyBEkNrOrFvQ@mail.gmail.com>
References: <1312454356-3070-1-git-send-email-artagnon@gmail.com>
	<1312454356-3070-15-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 09:27:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqKFL-0008EG-Hk
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 09:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521Ab1HHH1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 03:27:31 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:43267 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399Ab1HHH1a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 03:27:30 -0400
Received: by yxj19 with SMTP id 19so2326040yxj.19
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 00:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6/vWih/MGx6QngIfoSjg+N8iiKGP1hMPBQo/T5L2rdg=;
        b=JPCscIYm/ob17/4S1WQBdqI1xeBWx/aprfcU7hsW6vnEIsCq5iwJpKWuuvj+3+Rjhf
         yIjE23Y7y+FWHmTS5EYB8GDklMCPJGqGdY5+oWMnehLvzM546vcO4fvAkGocLKgvSIoX
         kp2jZiLw6Qne5XQfZB88XIWu1hPkGmK6xcC9Y=
Received: by 10.150.254.1 with SMTP id b1mr2040522ybi.415.1312788448190; Mon,
 08 Aug 2011 00:27:28 -0700 (PDT)
Received: by 10.147.41.13 with HTTP; Mon, 8 Aug 2011 00:27:28 -0700 (PDT)
In-Reply-To: <1312454356-3070-15-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178944>

On Thursday 04 August 2011 12:39:12 Ramkumar Ramachandra wrote:
>
>  branch.c                 |    2 ++
>  t/7106-reset-sequence.sh |   44
> ++++++++++++++++++++++++++++++++++++++++++++ 2 files changed, 46
> insertions(+), 0 deletions(-)
>  create mode 100755 t/7106-reset-sequence.sh

The name of the new test file should be "t7106-reset-sequence.sh" instead of
"7106-reset-sequence.sh".

> diff --git a/t/7106-reset-sequence.sh b/t/7106-reset-sequence.sh
> new file mode 100755
> index 0000000..4956caa
> --- /dev/null
> +++ b/t/7106-reset-sequence.sh

Thanks,
Christian.
