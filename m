From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 2/2] Mention "git blame" improvements in release notes
Date: Mon, 28 Apr 2014 13:05:28 -0700
Message-ID: <CAL=YDW=iTQz-S+ZByZnVhrpebPgZxq6p46MC2yqW-HF3eVw+2g@mail.gmail.com>
References: <1398470210-28746-1-git-send-email-dak@gnu.org>
	<1398470210-28746-2-git-send-email-dak@gnu.org>
	<7vmwf8huey.fsf@alter.siamese.dyndns.org>
	<87zjj86j4a.fsf@fencepost.gnu.org>
	<xmqqzjj5s8hs.fsf@gitster.dls.corp.google.com>
	<87y4yp4ame.fsf@fencepost.gnu.org>
	<xmqq38gxqmc9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Kastrup <dak@gnu.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 22:05:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wero2-000679-VV
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 22:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932964AbaD1UFc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 16:05:32 -0400
Received: from mail-vc0-f182.google.com ([209.85.220.182]:43405 "EHLO
	mail-vc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932284AbaD1UFa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 16:05:30 -0400
Received: by mail-vc0-f182.google.com with SMTP id lf12so6435939vcb.41
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 13:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rHde7gLxn3y9Sj3SSNnhq0gIrns5bI/0FnaJ3kJsOu0=;
        b=LXOZvlXOFj13D+hr4rSTK5cEhEG3bixmEKRGsZuloiX99MfdFvpSWa4qYIynYA6gl3
         x03iWusYmHgPK2tI0eliUzqvk1S5fUTHfzG8+GS+Pa9BCtyKA0O1+p15xkTHolM0246A
         8fXPV+BI0YyrCglBgFSyER2Qyf/qFzKu0Cl8zRltchuOCs16q69H/p4QCA03xCvmcpGa
         G8KdwSul3fYJX07i0qMdd8168JIgdpENkHTAlC3nfdn/nD+QMOthih1CXjeQGmzqcS9T
         6Mui5odkUkB5ivGfleGnEctbGZD06IsLog5ZtujDbjOcCraz5Z6mQgqBenCD/YIz7mfn
         sakw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=rHde7gLxn3y9Sj3SSNnhq0gIrns5bI/0FnaJ3kJsOu0=;
        b=g0KPwOhND6FwZQGZvcNhFL2P0Jjy7mvo31+hVMqlv3AFKmbA077u+Ngo7VilavsZdB
         Oz+0rGrlQ7bxwgV9LxyMN7aoFUi6cFYdegZu9arog95mlkVg6XlqC2eEdBhU5QGlm61X
         2IbqUP7zVsNfExGsFw5e/pX3tSR7dR+A5TGZaHL6lJMXnfo35n4I1Nm60IDtOJot7dm/
         9AeVH13BJXLCINHqM1HY03thCbDDq/eNk5EuRFLtxWUCuz5QJ4x1EZSN6mHxrFRAOnBs
         K+9nAZwIleHw5cHEqaHfapAwd7oRWpDBlO+hzIE3k4o8PtgjxW1Ae/KY2qQ5DzUuIQmr
         boMw==
X-Gm-Message-State: ALoCoQnnEiHOR/QJGzi1r0UMdnbyx0CnuR/LXiuSKmGlSHNDJdrCni0ftjs3IgCfWC9V0PupaB/U/cS8L0OlMV68MFouVUZphUUw0aNWaZ3zpzpMbJOvEMcyBP0EBRaUXIRqMl6bjV7hzLyc9R7sgZ/kylCUQhZ7nWRH41ixIEvF7AKFI6AT/sK3QyNb3/wx6+jBi5ArT2k+
X-Received: by 10.58.202.133 with SMTP id ki5mr24596167vec.19.1398715528948;
 Mon, 28 Apr 2014 13:05:28 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Mon, 28 Apr 2014 13:05:28 -0700 (PDT)
In-Reply-To: <xmqq38gxqmc9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247435>

On Mon, Apr 28, 2014 at 12:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Kastrup <dak@gnu.org> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> But still, I am not convinced that the release notes is a good place
>>> to do this, and would be happier if you can think of a better venue.
>>
>> "This change has been contributed by an independent developer on a
>> contingency base.  To make this approach work, please contact him if you
>> consider it worth recompensating."
>
> I write things under three personalities.  As just one of the people
> active in the Git development community, as the maintainer of the
> project, and saying things on behalf of "the Git project".
>
> The distinction between the latter two may be subtle, but it matters
> to me.  And in my mind, I write the Release Notes on behalf of the
> project.
>
>  * The performance of "git blame" has been greatly improved.  Thanks
>    David Kastrup for his huge effort.
>
> is perhaps as far as I can go in that capacity, without singling out
> one contributor among 80+ contributors with changes between 1.9 and
> 2.0 (among which a dozen or so have more than 10 patches---some are
> trivial and patch count alone does not do justice, though) with
> similar "pay them to show your appreciation" pleas.
>
> I however feel that I can certainly do that as an active (and highly
> visible) contributor, and even as the maintainer.
>
> I guess we probably can add "See $URL if you are interested in his
> further plans" after that two-line item and let you write whatever
> you want at that page pointed at by the URL, though.
>

Some projects, for example samba, provide a dedicated page on the
project web site
where vendors, and I think individuals, that provide services can list
their information :

http://www.samba.org/samba/support/

Would this perhaps be a better solution?


> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
