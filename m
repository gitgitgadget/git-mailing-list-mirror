From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] commit: fix ending newline for template files
Date: Thu, 28 May 2015 14:35:22 -0400
Message-ID: <CAPig+cR=Mrgb+-ZZcM6m7AcL25gXYtmEVpO3c23k_UKXPgyQnA@mail.gmail.com>
References: <1432620908-16071-1-git-send-email-patryk.obara@gmail.com>
	<1432620908-16071-3-git-send-email-patryk.obara@gmail.com>
	<CAPig+cTt5sQ=49qS2+8ZOtiX61kHjAisAvpP7K3XPhtNtCatOg@mail.gmail.com>
	<xmqqpp5kh8a0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Patryk Obara <patryk.obara@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 20:35:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy2eN-0007IG-SK
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 20:35:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752606AbbE1SfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 14:35:24 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:35249 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbbE1SfW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 14:35:22 -0400
Received: by igbyr2 with SMTP id yr2so119919851igb.0
        for <git@vger.kernel.org>; Thu, 28 May 2015 11:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=19yUjt7DRFIuLll33qHBeNmsi+yQSZos/tBUlsbVcpM=;
        b=FC0vrL9bYFwhxr4C9xRtB0Fbhga6n4ITnmY4LOgXtbs05FOH/wa8ooprjUu+sYGVao
         QMtmG/uZaBJ90XsLRX3Mg+pEapd8z+5KNbI1zb7jP2+wiCEQ2p29NQwoPRtF5Fb/JNLg
         2boNbuj7d8bPnyS9GZrFIDMcmxFgtzA+pcDOhdlAYu/YTh8EPYwqeczjmzB1i8p51R+f
         eX5OqLS9C8vulr2JoDza5DxiT4xLJK7AwaTvQBKBciv6qsu/B8riEyKAsOJ267VSbfz9
         6oJOkCXYjE7Dqc7QFmE+Th2qy56WEvdCyRN+pj6OmqXeuJCRk+Q+XBfhA6ZwemHwj1fj
         zD4w==
X-Received: by 10.43.135.5 with SMTP id ie5mr11176267icc.78.1432838122186;
 Thu, 28 May 2015 11:35:22 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 28 May 2015 11:35:22 -0700 (PDT)
In-Reply-To: <xmqqpp5kh8a0.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: OA21pdKFgjSv74aB-c3XcrPZ3j8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270177>

On Thu, May 28, 2015 at 2:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> Moreover, it lacks justification and explanation of why you consider
>> the cleanup unnecessary. History [1] indicates that its application to
>> -F but not -t was intentional.
>>
>> [1]: bc92377 (commit: fix ending newline for template files, 2015-05-26)
>
> Sorry, but the date of that commit seems to be too new to be
> considered "history"; I do not seem to have it, either.

Indeed, I somehow botched that. I meant: 8b1ae67 (Do not strip empty
lines / trailing spaces from a commit message template, 2011-05-08)

> But I agree with you that I too failed to see why this change is
> necessary or desirable in the explanation in the proposed log
> message.
