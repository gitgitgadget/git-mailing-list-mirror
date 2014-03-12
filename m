From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [PATCH] rev-parse --parseopt: option argument name hints
Date: Wed, 12 Mar 2014 00:26:18 -0700
Message-ID: <53200C1A.7070002@gmail.com>
References: <1393842740-4628-1-git-send-email-ilya.bobyr@gmail.com>	<xmqqwqg9kbuk.fsf@gitster.dls.corp.google.com>	<531D51EC.6050503@gmail.com>	<xmqqk3c1rfqj.fsf@gitster.dls.corp.google.com> <xmqq7g80r1pm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 08:26:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNdYi-0003bd-Ux
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 08:26:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756496AbaCLH0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 03:26:33 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:56513 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756211AbaCLH0c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 03:26:32 -0400
Received: by mail-pb0-f45.google.com with SMTP id uo5so706794pbc.32
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 00:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=xhzhbVLkBScyxA9qYqBRpBBgItRzaOVc155RNeBv1TE=;
        b=KQck6IqWgb6kzO1gRPLYccyqeQW3h1oi4X/2RpHBNe7HZWM74xsOvKlN+evH2WhTS5
         cH+W0ZC4JFLoO6uREYfZCHxtIwJybqlI5DTMr5qtJejzgRzY/jnxQrTgYanXjBu/xzJB
         M51mABAQcp8WwEJDzNz6f9CrnFG5W1n2TtdnJhAPcPNDkhgIk1R/Bp8oJC7oTSb3tv16
         zQRsiHI5vUbcrKSo9ok2kKW6L/mopnuWii9FhbNf7WZYx//iHgNuMzXnVv/Q7CROfjvn
         yyKufO0cb7bC06/lsck36YkGp6yWuouI78jaP/n9SQtGpKI6H1WUergL9F308uc7vp2x
         yPDA==
X-Received: by 10.68.190.228 with SMTP id gt4mr3067180pbc.94.1394609191766;
        Wed, 12 Mar 2014 00:26:31 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id ns7sm4172950pbc.32.2014.03.12.00.26.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Mar 2014 00:26:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Thunderbird/28.0
In-Reply-To: <xmqq7g80r1pm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243924>

On 3/11/2014 12:10 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>>> Documentation on the whole argument parsing is quite short, so, I
>>> though, adding an example just to show how usage is generated would
>>> look like I am trying to make this feature look important than it is
>>> :)
>> You already are by saying the "Angle brackets are automatic", aren't
>> you?
> That is, among the things --parseopt mode does, the above stresses
> what happens _only_ when it emits help text for items that use this
> feature.

`argh' is used only while help text is generated.  So, there seems to be 
no way around it :)
I was talking not about the automatic addition of angle brackets, but 
about the documentation on `argh' in general.
The section where I've added a paragraph, is not specific to the help 
output, but describes --parseopt.
I though that an example just to describe `argh' while useful would look 
a bit disproportional, compared to the amount of text on --parseopt.

But now that I've added a "Usage text" section to looks quite in place.

I just realized that the second patch I sent did not contain the 
changes.  Sorry about - I will resend it.

I was also wondering about the possible next step(s).
If you like the patch will you just take it from the maillist and it 
would appear in the next "What's cooking in git.git"?
Or the process is different?
