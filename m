From: Joseph Leong <josephcleong@gmail.com>
Subject: Re: Confirm my false error suspicions of Gitweb query injection
Date: Mon, 10 Sep 2012 10:41:35 -0700
Message-ID: <CAMOg_eUVm08jQSNR1F1iU3Och-Lk07p=vWpkuUz7iZWpi4cEfg@mail.gmail.com>
References: <CAMOg_eUjmnisevN+AaArz+6TMpWYJL660xwG0ptEaTO7stcL6A@mail.gmail.com>
	<7vlighok2h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 19:41:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB7zU-0004XL-SB
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 19:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339Ab2IJRlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 13:41:37 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:39517 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab2IJRlg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 13:41:36 -0400
Received: by vcbfy27 with SMTP id fy27so1687423vcb.19
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 10:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WOBThFteikYPV1LZC4xVqEgdgghTcxAF8JUSxhx6afY=;
        b=t0x94vwtqHbt1r9oM/sEVd4stPd9302ZeyA4mkDT2J7OK8HAfxr1agvkAsPbCKJjCo
         PHNRVu340DNb1cNP1oXSUnToF9/NWXIFLrB+EzTUTKXwwURvN9Ckn7kcgRHNk0zsO72U
         7H9XNM+k472sTLVglYu0LuusJwH/zOzf9VCwSlyS4Kl9nCQK6yzzsrTLi3dZrCaHy/S0
         zeq8hdEcuQSVdtbaZVbpIn3el5XCm0l/4HXPWIAhdPIoApf2JLxfdIrDsU3WQLtOz7c+
         UdEVfZx68J+I/i0HfZyew9e3HpUv89ab4SCoMGn4bz3uF0G7HXYqD05DFWZbyalxauNN
         HHFA==
Received: by 10.58.4.33 with SMTP id h1mr22813290veh.38.1347298895979; Mon, 10
 Sep 2012 10:41:35 -0700 (PDT)
Received: by 10.220.207.220 with HTTP; Mon, 10 Sep 2012 10:41:35 -0700 (PDT)
In-Reply-To: <7vlighok2h.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205154>

and you earned bonus points for the details - thank you very much!


On Mon, Sep 10, 2012 at 10:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Joseph Leong <josephcleong@gmail.com> writes:
>
>> Hi Everyone,
>>
>> I'm using Gitweb (Based on Git 1.7.9 on RHEL 5.8).
>>
>> I was poking around and tried a GET Request (REQ) with some SQL
>> statements as a search query and noticed a 500. Can i just confirm
>> with anyone here that the error message I'm seeing in the Response
>> (RESP) is basically saying that the search parameters are invalid
>> because of it's funny chars are breaking the regex search and that
>> it's not anything database related.
>
> Yes, I think this was fixed in v1.7.9.4 if not earlier, with e65ceb6
> (gitweb: Fix fixed string (non-regexp) project search, 2012-03-02).
>
