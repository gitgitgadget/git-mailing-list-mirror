From: Robin Rosenberg <robin.rosenberg@gmail.com>
Subject: Re: Branches & directories
Date: Mon, 03 Oct 2011 16:59:22 +0200
Message-ID: <4E89CDCA.9030802@gmail.com>
References: <CAMOZ1Bu5pPeviyZD-e6aHbv-+tSaBDyyKb5vHA132K_3=1gD-g@mail.gmail.com> <CAE1pOi0dL2qNMksuY_=gyGSRsfr6e9AmzgJUNB=jEz85sjuiUw@mail.gmail.com> <CAGZ=bqK7H3zc8LK7EP8+uV8DpWW+czK2POfceGtcBF8Vmkhkow@mail.gmail.com> <CAE1pOi1J5DKtnyUQzu1K7G1+HLsWWCN7thCf6W8MwSzt4_vtOw@mail.gmail.com> <CAGZ=bqLZoLoyMcvnppg6SyFtJU8phSquQeBZ7uhwP=+ZL3DADw@mail.gmail.com> <CAE1pOi0Er1ZgftpNeCr85Zu27xR2127V_KdAtvKc1NOKmDUvzQ@mail.gmail.com> <CAGZ=bqLyS9tcpqztwGWFOXtDJRhugu+JYvz7wTnc0PTmECWX2g@mail.gmail.com> <CAE1pOi1axNmGaPVXqBH02x0N=Z6tgO9R00RTokuJm50eY-OoNg@mail.gmail.com> <4E889813.8070205@gmail.com> <CAE1pOi3bm72Rk+UYygS_bC9eh0VTPr-VQSdtBGqjgDpEzkutZw@mail.gmail.com> <20111003030723.GA24523@sigill.intra.peff.net> <CAE1pOi2xmVHrVJcC85wvCv=anhn_kYizyUMpUVZF4EE33RoGmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Kyle Moffett <kyle@moffetthome.net>,
	Michael Witten <mfwitten@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Evan Shelhamer <shelhamer@imaginarynumber.net>,
	Git Mailing List <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 16:59:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAjzU-0005BA-5z
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 16:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182Ab1JCO7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 10:59:32 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41808 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932159Ab1JCO7a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 10:59:30 -0400
Received: by bkbzt4 with SMTP id zt4so5386300bkb.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 07:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=Raxfthhm1z2j+/EFau2B/JorbdBU5hEVGouFEHiyLwM=;
        b=wWT/nJp2JstG6f+Talup+RBj0FjuPuOZWbtFOwCWBq1kNwmAp6AyefmSULVaXEfqny
         kKsRf3/o3k+7le1AGO2/yIxm5g5mWZeyCr6gq0LtUI0tW26Zt6EQNqMQoDTRTg9H//2U
         TSThEGBOnzD6JlakBgAgcKlOPdQ9BWrlsKJHA=
Received: by 10.204.147.69 with SMTP id k5mr30454bkv.140.1317653969591;
        Mon, 03 Oct 2011 07:59:29 -0700 (PDT)
Received: from Robin-Rosenbergs-MacBook-Pro.local (host-95-199-30-22.mobileonline.telia.com. [95.199.30.22])
        by mx.google.com with ESMTPS id b17sm13496309bkd.8.2011.10.03.07.59.25
        (version=SSLv3 cipher=OTHER);
        Mon, 03 Oct 2011 07:59:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:7.0) Gecko/20110916 Thunderbird/7.0
In-Reply-To: <CAE1pOi2xmVHrVJcC85wvCv=anhn_kYizyUMpUVZF4EE33RoGmg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182665>

Hilco Wijbenga skrev 2011-10-03 09.15:
> On 2 October 2011 20:07, Jeff King<peff@peff.net>  wrote:
> <snip/>
>> Or did you really mean your example literally, as in you run two
>> checkouts back to back, without running anything in between, and the
>> second checkout restores the state before the first one. In that case,
>> yes, it would be correct to keep the old timestamps. But this is an
>> optimization that can only apply in a few very specific cases. And
>> moreoever, how can git know when it is OK to apply that optimization? It
>> has no idea what commands you might have run since the last time we were
>> at "master".
> Yes, I meant it literally. And, no, Git could not possibly know so it
> would have to be optional behaviour. But it's probably a lot of work
> for (for most people) little gain.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
I wouldn't use stash for that. Just regular commit/amend and your
timestamps should be fine. Alternative submit a patch for either
the save or create subcommands of stash. That would not be very
hard (technically)  and no one needs to mess with the timestamps;
they will just survive.

-- robin
