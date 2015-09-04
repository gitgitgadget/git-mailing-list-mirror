From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-protocol: document newline behavior in push commands
Date: Fri, 04 Sep 2015 08:49:34 -0700
Message-ID: <xmqq7fo6gp69.fsf@gitster.mtv.corp.google.com>
References: <20150903080205.GA20182@sigill.intra.peff.net>
	<xmqq4mjbi1w1.fsf@gitster.mtv.corp.google.com>
	<20150904090044.GB32751@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Dave Borowitz <dborowitz@google.com>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 04 17:49:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXtFG-0001ZR-OU
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 17:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759273AbbIDPtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 11:49:39 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34350 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbbIDPti (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 11:49:38 -0400
Received: by padhy16 with SMTP id hy16so25624037pad.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 08:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=BDRoYqa2r6xFOj3iUwua8Zycxfvjd4lKFjeA4RyFVDQ=;
        b=0Oq0OlnVzeWkH1rCCvpLAiA9a8eADJxVOJAV1LQQemeLaFwYXWqGS5b2IjWutPc/6a
         67guhdgYB54lkn1I8NYMKOM9tzebR+WuY1Bwr6gOKMmI13eYFIOgYaR9LDyVmQf9/FjE
         s8XimVeT6vjyMVXN4HtWsJHVgxiR0Qoj/BaVkK1Ecbn2MJ7yZ0KILxljcQ/FWp/QX5Kv
         SbmZmJ/xzlXowFyqoyAqihqN+aEyvQ4wNAUjQQ7tpCDa7cZhZMGwCoaqbnF7S2YXnVM3
         T3h4GgrtmFT5GQRb7s+i5CD8xdnR/XlN20GkeZvNaFse2huVDCv0EuHzi5rOujxF6W6U
         57zA==
X-Received: by 10.68.69.98 with SMTP id d2mr9395387pbu.137.1441381777825;
        Fri, 04 Sep 2015 08:49:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:2198:98f:3bb3:46bb])
        by smtp.gmail.com with ESMTPSA id p11sm2830581pdn.55.2015.09.04.08.49.35
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 04 Sep 2015 08:49:35 -0700 (PDT)
In-Reply-To: <20150904090044.GB32751@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 4 Sep 2015 05:00:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277317>

Jeff King <peff@peff.net> writes:

> Right, it was the second "we know..." that made me worry. It is really
> "we assume". :) Whether it is right according to the spec or not, the
> real world is sometimes more complicated. And given that there is no
> real advantage to changing the sending behavior now, I didn't think it
> worth doing.

Agreed.

>>> This documentation update is good in that it makes the examples
>> easier to read (by the way, the first pre-context line ends with
>> '\n', which we would eventually also address) by making the reader
>> understand that the convention used in this S:/C: exchange
>> illustration the optional LF is not shown.
>
> In the second patch I left them all intact, but I agree that we could
> drop the "\n" entirely from the example conversations, as it is implied
> (and GIT_PACKET_TRACE, for example, does not even show it).

Sure.
