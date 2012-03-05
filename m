From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] fmt-merge-msg: show those involved in a merged series
Date: Mon, 5 Mar 2012 13:46:58 -0800
Message-ID: <CA+55aFzuCJWfzp2ROxvMY78NZWb3ofYWOebfPfPba9kypyytKA@mail.gmail.com>
References: <7vvcmj68iz.fsf@alter.siamese.dyndns.org> <CA+55aFzQ3+EFBVyE9PWOyH0XEC_oW+kUaBTYfixmi2wgMmiZvw@mail.gmail.com>
 <7vipii27ka.fsf@alter.siamese.dyndns.org> <CA+55aFw-sS_p7JXNXbSbpiwh9_bZhSrTtC3is4NtLa_n9Hzk5A@mail.gmail.com>
 <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 22:47:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4fka-0006Y5-Pk
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 22:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754478Ab2CEVrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 16:47:20 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:64393 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239Ab2CEVrT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 16:47:19 -0500
Received: by wejx9 with SMTP id x9so2645699wej.19
        for <git@vger.kernel.org>; Mon, 05 Mar 2012 13:47:18 -0800 (PST)
Received-SPF: pass (google.com: domain of linus971@gmail.com designates 10.216.135.141 as permitted sender) client-ip=10.216.135.141;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of linus971@gmail.com designates 10.216.135.141 as permitted sender) smtp.mail=linus971@gmail.com; dkim=pass header.i=linus971@gmail.com
Received: from mr.google.com ([10.216.135.141])
        by 10.216.135.141 with SMTP id u13mr4715517wei.79.1330984038351 (num_hops = 1);
        Mon, 05 Mar 2012 13:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=eFxcUTrHb0OF9ZKbKV10oBbbSYyk0qK4CanTI0315g8=;
        b=jmzgVt87XMC0KX1uGoaucRt1egT0AnHbSXODsgFNbhJO/Ner0IaG/GF1r2DkAND3gz
         6aJDMrTYB/JXQiOutzDAqtskTfIEyUxhQUCa+G8rIvf8JYiKhg4SJ+LPpNBiwVAePonN
         Zk89ygXmWRakR/kwgsuOAKmKvMpzpNNvaoCXGWF0cNG/NP/kijv0HHFfHgk8JznqU0rk
         ezyYn3WNgWK75B80ctjgZdnGviPZrd2nwsps9CckTaavT55lWeWo5+8iNVJklhIN9L1N
         JA8J5RLW1A2aJwLupalmMSZSm9Ep9nOGfA2L4Ujf1ZCzicOep9VUrGEEPtnT4q55KkT9
         LMFg==
Received: by 10.216.135.141 with SMTP id u13mr3817963wei.79.1330984038273;
 Mon, 05 Mar 2012 13:47:18 -0800 (PST)
Received: by 10.180.106.164 with HTTP; Mon, 5 Mar 2012 13:46:58 -0800 (PST)
In-Reply-To: <7vmx7uzq8h.fsf_-_@alter.siamese.dyndns.org>
X-Google-Sender-Auth: DahhCweynZ4FjOYHEBEBkC02G80
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192276>

On Mon, Mar 5, 2012 at 1:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> This patch punts the deep thinking part and just picks the tip
> committer and counts only merges in the history you are pulling in.
> It may not be a very good heuristics, but the code structure should
> be a good place to start.

Yeah, this looks good to me (but I didn't actually *test* it, so
that's just from looking at the patch).

                 Linus
