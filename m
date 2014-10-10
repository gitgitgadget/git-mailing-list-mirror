From: Sergio Ferrero <sferrero@ensoftcorp.com>
Subject: Re: configure names for temporary files
Date: Fri, 10 Oct 2014 11:39:21 -0300
Message-ID: <CALpL35nPE+MxSKNc3cRyAbNW3SBz50EGu7P6cF+PcA-vky7jXg@mail.gmail.com>
References: <CALpL35mjtg9ge321Vz_kS1wzbYz+z9H5R3L8FcpVSNO3AtZzVA@mail.gmail.com>
 <20141008082228.GA78852@gmail.com> <xmqqtx3ebhip.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 16:39:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcbMA-0002bk-U2
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 16:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442AbaJJOjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2014 10:39:43 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:58671 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879AbaJJOjm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2014 10:39:42 -0400
Received: by mail-qc0-f174.google.com with SMTP id m20so1993374qcx.33
        for <git@vger.kernel.org>; Fri, 10 Oct 2014 07:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=SEknYcSB+yUN//Ii10DtENwV9Lfm/JEtXuVda1zQdJc=;
        b=lgclghsgJhbwGO5yAXHpFNJt+1zqdRokwDdC35h+uyK4P9o/MP9BFUSn5Xqur0wfNE
         2BkPHjR+ix/J65W2Rge2WPyyWEUgsSFTrLpNDLEbAnSsw25Cp+wizJ65n6UUkm04q4/P
         nxnxZu27lgP+ijfrSojYUr6hsRcJHPmycyBVYeZ+z82BJGbgAVIomvt8b0TzrnmhCBr3
         EjmZVzN4uEd6OzpGh41f1Az+feV0Zu2mV2q21lT6gA1x4ffYCITujhJqla4ZkMlWugoP
         SjhCsxgpmc8hd3cs6k9MwQK6+pxepV3aD/bEZoiWEBEQtoGfZ/MLKHDJwdNLlrNpGGSY
         LC6Q==
X-Gm-Message-State: ALoCoQkXdRadXc0bHccHEII1wtwVPeKalqsI/bqOoUzvrE+O512Bi+PrZMqnJvNX9y+KrR0D9npF
X-Received: by 10.224.12.132 with SMTP id x4mr5818049qax.84.1412951981763;
 Fri, 10 Oct 2014 07:39:41 -0700 (PDT)
Received: by 10.140.92.110 with HTTP; Fri, 10 Oct 2014 07:39:21 -0700 (PDT)
In-Reply-To: <xmqqtx3ebhip.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok. thanks!
David: I'm pretty sure matlab won't do that change soon :)

Sergio

On Wed, Oct 8, 2014 at 2:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> In any case, it might be worth adjusting mergetool to use a more
>> conservative path (underscores instead of dots) since there
>> doesn't seem to be much downside to doing so.
>
> Hopefully there won't be tools that reject paths with "_" in them
> ;-)
