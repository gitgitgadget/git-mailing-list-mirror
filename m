From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 5/5] help: respect new common command grouping
Date: Thu, 21 May 2015 12:46:53 -0400
Message-ID: <CAPig+cT65MpPYaE4BxajMNU2N=rf6QQzsxDsc7fV-_GMPVcdhw@mail.gmail.com>
References: <1432213989-3932-1-git-send-email-sebastien.guimmara@gmail.com>
	<1432213989-3932-6-git-send-email-sebastien.guimmara@gmail.com>
	<CAPig+cRX9_1h4W6sWxb22FF3Hwgqx2f=hK=tQkfTUdkTJiQo-w@mail.gmail.com>
	<xmqqiobllxdk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 18:47:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvTcc-0000Yn-LR
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 18:47:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757033AbbEUQq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 12:46:57 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:36839 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755551AbbEUQqy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 12:46:54 -0400
Received: by iepj10 with SMTP id j10so12632839iep.3
        for <git@vger.kernel.org>; Thu, 21 May 2015 09:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=91dmjsa+d3WM6GQVF2eQcc6WCXmiQk9GhkhFOVKojZ0=;
        b=EUA/xL5Uw1BClLUgElAg1eDYY6HEpwqjgMSVNcu4IqyXh9siwCAtT2rSQStIUqKrTQ
         5eluugtrhFyoriQYYkf62SOk15XDmvqcbDcEAJN2PfIa/HI1xmaFUQJHXuyCIpnXwSny
         gCQX1XhdZW53eWPRtFklIdTVYQipb7VM1eo4EygCop4nzS1X6TiF4DxDXh0PlB2HBC/i
         pgYRVQ6Ee/ylC5EPlEytKNo0r9jCmAOKkSBh0rifmZ6EnS531+ARmEIjOmWFq6lR/oIA
         Uco8HtDrGKXxIhAg6Iaz9TXw97RBZKKDjyZu3sJvIbLQsO5xBW5EoHWKxXMqAX/afGgO
         qdEQ==
X-Received: by 10.50.138.70 with SMTP id qo6mr6029142igb.15.1432226813817;
 Thu, 21 May 2015 09:46:53 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 21 May 2015 09:46:53 -0700 (PDT)
In-Reply-To: <xmqqiobllxdk.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 8W5LNkEiiQuEOzugrGg4LDjAsXY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269609>

On Thu, May 21, 2015 at 12:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> +       puts(_("These are common Git commands used in various situations:"));
>>
>> The clause "in various situations" is quite nebulous and thus adds no
>> substance.
>
> FWIW I view the latter half of that sentence as explaining the group
> labels which we did not have (so we did not have to mention in the
> original).

Hmm, but is it necessary to explain the group labels in the first
place? The help output (group labels and all) seems self-explanatory
already, and one would expect (hope) that readers are intelligent
enough to understand implicitly that the group labels are a simple
organizational aid. If that understanding is indeed implicit, then
there should be no need to declare it explicitly and "in various
situations" becomes mere noise.

> Perhaps swapping the order may clarify, as the list
> itself is a two-level, i.e. list of workflow elements, each of which
> has list of commands?

Perhaps, but I may not be the best judge of that since, to me, that
level of hand-holding seems unnecessary.

Anyhow, it's just a minor observation, and it's something people can
argue later if they feel strongly about it, so I don't think it should
hold up this patch series.
