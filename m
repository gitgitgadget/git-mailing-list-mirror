From: Jonas Bernoulli <jonas@bernoul.li>
Subject: Re: Empty config sections are neither deleted nor reused
Date: Sat, 14 May 2016 15:21:59 +0200
Message-ID: <877fewzseg.fsf@bernoul.li>
References: <87r3d6knwo.fsf@bernoul.li> <xmqqeg95aor6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 14 15:22:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1ZWd-0008GU-Cw
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 15:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbcENNWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 09:22:31 -0400
Received: from mail.hostpark.net ([212.243.197.30]:53123 "EHLO
	mail.hostpark.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752036AbcENNWb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 09:22:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.hostpark.net (Postfix) with ESMTP id A8FF3162B1;
	Sat, 14 May 2016 15:22:28 +0200 (CEST)
X-Virus-Scanned: by Hostpark/NetZone Mailprotection at hostpark.net
Received: from mail.hostpark.net ([127.0.0.1])
	by localhost (mail0.hostpark.net [127.0.0.1]) (amavisd-new, port 10124)
	with ESMTP id DvwSOuD8D0Yh; Sat, 14 May 2016 15:22:28 +0200 (CEST)
Received: from hal (80-218-86-217.dclient.hispeed.ch [80.218.86.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.hostpark.net (Postfix) with ESMTPSA id 6264616A7A;
	Sat, 14 May 2016 15:22:28 +0200 (CEST)
User-agent: mu4e 0.9.17; emacs 25.0.93.1
In-reply-to: <xmqqeg95aor6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294612>

> The configuration sections can have comments and they are preserved
> even when they become empty.  Adding something unrelated will still
> make it appear the stale comment applies to it.

Now that you mention it, I think I have read that before.  Unfortunately
I forgot about it until you reminded me.  I would still prefer if empty
sections were removed and/or reused provided no comment is nearby, but
now that you reminded me why the current behavior is how it is, I can
live with it.

Thanks for the link.

  Jonas
