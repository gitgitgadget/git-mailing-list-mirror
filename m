From: harryxiyou <harryxiyou@gmail.com>
Subject: Fwd: Patch for QEMU errors
Date: Mon, 21 Jan 2013 13:35:43 +0800
Message-ID: <CAD+1EGNi9ohaXbjpresPt=hjBRY=kt4FZUEJCPKHsFyHc5PADg@mail.gmail.com>
References: <CAD+1EGNDEF7bfyHKYwA=OSU-JJoGG2L4bfZwKLbO87mCxu-P7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 06:36:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxA3E-00073r-IV
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jan 2013 06:36:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638Ab3AUFfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 00:35:46 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:47909 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab3AUFfp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 00:35:45 -0500
Received: by mail-lb0-f176.google.com with SMTP id s4so954814lbc.21
        for <git@vger.kernel.org>; Sun, 20 Jan 2013 21:35:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=vbyWh7vCeJAa+sdz8rBnhjp+6l/2tjS/61efhXic6So=;
        b=qsXuyAtzVgU8TJvDQ+FMKpYdA7AsMGKbg8WTX8KgfjCjCd0HgRUg4pgoN/aom5CSNW
         thRF3cOU39vkCePQ+vs8SIEufF4k2rs7aW5EwNVprcqZilhs7faQVy7EFx3kRz67ygOx
         Lt7yxHwvupo/tBs/cDRFraMFhzbBAc5qiPhldwqJNsSDP/qWSDBBXZTCr18ITSf00p31
         Oo08Jgoy2OO9zMlmGFPLerKga1u3AVD0mUrMf2Os4zjv8+e1GyFFRdd5l2m4BkEWpcJq
         7nonNNXIR64HXrTW2kw5YBH79EkF8kSZYN9fbLJWVcC5SBCEk73L6aoDxBdwC17V7HhL
         AjaQ==
X-Received: by 10.112.25.106 with SMTP id b10mr6948248lbg.68.1358746543978;
 Sun, 20 Jan 2013 21:35:43 -0800 (PST)
Received: by 10.112.125.6 with HTTP; Sun, 20 Jan 2013 21:35:43 -0800 (PST)
In-Reply-To: <CAD+1EGNDEF7bfyHKYwA=OSU-JJoGG2L4bfZwKLbO87mCxu-P7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214081>

Hi all,

We programmed a block storage(HLFS) patch for QEMU. Therefore,
when i patched this driver for QEMU, it happened to me some errors.
Could anyone give me some suggestions, thanks in advance ;-)

You can see this issue i described in details from
http://code.google.com/p/cloudxy/issues/detail?id=21

You can also see our patch for QEMU here.
http://cloudxy.googlecode.com/svn/trunk/hlfs/patches/hlfs_driver_for_qemu.patch


-- 
Thanks
Harry Wei
