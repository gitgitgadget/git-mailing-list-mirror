From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: how to fetch entire heirarchy of refs from a remote?
Date: Fri, 8 Jan 2016 08:30:52 -0800
Message-ID: <CA+P7+xogcBaAfWi5nf85ki44p+fLHJiRWUu5iMMaFutenoA83g@mail.gmail.com>
References: <CA+P7+xqexsOma5c9NfS5ma333UJV=5i1a4GhnwZuU75eaxRd=Q@mail.gmail.com>
 <CA+P7+xra4hjskOLg=VhLMGazTSDH=ky8H+fj2VMCw+HoY2Frrg@mail.gmail.com> <xmqqfuy92bt7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 17:31:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHZwb-0007Qe-4e
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 17:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157AbcAHQbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 11:31:13 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34180 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbcAHQbM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 11:31:12 -0500
Received: by mail-ig0-f179.google.com with SMTP id ik10so82459450igb.1
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 08:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wgPq86kC7xrK3LZR262I/x1vBspZRKs758qLEe2Kge8=;
        b=lBZSYYtnq76vZPHRXVL5miy2xAGF8pNizLBIOEPXLGvoyTgm7rD74X9cLyZkgWhC9l
         u2zqf/IVR4q5K/WdoGdKQ1w2wgU8Y8layhwSPkdrPoSenVJermExMA+gtdC2eR5hD/hF
         0YctPJFIRhnH9uttKgzHhA+VABQ+lac2MCFpdSuko28Y+P8zUpZQGYi7he6kybLBOmnB
         UOyife/KoLnQFUkJhMW3ZcogVMg0w6Y8jfX5U58uShiFeJwXLKfcNy0pZr08b4jqwoZS
         pT76bNqrRKae7YzE8aECVsJaJda5oSAyt9LIBc3LHmNvweTDi1WLrROegFBoqQNmx0Ad
         AhVw==
X-Received: by 10.50.28.19 with SMTP id x19mr22978182igg.92.1452270671892;
 Fri, 08 Jan 2016 08:31:11 -0800 (PST)
Received: by 10.107.12.81 with HTTP; Fri, 8 Jan 2016 08:30:52 -0800 (PST)
In-Reply-To: <xmqqfuy92bt7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283568>

On Thu, Jan 7, 2016 at 3:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> does show them? Any particular reason for why this is? I am confused
>> why refs aren't showing up inside the refs folder...
>
> Does
>
>         git for-each-ref refs/changes/
>
> in your local resulting repository show them?
>
> There is nothing that says "ls -R .git/refs/" is the way to
> enumerate available refs (in fact it is a _wrong_ way that is
> guaranteed to give you wrong results).
>
> Hint: .git/packed-refs
>

Yep I figured that out :) Now I know better!

Regards,
Jake
