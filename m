From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read-cache: fix indentation in read_index_from
Date: Mon, 31 Aug 2015 13:12:03 -0700
Message-ID: <xmqq613vusj0.fsf@gitster.mtv.corp.google.com>
References: <1441046609-24181-1-git-send-email-sbeller@google.com>
	<xmqqpp23uuhk.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbQmmcJMW=07A1pyHdbViJTfseG4L-kspKEvyugTO7R4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 22:12:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWVR6-0000yY-Ag
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 22:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751931AbbHaUMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 16:12:07 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33544 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbbHaUMG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 16:12:06 -0400
Received: by paczk9 with SMTP id zk9so1416855pac.0
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 13:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RGDlI7KX7jLZrEi/3rQvcxxP6hRnM2i7gs2j2KShdiY=;
        b=b93/mFVbDNcAbzOLh4EowasvXO7GlelqQfs6I1vivJYHBcvXXkR7bWJCtomhILBDLx
         y7b5iUbp3NkHWZSy4ZvEWwGDFGoh8pWDCqpsPhlCtmZl0Ub7zlDehPvmtRNnUfy4kVMk
         Szt37ryHg/F3ZUlf4lhtjg+CZi6OK9Km5SY8x2lUvpksWJ6a31zzDmIhS60HFOp0LmtZ
         qt85WUAqJbgBI1nIL2S8piFUyXW+4cEU3hhLaYWqoW6zizfwYr87rBWEaf1fZywjdpzH
         5vB8Rgg3XyoT9hhsCBS4u3UvSMbxOX5UnJCmRdzpPNpoa3aASWoG7QMG54VS87rsb6Ru
         tQCA==
X-Received: by 10.68.111.165 with SMTP id ij5mr39955956pbb.59.1441051925603;
        Mon, 31 Aug 2015 13:12:05 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id b9sm7178190pdl.47.2015.08.31.13.12.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 13:12:04 -0700 (PDT)
In-Reply-To: <CAGZ79kbQmmcJMW=07A1pyHdbViJTfseG4L-kspKEvyugTO7R4g@mail.gmail.com>
	(Stefan Beller's message of "Mon, 31 Aug 2015 12:34:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276933>

Stefan Beller <sbeller@google.com> writes:

>> I'll queue it for this time, but in general, I'd prefer if people
>> refrained from touching code only for style fixes in an area that is
>> touched actively in topics, unless it is done inside a topic that
>> has to touch that area of the code in order to do something more
>> than style fixes.
>
> Right. :(
>
> The problem here is that I was looking to use read_index_from
> in the submodule code to implement recursive actions, but as I
> could not find documentation on how to use it, I read the code.
> And whenever I see obvious things to fix (such as style),
> I cannot stop myself from shooting from the hip, sending a patch.
> I'll stop doing that.

Don't stop; instead queue and keep them on your own queue, so that
you can find a good time to send them out.

A good rule-of-thumb for "good time" is when "git diff maint pu"
does not show any overlap to the context and preimage of your
patches.

Thanks.
