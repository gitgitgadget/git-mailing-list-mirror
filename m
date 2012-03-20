From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [PATCH 1/2] Unification of user message strings
Date: Tue, 20 Mar 2012 13:33:09 +0100
Message-ID: <4F687905.6070200@lyx.org>
References: <1332179503-2992-1-git-send-email-vfr@lyx.org> <1332179503-2992-2-git-send-email-vfr@lyx.org> <20120319205300.GA3039@sigill.intra.peff.net> <7vaa3c9ste.fsf@alter.siamese.dyndns.org> <4F683622.6010409@lyx.org> <m339934h39.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 20 13:33:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9yFb-0000Mz-D4
	for gcvg-git-2@plane.gmane.org; Tue, 20 Mar 2012 13:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758310Ab2CTMdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 08:33:14 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:63758 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754672Ab2CTMdN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Mar 2012 08:33:13 -0400
Received: by bkcik5 with SMTP id ik5so5072576bkc.19
        for <git@vger.kernel.org>; Tue, 20 Mar 2012 05:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=jZbrcTBrpfFnptJpXMzPOXmZP7b80Z3CWW8JydbJSh8=;
        b=BrXbG2OI0QBjQgjhUhKDkehITlS0Ai2/F4S66Tq5AmRBFdRwmJmCC5dPB0xhdjhQXa
         8j49a64vrt900FLx7I3+nCVthrgfPaspwcUY0ANmrLTHPbNJrLhmi9eYWJKHGMmk09k/
         R2dpkuX9OVmBrBMT/1yQjOu7PJspMlj9Hx94ZZEjgoVC3NRsyWpU17H3pyUoFLQJLKiG
         BSwUFbHZTwnP31N0TbYP4tf4ImZGHeFRLaKh7VV2w4DXckCY1UBqY7IwTZyvshTf3IzW
         +gyh/Z8B/V+ceWSQd994m2eD+IPKD7gGayiKcRr7Ncj1bo/gXsEZPaiYKTcyjOcbSRtr
         Vyyw==
Received: by 10.205.133.13 with SMTP id hw13mr5895137bkc.25.1332246790249;
        Tue, 20 Mar 2012 05:33:10 -0700 (PDT)
Received: from [145.94.170.103] (wlan-145-94-170-103.wlan.tudelft.nl. [145.94.170.103])
        by mx.google.com with ESMTPS id h16sm2909750bkk.12.2012.03.20.05.33.09
        (version=SSLv3 cipher=OTHER);
        Tue, 20 Mar 2012 05:33:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <m339934h39.fsf@localhost.localdomain>
X-Gm-Message-State: ALoCoQnYsypNWu8cpZi0VlQMp9v3DUyi53PY/t5FgKriOwgRZTqLUzY0gHKmW6rNMwRa/IL+mEBx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193504>

>>
>> It seems that the terms "Porcelain" and "plumbing" seems to be mixed
>> up somewhere.
>>
>>   From 'git help status': "PORCELAIN FORMAT: The porcelain format is
>> similar to the short format, but is guaranteed not to change in a
>> backwards-incompatible way between git versions or based on user
>> configuration. This makes it ideal for parsing by scripts".
> The '--porcelain' option means "intended *for* parsing by porcelain",
> not that it is 'porcelain' output.

I've a hard time to interpret the quote above in the way you explain. 
Maybe a little improvement to this description would be helpful.

>
> HTH

Thanks.

Vincent
