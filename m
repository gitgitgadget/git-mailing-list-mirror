From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/34] libify mailinfo and call it directly from am
Date: Tue, 20 Oct 2015 15:06:24 -0700
Message-ID: <xmqqd1w96vq7.fsf@gitster.mtv.corp.google.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-1-git-send-email-gitster@pobox.com>
	<xmqqh9ll6xo8.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYAW+T+sVz3c_q+P7brf6OvcQgeZEBnkM3U52vNYc0CqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 00:06:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zof3B-0006lJ-7W
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 00:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754037AbbJTWG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 18:06:29 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35531 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560AbbJTWG0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 18:06:26 -0400
Received: by pasz6 with SMTP id z6so33073592pas.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 15:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=zWPA+hVAZEhAI2JUOLXAKUlusmZDJG6wlpDsQ1WhMAA=;
        b=rCz4UT2yjASk+DdhABcjHCmmhQzOo+cNuCkl7/XsMYkwilEUF68vEgIkkSKn+OeuY8
         gyGsA1N7kRzvnx2kYOVLUGh5qA1bNbGqcX98cyKv/AkL0DsRtEJ/T76/dDzHNS1tIYVM
         4/gueQR3N2QwjkFgY29ZbhHeZbBWxgEFW3Svdm8W0BB0nTvP3oxQT4nSfpkeQ23oIpsT
         fNOgEh7YJsu0LffuCT0ERySKif/OkUX8s1zZFBt3W4tk9BMrRl7zb7sb/4bK5lSfn3Rf
         0x6iRsbQz2ldFTRWrdQz8zY9T5ZN6NqqYvyT1rrgckul/a8TfdE+icTpJZ8S4X/4oDLb
         pyaQ==
X-Received: by 10.66.221.104 with SMTP id qd8mr6517609pac.155.1445378786128;
        Tue, 20 Oct 2015 15:06:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f0a2:278f:6a7e:e323])
        by smtp.gmail.com with ESMTPSA id ug4sm5539788pac.11.2015.10.20.15.06.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Oct 2015 15:06:25 -0700 (PDT)
In-Reply-To: <CAGZ79kYAW+T+sVz3c_q+P7brf6OvcQgeZEBnkM3U52vNYc0CqA@mail.gmail.com>
	(Stefan Beller's message of "Tue, 20 Oct 2015 15:01:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279944>

Stefan Beller <sbeller@google.com> writes:

> As far as I understand, this only helps for mailing list workflows, which
> in my limited view of the world is only found in established infrastructure
> projects, who tend to be maintained by people who run some kind of
> ab-nomination of unix.
> ("Are there people in Windows land who heavily use the email workflow?")

Forgot that "am" is a workhorse behind "rebase"?
