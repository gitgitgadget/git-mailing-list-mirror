From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH] Clarify documentation on commit message strip
Date: Mon, 27 Apr 2015 20:13:50 +0200
Message-ID: <20150427181350.GB15518@paksenarrion.iveqy.com>
References: <xmqqmw1w259r.fsf@gitster.dls.corp.google.com>
 <1429940565-14947-1-git-send-email-iveqy@iveqy.com>
 <xmqqh9s1xytr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 20:14:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmnXb-0004tX-Ip
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 20:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964966AbbD0SNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 14:13:55 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:36731 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964864AbbD0SNy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 14:13:54 -0400
Received: by lagv1 with SMTP id v1so86388496lag.3
        for <git@vger.kernel.org>; Mon, 27 Apr 2015 11:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=62L2X7KICqnqM//vc+av8pdVmHqw14VDfz55BBkMbBk=;
        b=NN2DLlNN6YETdwzNNo/U8Norzt2SP1udntkzYk8b5xXXceq15b89OWN79vGmPd9zbg
         YnOTifHM8OGfeskCh6YgKJXdTYK5i0k5JhOJ7q8y3bnJopQKyJ94Y+dYw5HZ8BeCxMg0
         g7MSJLcFvM+riqRdpHDDeUuUOMuRWTZAAi0KvWceozRQFKZwFXxWm0MD17j9Ii1PIoqp
         iqTBrB0COAHejHG8zyvGdPKj4kjGJ5y83hg3kYF9ywFN/wVOwAyt+X7kkkWoUwqfkUNq
         01YpTp0QKj6iiXqF1UXro5AurI0cmjP7GkZaBGM9O1pGF/JNtPm0PZayHt63d7cFm1m9
         IyNQ==
X-Received: by 10.152.19.162 with SMTP id g2mr11069197lae.46.1430158433108;
        Mon, 27 Apr 2015 11:13:53 -0700 (PDT)
Received: from paksenarrion.paks.iveqy.com (c83-249-10-52.bredband.comhem.se. [83.249.10.52])
        by mx.google.com with ESMTPSA id t1sm4945165lbb.25.2015.04.27.11.13.51
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Apr 2015 11:13:51 -0700 (PDT)
Received: from iveqy by paksenarrion.paks.iveqy.com with local (Exim 4.84)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1YmnXS-0005Cm-Kq; Mon, 27 Apr 2015 20:13:50 +0200
Content-Disposition: inline
In-Reply-To: <xmqqh9s1xytr.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267864>

On Mon, Apr 27, 2015 at 10:31:28AM -0700, Junio C Hamano wrote:
> Fredrik Gustafsson <iveqy@iveqy.com> writes:
> 
> > I agree that it is very clear once you do edit the commit message. My main
> > point with this patch was to clarify -v, since it's not obvious from the
> > documentation that it will be removed.
> 
> While I agree with you that the documentation should make it clear
> that the patch will not be part of the commit, I think the root
> cause of the current "unclear-ness" is because the documentation
> does not make it clear *WHY* the "-v" option gives the patch text
> there.

I agree.

> 
> Doing something like this on top of your patch may clarify the
> reason what "-v" is used for, and I suspect that it may even make it
> unnecessary to explicitly say that the patch text will not be part
> of the log message (but I didn't remove that with this "how about
> this" follow-up).

Even better. I would be glad if this could make it into a release.
Thanks for the feedback, to make this a good patch.

-- 
Fredrik Gustafsson

phone: +46 733-608274
e-mail: iveqy@iveqy.com
website: http://www.iveqy.com
