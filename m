From: Kevin Wern <kevin.m.wern@gmail.com>
Subject: Re: Resumable clone
Date: Tue, 8 Mar 2016 18:04:50 -0800
Message-ID: <CANtyZjRw57kru=7RvF1Q+uTsoF+0YKynA2Y0FQYK5PBFxSoPNQ@mail.gmail.com>
References: <CANtyZjSJf5_xbsBC5tUaazFT3uiEgJnx2_kHLwYwKcn50Jy_qg@mail.gmail.com>
	<CACsJy8CESL6vH22mGSLRE1OKTEbGz2Vqmsv5bY3mn_E+03wADw@mail.gmail.com>
	<xmqqoaasvkrt.fsf@gitster.mtv.corp.google.com>
	<CANtyZjRZzXabeWEhwCrwN_q_Zsrm1f_d+j2uDhTZeEjv3LjxaA@mail.gmail.com>
	<xmqq4mcgnbkb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 03:05:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adTUk-0000Yg-HI
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 03:05:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751893AbcCICEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 21:04:53 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36322 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbcCICEv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 21:04:51 -0500
Received: by mail-oi0-f45.google.com with SMTP id r187so25115274oih.3
        for <git@vger.kernel.org>; Tue, 08 Mar 2016 18:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ImGu4+EOida/aLL3qlrXn4ODDCXgmw3gfjbLliRAlBM=;
        b=eYSOTICOVw0NrJm2SNXyrulMZJd0IeWln9p11ba9E75aRpWQg7NyXi66xFEOXQ+RSN
         wjaVXDfJC+P56YhPL7gxIbGKvAAgrbmfeMR0g9UhpdAlAhqdHWi01l/KDoQ/YsHLOJkF
         q3mFNgXtaLpKNsloZusLofz7KC3msxojga2kjUgFzf1KqRtdQ6iMGIjWyOntqkwwxa8W
         OSHxC8ZBYdIFpgLiQkpjiUW00U7KTSgGbPlYPgUbwgBl2lAEoo64zT7yrBGgkK3T3pw2
         cUmDn6oYiI4sEJP+cJlWoJc39e9p9VeCGbxccK93iVZIh9o8tZfO2sKMDDJrtiLlRlOs
         CSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ImGu4+EOida/aLL3qlrXn4ODDCXgmw3gfjbLliRAlBM=;
        b=RHZ7jq0QjvkNRqENHTATv1FUqdewADaMa+AaQxPVbDFPGgskWKCUgvqqHgC5gp3bup
         DiapFpFmWxxQbeWGUegMavgrf2RY3nAosvNrOo0Y8SNYhaeimCiJjP4OTrlzVr10gIWr
         SOilcELiBFAuE7EQM+HeqKeBiAPoH+vdiVjJItSeVxFXd5QuK3+amikYUcdbkoSfyRDj
         1EnOHRkpLOJJEalEU/aCjQO9kf8O3pZho0Jk01LrbJwW3NdUH7lbcPivrzRKJmTOTZf5
         PIF6g3ElICoj4NN0B587w0X/Lo2YoLnMLtyDiBsXL9qBNy5kLkztQ/O7NVYeN64ymmL3
         CRKA==
X-Gm-Message-State: AD7BkJJhG5OZ5g8th71okQ+97UidxsEv9aYk37B7yHZwlneY+ZTeOtZy2CS1D1QarmtJIU1XKjA3BDz7+reFWg==
X-Received: by 10.202.81.5 with SMTP id f5mr16568319oib.129.1457489090818;
 Tue, 08 Mar 2016 18:04:50 -0800 (PST)
Received: by 10.202.206.11 with HTTP; Tue, 8 Mar 2016 18:04:50 -0800 (PST)
In-Reply-To: <xmqq4mcgnbkb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288471>

Junio,

> Yes, that is very close to what I said in the "what remains?"
> section, but with a crucial difference in a detail.  Perhaps reading
> the message you are respoinding to again more carefully will clear
> the confusion.  This is what we want to allow the server to say
> (from the message you are responding to, but rephrased slightly,
> hoping that it would help unconfuse you):
>
>     I prefer not to serve a full clone to you in the usual route if
>     I can avoid it.  You can help me by populate your history first
>     with something else (which would bring you to a state as if you
>     cloned potentially a bit older version of me) and then coming
>     back to me for an additional fetch to complete the history.
>
> That "something else" does not have to be, and is not expected to
> be, the "full" history of the current state.  As long as it can be
> used to bring the cloner to a reasonably recent state, sufficient to
> make a follow up incremental fetch inexpesive enough, it is
> appropriate.

Sorry, I was thrown off by:

> - the type of resource, if we want this to be extensible.  I
>   think we should initially limit it to "a single full history
>   .pack",

I misinterpreted what you meant by "a single full history .pack," and
used that to limit what you said earlier. A lot of my reasoning from
there misses the point, then, because it involved finding some way to
determine if a history .pack contains the full history, which
obviously is irrelevant.

>> I'm not sure how the server should determine the returned resource. A
>> packfile alone does not guarantee the full repo history, and I'm not
>> positive checking the idx file for HEAD's commit hash ensures every
>> sub-object is in that file (though I feel it should, because it is
>> delta-compressed).
>
> The above reasoning does not make much technical sense.  delta
> compression does not ensure connectivity in the commit history and
> commit->tree->blob containment.  Again I am not sure where you are
> going with this.

Related to the above, I was trying to find a way to determine if the
packfile contained the full history, which actually doesn't matter. My
technical reasoning was affected by the way deltas represent changes
in other VCS's, but I realize now that git's delta compression is
based around the similarity of objects, not their historical relation
to each other.

>> Which leaves me with questions on how to test the above condition. Is
>> there an expected place, such as config, where the user will specify
>> the type of alternate resource, and should we assume some default if
>> it isn't specified? Can the user optionally specify the exact file to
>> use (I can't see why because it only invites more errors)? Should the
>> specification of this option change git's behavior on update, such as
>> making sure the full history is compressed? Does the existence of the
>> HEAD object in the packfile ensure the repo's entire history is
>> contained in that file?
>
> Those (except for your assumption that no follow-up fetch is
> allowed, which requires you to limit yourself to "full" history,
> which is an unnecessary requirement) are good points one should be
> making design decisions on when building this part of the system.

Awesome, all of this is enough info to get me started. Thanks!

Kevin
