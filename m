From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/1] Makefile: link libcurl before libssl
Date: Wed, 21 Oct 2015 09:52:05 -0700
Message-ID: <xmqqy4ew5fm2.fsf@gitster.mtv.corp.google.com>
References: <1444073043-24618-1-git-send-email-repk@triplefau.lt>
	<20151005194134.GD11993@google.com> <20151005201619.GA386@cruxbox>
	<xmqqsi5570n1.fsf@gitster.mtv.corp.google.com>
	<20151021164406.GC13308@cruxbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>, Jeff King <peff@peff.net>
To: Remi Pommarel <repk@triplefau.lt>
X-From: git-owner@vger.kernel.org Wed Oct 21 18:52:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zowco-0002N0-N6
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 18:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210AbbJUQwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 12:52:11 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33938 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843AbbJUQwH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2015 12:52:07 -0400
Received: by padhk11 with SMTP id hk11so59673889pad.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 09:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=a+h9HLSscaFWsgfzztUObY/560Jp/IkUqOfcTSpcCQI=;
        b=KV7xPLDQQzEGsHSucFI2FlafjVD78j3kaKeCox/mCpLri7m/wLCrrFG/FeteKspqhg
         bVf+kegQPNbKtDTjXUIHF3k0ZOpWpZcnkwgJsN7zW55+q/62Ls0EDASCB/F4lG2pIBCU
         /t02pnAiLiUiGFIQlwAeAhnoyQ+9fa/rzDHTqNn+UrzmTirk8LmRcdyQ58QhTbRW1vwi
         cukAM70o73T74DUY6GTkUrUNZh4rwkN4kbrXOsZRFJc11C9Iuev7QB8CxaL5AKR2F/si
         +as1LWxiI1Z+aqLAFJYbuGYqA+K8A+4XdgqDEKJghwdxYrkm0uO9RMG2lz2kByqgC6xa
         ijUA==
X-Received: by 10.68.201.33 with SMTP id jx1mr11498048pbc.75.1445446326902;
        Wed, 21 Oct 2015 09:52:06 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f0a2:278f:6a7e:e323])
        by smtp.gmail.com with ESMTPSA id tj2sm10082486pab.4.2015.10.21.09.52.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 21 Oct 2015 09:52:06 -0700 (PDT)
In-Reply-To: <20151021164406.GC13308@cruxbox> (Remi Pommarel's message of
	"Wed, 21 Oct 2015 18:44:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279990>

Remi Pommarel <repk@triplefau.lt> writes:

> On Tue, Oct 20, 2015 at 01:20:18PM -0700, Junio C Hamano wrote:
>> 
>> So, what's the status of this patch and other two patches (I
>> consider them as a three-patch series)?
>
> So I have to fix the non initialized variable and to rephrase a litle
> bit the description for this patch. Taking libssl as an example is
> misleading, zlib is more appropriate. I'll resend another version shortly.
>
> For patch "[PATCH v3 1/1] Makefile: make curl-config path configurable"
> it has been reviewed by Jonathan Nieder with a litle modification to be
> squashed in. I can resend a squashed in version if it is easier for you.

Yes, please.

> Sorry for the delay.

No need to say sorry; people do their part at their own pace and
that is perfectly fine.  I just wanted to make sure that some sign
of this topic not being forgotten would stay as I expunge older
messages from my mailbox ;-)

Thanks.
