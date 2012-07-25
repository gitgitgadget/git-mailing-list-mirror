From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/5] difftool: Simplify print_tool_help()
Date: Tue, 24 Jul 2012 20:00:55 -0700
Message-ID: <CAJDDKr6=t5bstW9fGxJd7imNkCt47=159_AnNtDPE9U_6f9Jug@mail.gmail.com>
References: <1343014940-16439-1-git-send-email-davvid@gmail.com>
	<CAFouetjhGChULHa-Ax9oR--TccyEBnqn=UATbMpJxcdm3AOE1w@mail.gmail.com>
	<CAJDDKr47F9ZAPPCnFBdPYhQsx8qGGggHHrFWeZw2zpf-mukq5w@mail.gmail.com>
	<CAJDDKr6JcbKkvg-9M6Sf4i0+YrMFJeKhmVoxQ_g1QBCRnoGRxw@mail.gmail.com>
	<7v629cef6h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Tim Henigan <tim.henigan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 05:01:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StrqP-0002rL-Gw
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 05:01:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755877Ab2GYDA5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 23:00:57 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:53399 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755608Ab2GYDA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 23:00:56 -0400
Received: by vcbfk26 with SMTP id fk26so203970vcb.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 20:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=n3POZkRDoJC2luIeVCriJemCh8wATzCQMLYifHH/cks=;
        b=jImYgeH8IfgIno0he37mGplcrgAOq8WsXl270j3thBP53A5l9kKhmRcJPlf+kSNRJU
         dN4d/Do9HTRPjGoqLDdUFTyo2fgtuzV/COMhvAyqC4ZgDJcyOtqAmukEcpne0xd7A1Ay
         LdESNDlUzL4rNfhwuVLbj2BkEGzll6LIxFFzQmccO7rd4mWk20icc215CJWnd5rFuy14
         7N7DKz+q58IIc39pZ+W4mtQrq9R6oOkLrXFHigkPSojbzu4n+YjHhy49n0yUk39kt5JN
         nu7A7ClaY45k+9wC/afkmiXb00CTPc7Y8lOD3Ep/Q+FBN7zS3HPq4lRAX5Sod7t8UtBZ
         +tUg==
Received: by 10.220.148.210 with SMTP id q18mr16966252vcv.6.1343185255380;
 Tue, 24 Jul 2012 20:00:55 -0700 (PDT)
Received: by 10.52.114.67 with HTTP; Tue, 24 Jul 2012 20:00:55 -0700 (PDT)
In-Reply-To: <7v629cef6h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202100>

On Tue, Jul 24, 2012 at 7:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>>>> Does this implementation handle that case?  I'm sorry, but I haven't
>>>> had time to apply and test myself.
>>>>
>>>> [1]: http://thread.gmane.org/gmane.comp.version-control.git/193233/focus=193925
>>>> [2]: http://thread.gmane.org/gmane.comp.version-control.git/194158
>>>
>>> Good catch.  Eliminating the globals should be the goal, then.
>>> I'll have to re-roll.
>>
>> Junio, would you prefer follow-up patches or a rebased series?
>
> Incremental patches, please.
>
> Thanks.

Okay, I saw this just before hitting send-email (and sent the whole series).

I'll prep the incremental ones shortly, so please ignore the one I just sent...
-- 
David
