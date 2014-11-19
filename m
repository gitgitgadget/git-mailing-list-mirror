From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 00/14] ref-transactions-reflog
Date: Wed, 19 Nov 2014 15:22:01 -0800
Message-ID: <CAGZ79kb3DOrL_txW-qxzd0=4sKrOiPTdSg-17_0+__wuj0TBaQ@mail.gmail.com>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>
	<546B2CE0.6020208@alum.mit.edu>
	<CAL=YDWn1x9TMGOWrmT5KMpQ_iBR0AQ5Ej1yr1pBb4==k0-vchw@mail.gmail.com>
	<546BA21C.9030803@alum.mit.edu>
	<xmqqr3x0uu81.fsf@gitster.dls.corp.google.com>
	<546BB722.5020901@alum.mit.edu>
	<xmqqsihgtcyx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 00:22:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrEZe-0006ks-5Z
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 00:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbaKSXWF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 18:22:05 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36491 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641AbaKSXWD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 18:22:03 -0500
Received: by mail-ig0-f176.google.com with SMTP id l13so4104287iga.3
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 15:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GDVnLhcuGJPTxUTF7MS/dRCuajH+F7QxDHcmpzy3SEY=;
        b=Yr26ZwvBIjANIVPYTsMVowWqXLN6l04u7vVuzZpQ8LC/n3wqvnbYOWl4iwon/h7rF8
         dVPwjTSBvTk5sRPbx+3wn8ApxKbhCcb/Yq/iqb6Yc29VgQWqo95zmyVirPo5Te12U9gP
         E423d9Q/bPzAcIW/TUutmMQmFQZVkaVz6xAIehaYWchz/2CEpCAmY4Sut+BBe95YAt+2
         dKRfc9/pXVMb1QzgU2gPve8dZgwczjuN6ofsQePLi6lLiHMt0Q0Lek13dioEWWbeydzo
         VH1mfRaOhLfSy8oPBtZi5N2kjXI08MSB+H/auGGOl5uY5e0PNJTTB76fa0N5wZNsITPe
         Ta1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=GDVnLhcuGJPTxUTF7MS/dRCuajH+F7QxDHcmpzy3SEY=;
        b=LfXAv/W165JrWaVq5aEQr8U6FC/Rpiz8bsvWmr91O+O/t6QNVU4nJpn3qQs4/lv/oF
         nu3ITNVnG1qeMLcjStxHKCErfjIBaZWbrR7nPICdsJe0dDiNxgPMp6oiHi9Jc6TIF0c8
         oJTNho5N2zKZ06Bz1IYiwZbAnNDjZQDQoTUeiBdrU37+KB7VBIc1qNa1nQu/bspAatZo
         OftJrx7ksiauSfgKI75BLRTZoDp+mC1Ig9tEc7NeMVnJ0P80otzS4CgbqOtRvqgagzkH
         6DR3bGkwXWe3QzidjLU3D3+S+LAPOFrqSM90en6rouQ3nKiFR/M2xOonj7dGV+q4fZ7X
         GlVA==
X-Gm-Message-State: ALoCoQmrViLdXXDRvif2HgsdwfLk05YRX+Tj8/6RBAB9g6ugm8jjbBNN/XDXGEAclQV5dc1CiO9b
X-Received: by 10.43.119.131 with SMTP id fu3mr3507830icc.56.1416439321848;
 Wed, 19 Nov 2014 15:22:01 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Wed, 19 Nov 2014 15:22:01 -0800 (PST)
In-Reply-To: <xmqqsihgtcyx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the long delay.
Thanks for the explanation and discussion.

So do I understand it right, that you are not opposing
the introduction of "everything should go through transactions"
but rather the detail and abstraction level of the API?

So starting from Michaels proposal in the first response:

1. Add a reflog entry when a reference is updated in a transaction.

ok

2. Rename a reflog file when the corresponding reference is renamed.

This should happen within the same transaction as the reference is
renamed, right?
So we don't have a multistep process here, which may abort in between having the
reference updated and a broken reflog or vice versa. We want to either
have both
the ref and the reflog updated or neither.

3. Delete the reflog when the corresponding reference is deleted [1].

also as one transaction?

4. Configure a reference to be reflogged.
5. Configure a reference to not be reflogged anymore and delete any
   existing reflog.

Why do we need 4 and 5 here? Wouldn't all refs be reflog by default and
why do I want to exclude some?

6. Selectively expire old reflog entries, e.g., based on their age.

This is the maintenance operation, which you were talking about.
In my vision, this also should go into one transaction. So you have the
business logic figuring out all the changes ("drop reflog entry a b and d")
and within one transaction we can perform all of the changes.

Thanks,
Stefan


On Tue, Nov 18, 2014 at 1:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>>> Sorry, but I lost track---which one is inside and which one is
>>> outside?
>>
>> By "inside" I mean the code that would be within the reference-handling
>> library if we had such a thing; i.e., implemented in refs.c. By
>> "outside" I mean in the code that calls the library; in this case the
>> "outside" code would live in builtin/reflog.c.
>>
>> In other words, I'd prefer the "outside" code in builtin/reflog.c to
>> look vaguely like
>>
>>     expire_reflogs_for_me_please(refname,
>>                                  should_expire_cb, cbdata, flags)
>>
>> rather than
>> ... (written as a client of the ref API) ...
>
> OK, I very much agree with that.
