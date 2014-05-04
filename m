From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 10/12] MINGW: compat/poll/poll.c: undef NOGDI
Date: Sun, 04 May 2014 15:14:39 -0500
Message-ID: <53669faf17247_61fea2d30c14@nysa.notmuch>
References: <1398762726-22825-1-git-send-email-marat@slonopotamus.org>
 <1398762726-22825-11-git-send-email-marat@slonopotamus.org>
 <20140430114125.GA23046@camelia.ucw.cz>
 <20140503070050.GA8580@seldon>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Marat Radchenko <marat@slonopotamus.org>,
	Stepan Kasal <kasal@ucw.cz>
X-From: git-owner@vger.kernel.org Sun May 04 22:25:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wh2yT-0008Ma-11
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 22:25:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbaEDUZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 16:25:21 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:46579 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851AbaEDUZV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2014 16:25:21 -0400
Received: by mail-oa0-f49.google.com with SMTP id o6so7546263oag.36
        for <git@vger.kernel.org>; Sun, 04 May 2014 13:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=0JO3aiybuwx81HMHfMTI573csikuFqm75EKAU0LMSaY=;
        b=hpLgKH1qw3hwdAXQxnp1KMkaNWqNkEGlWIXHtT5XhSQBIHPw9tdOHxoGNpawUgzJtE
         A4ywLCLFNellbUtlhXvO2z7YJMz7VvuVZs1BuHdiUQZMM02OqquaMv3zRc/HZcoCwyCQ
         JosF2pMqiwMHgcmGrWYdBw1Yl/QmGnV/JPYjvTDlbNOSxpBmtSUy9AjkMQQCT0bbhIOa
         b9LIAHJsqQRotm6TBwy/yq0MpmhDkmnLXBOId0cWs4m205mVxqjrCdtZXnecll94BgZw
         0xzC7aUF5nXimqqzFQHe/CqdaFV0AEyHMW6VAVNGJ8xCo9q1GnGnsKYJN9mi0M2wsjLi
         3ThQ==
X-Received: by 10.182.45.161 with SMTP id o1mr7044096obm.29.1399235120713;
        Sun, 04 May 2014 13:25:20 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id zm8sm14115724obc.16.2014.05.04.13.25.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 May 2014 13:25:18 -0700 (PDT)
In-Reply-To: <20140503070050.GA8580@seldon>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248111>

Marat Radchenko wrote:
> If one wants to dig deeper, I'd say the problem is in MinGW-W64
> headers because their behavior of hiding MsgWaitForMultipleObjects
> doesn't match behavior of MSVC headers.

I agree with that. Can you file a bug report?

-- 
Felipe Contreras
