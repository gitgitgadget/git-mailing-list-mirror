From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] submodule deinit: require '--all' instead of '.' for all submodules
Date: Tue, 3 May 2016 16:02:27 -0700
Message-ID: <CAGZ79kaHs6TgxQpPUOKA7NQ8k0r80RrGg7aTtxN90FXwLBsVeA@mail.gmail.com>
References: <1462313499-6760-1-git-send-email-sbeller@google.com>
	<xmqqy47qkc87.fsf@gitster.mtv.corp.google.com>
	<CAGZ79ka8RQmNzzKJ9r_GsLkSCK5Thewsz9scZvwpJb0Pf_+NRg@mail.gmail.com>
	<xmqqoa8mkb4l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Per Cederqvist <cederp@opera.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 01:02:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axjKs-0004Ku-Cf
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 01:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834AbcECXC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 19:02:29 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:35355 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756824AbcECXC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 19:02:28 -0400
Received: by mail-io0-f178.google.com with SMTP id d62so37994816iof.2
        for <git@vger.kernel.org>; Tue, 03 May 2016 16:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=3C4apaKw5Qh6+M4zlqgJbt/2lRsqOc8/mv736Fo0zzM=;
        b=NboPdf+FOUaUinCsqOyS2CFzg+azC5IbT7M0MTlxYPKCiRtghndvDo1GPSF+VqXpNw
         Q8ehaPFzxTm7Ia/x+XXAkPnjUeswvZDiLV9buwO2CjX93Qy4chO1/SCHy+lrVqsAcKFB
         sg9oe3I3Pt11s7AqKNeGCVqweBxqR5Clm97O1J5rOq5uh8Bir7ce3VhfnyWlQuTFYbVK
         qYu3e47ajUiIEMuecR0vJZAuh9S2pm1+DH4zfSE6za9pFKNE+wTZAybme/epPtsLXIIX
         miYMUy09mpDAfe+CYesxuSM8TX/ZcDcy1+dv+2wbbYV7bLRfybegfLOONvmEYXJF0bIK
         Ex7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=3C4apaKw5Qh6+M4zlqgJbt/2lRsqOc8/mv736Fo0zzM=;
        b=RCEUc+dMTq17lwWJ0oadMasOZVlYe9YpSY6CyjdCJOVOKk9pI7HYgKCjEcwlvcEpGn
         /mQdDuv50AVxSCtXmI9sIT3hFEgQ+DbReKL7b4XqHUOALe7121hujlGsfQH5cJo27n0+
         fqhelFJE4N9lCL4lmfclgcSrfIQT5dvoNL5j18oWCpP/X1TDZs8bblXnkJRdsOiDumld
         nQUnRLVOngaGDPl9d83GbbQEzycquMCoVzaYR6uf7vsYdktu/kDl+vDNwJ8nJoef2ZX3
         6vwpoxkQRtew3lLOzsc0lyZyjsYCF6PEKFWdBqBbzD2JC2BOgwWPO5WZJUxIjF6fnDr1
         yqXA==
X-Gm-Message-State: AOPr4FXeNYjK9oyMf2AAjTaklkJ9MeTJ/E+lfxKeOxN+ORthLwQexcjMqJU0hcO5DLkcp36mHkspv0ISwQemvOcx
X-Received: by 10.107.161.68 with SMTP id k65mr7306838ioe.110.1462316547349;
 Tue, 03 May 2016 16:02:27 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 3 May 2016 16:02:27 -0700 (PDT)
In-Reply-To: <xmqqoa8mkb4l.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293477>

On Tue, May 3, 2016 at 3:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> So eventually (i.e. after the submodule groups lands)
>> "submodule deinit ." will start acting weird again?
>
> It would be nice if it never acts in a weird way, but that is all
> future development, not related to this fix, no?

Yes, just this patch is fine. Though lacking documentation.
I'll send an update.
