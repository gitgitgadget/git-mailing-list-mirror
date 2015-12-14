From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Corruption of branch?
Date: Mon, 14 Dec 2015 21:40:40 +0100
Message-ID: <1450125640.16044.4.camel@kaarsemaker.net>
References: <566EFF11.6010600@gmail.com>
	 <CAGZ79kaUw8Hb_7hdAUbvmnmXvm3a-77j5t3zeyQ-7BqwPCSp+A@mail.gmail.com>
	 <566F05B2.8080403@gmail.com> <1450120801.1678.13.camel@twopensource.com>
	 <566F1F96.4060806@gmail.com> <1450124302.16044.1.camel@kaarsemaker.net>
	 <566F277F.4070101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Nyberg <tomnyberg@gmail.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 21:40:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8ZvM-0004cQ-EQ
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 21:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562AbbLNUkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 15:40:43 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38600 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbbLNUkn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 15:40:43 -0500
Received: by wmpp66 with SMTP id p66so77352038wmp.1
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 12:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=3n0Kz5pIFxUbQ8VmJmLsjfbJjDZw9TwupHpWUaOujoU=;
        b=pAc2dJY/BqUXwZjt3RKbUz3RZS2nPTVQM2gjrBWeN/rZMllTG0TShwMumvu4JRD2bT
         +LT8nBqSEc14mJKtYczuMQt14psc5yxGokKKBJjdMCEkAkdN7uDkhpQ+bQFnbLIOSLMa
         iV2Rp21ACOUkrcJf8QaTwS6iXVkxCFvwOMu3I0M8nKLbMFYh4x97LLE0p/FF6mh79J7/
         kVkl99+iS7wMqPggC0zu1bLEeEdQP4PDxUPVgOz0bOikXDW5EXFYfSCIMTHP2qiKMDgy
         xxLhmVYsbb3qm8gP/FUNCit8FyDpweGElW9KZrcZSCl6dqBUPndjxQVIvWX57gFbOd30
         tyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=3n0Kz5pIFxUbQ8VmJmLsjfbJjDZw9TwupHpWUaOujoU=;
        b=XPEHTsCtoHKAi+/RqQayH/5XvMdmozS3eZKYjt/XOH2tu6diySUZZ9Lx5DDTv/lgYm
         0Qo7yBLlzQ5fzetR5W1JTJUprC/WtYRayaBoF+6IkcLgoe2dTOKQAYaLK4+ByFrvxC3S
         ILT0lxfvV4Q8vj0FaAewLaEcNYWpKN/FFHfVZKoTSguP1CUpmoZu9pMPfoFOVDJXhNDG
         LINY0Tcs3iR0qNobW6OLlzt7waWqYUgIKIbI223uPWNGtQjtXP0OLJVieGhf/3fT9kif
         21T1djI4bX7Of9BM6fvw4I7gHdxBQnfIkZmXRD/zBo2+LDVhz2eZaFfaoq8nsjw46bed
         MQVA==
X-Gm-Message-State: ALoCoQlQ2QNB486g8ulgXBdsE+SZ9V78mgMNeJRrPwXR7IoRYijFPHB5x1F4gEyNpL8ntSUIMIkrO6isPp9wi6Vm31fvoywueg==
X-Received: by 10.28.64.131 with SMTP id n125mr134205wma.103.1450125641985;
        Mon, 14 Dec 2015 12:40:41 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id n129sm3734413wmb.1.2015.12.14.12.40.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2015 12:40:41 -0800 (PST)
In-Reply-To: <566F277F.4070101@gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282404>

On ma, 2015-12-14 at 15:33 -0500, Thomas Nyberg wrote:
> What exactly are you looking for? Here's the results of the following
> command:
> 
> $ git for-each-ref | grep frus
> 1750cba5a94b3fe6041aaf49de430a558a3b9bc8 commit 
> refs/heads/frus_body_cleaning
> 3a1dbe48299f6eda1cc4b69cab35284c0f0355eb commit	refs/remotes/o
> rigin/frus
> 1750cba5a94b3fe6041aaf49de430a558a3b9bc8 commit 
> refs/remotes/origin/frus_body_cleaning
> 
> Sorry if this isn't what you're looking for. I'm actually not very 
> familiar with these different internal git commands...

This is what I was looking for. Unfortunately it doesn't show any of
the smoking guns I had hoped for.

That leaves only one option: you also have a file or directory named
'frus' in the root of your repository. In this case 'git checkout frus'
does the same as 'git checkout -- frus' instead of DWIM'ing 'git
checkout frus' to 'git checkout -b frus origin/frus'

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
