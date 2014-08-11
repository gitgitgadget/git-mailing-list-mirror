From: Alexander Shopov <ash@kambanaria.org>
Subject: Re: [PATCH] Fixing unclear messages
Date: Mon, 11 Aug 2014 23:04:37 +0300
Message-ID: <CAP6f5MnqjG-M=Po0ZLcw+DiXKQxzyC4gGeVpWHtjqJyOmNe-zw@mail.gmail.com>
References: <1407683607-4143-1-git-send-email-ash@kambanaria.org>
	<1407683607-4143-2-git-send-email-ash@kambanaria.org>
	<xmqqsil37v4i.fsf@gitster.dls.corp.google.com>
	<CAP6f5MmE4ae81DZu-gbaax4nSh4WMcWCk453wJBfC4mKvmsfxA@mail.gmail.com>
	<xmqqha1i7uqn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexander Shopov <ash@kambanaria.org>, git@vger.kernel.org,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	jn.avila@free.fr, Xin Jiang <worldhello.net@gmail.com>,
	Marco Paolone <marcopaolone@gmail.com>,
	Marco Sousa <marcomsousa@gmail.com>, peter@softwolves.pp.se,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 22:04:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGvpi-0002LG-BP
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 22:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbaHKUEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 16:04:39 -0400
Received: from mail-qc0-f179.google.com ([209.85.216.179]:36693 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752825AbaHKUEi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 16:04:38 -0400
Received: by mail-qc0-f179.google.com with SMTP id m20so1963936qcx.38
        for <git@vger.kernel.org>; Mon, 11 Aug 2014 13:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vABP10b4YhELxVAPxuwXi96xDs/MYTiIRXYKnOnkStY=;
        b=FFxTw01VLPDYaWdmAIV9Uo/zPk4Oufk5zDhsz8/IHJ1/jBvFv+lmFOU5wLaDg8P/MV
         NcxiiiOCkbMjtjeuzAnavrcNw6YKfDaZxMI4aLbz6B0v5rPMM8EL69Q+mV9W28r7by8Z
         5tGskcw3bL/mY22UcL/CVLw9xWtBkuZNANDMtNeVfeBX/nf1hisGO3+vn8MwEO7HVNXB
         dq7Sg3ohbl9r2sHaOUiF6A2gh6DGVdUj2rpb4gGJOlQPR//Z4+Sf/FLUju95svYjJSBp
         J/reQsFYf/hmNYlDWezFCygkMUZuxHdqAcMC4laqyIGfU8J++0JWh+ncbjfJZ4tcDo4i
         9crA==
X-Gm-Message-State: ALoCoQk5HY3fw9JssH6VocMUGSey3n5A4JMvEpuKsDHFiuWA5sWtgOXxOeE1P1C6QaS+7VpuLuSZ
X-Received: by 10.224.167.193 with SMTP id r1mr18828qay.62.1407787477436; Mon,
 11 Aug 2014 13:04:37 -0700 (PDT)
Received: by 10.140.93.6 with HTTP; Mon, 11 Aug 2014 13:04:37 -0700 (PDT)
X-Originating-IP: [78.83.52.173]
In-Reply-To: <xmqqha1i7uqn.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255137>

> If there were something else "Huh?" could mean after you
> give a response to that prompt, but I do not think there is.
OK, you love your "Huh"s. Good for you. I cannot find a convincing
argument then.

> If I were asked to say what it is then, I would say "it reassures".
It is like a jewel you find in a quest? On the other hand you say the
message is rare enough and shown too late to be useful so there is
little gain to change it. OK, fair enough.

> Yes, I see the primary value of this thread was to trigger that
> suggestion to classify which die()s are BUG()s.
Wonderful.

> Because I've never imagined anybody would sensibly expect "mv a1...
>... your rewrite here is definitely a good one in that sense.
My experience shows that messages need to be as helpful as possible
even at the cost of some repetition.

> FWIW, I see it as a feature to have small number of messages phrased
> in colourful ways, especially the ones that do not require reaction
I really do not know what to say. People can be color-blind even for
messages plus in-jokes frequently do not travel well across languages.
Sharing my experience: the messages were hard to translate because
they were hard to understand.
I had to follow the code in order to understand their meaning and
usage. Hopefully other users of git will be more clever than me.
I did my best at improving the messages but as you do not perceive it
the same way there would be no sense in continuing the discussion much
longer.

Will you reconsider:
- ???
+ unknown state
Recoding problems with translations, settings of console sometimes
lead to missing or wrongly encoded characters to show as '?'. Three
'?' can be confusing when shown in translation.

> We obviously do not want to overdo it, but the ones we have are all old ones.
You overdid it for me. On the positive side I hope I have listed all
oldies but goldies and next changes will be less touchy.

Do you want me redoing this patch or not at all?

Kind regards:
al_shopov
