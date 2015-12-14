From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Corruption of branch?
Date: Mon, 14 Dec 2015 21:18:22 +0100
Message-ID: <1450124302.16044.1.camel@kaarsemaker.net>
References: <566EFF11.6010600@gmail.com>
	 <CAGZ79kaUw8Hb_7hdAUbvmnmXvm3a-77j5t3zeyQ-7BqwPCSp+A@mail.gmail.com>
	 <566F05B2.8080403@gmail.com> <1450120801.1678.13.camel@twopensource.com>
	 <566F1F96.4060806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Nyberg <tomnyberg@gmail.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 21:18:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8ZZq-0008Ae-TS
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 21:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbbLNUS0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 15:18:26 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34087 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753632AbbLNUSY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 15:18:24 -0500
Received: by mail-wm0-f47.google.com with SMTP id p66so79875477wmp.1
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 12:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-type:mime-version:content-transfer-encoding;
        bh=LvXQ5omU2ilXI+7MYOIcaLDrqSkdx80QT9+pJoSPncQ=;
        b=J1Had9J1NN9dhPRtHV0+27mHkAu6uIYlQfunKWE61vwr20gitX7EnqgrnQqQnhNjsb
         SkFU/MaX4CIYdSJBA1+YbnV0w9aid7F94kvvSCyfz4TlCFZcwkNck6OqqfNT6/B2hpjz
         PSpQZ/OPyQXCjPkkZSUVQg3GjOGDKD4Ieaz6bUnIjOw/FgDIXJfsC6q3uQknJiStI4me
         NalD0Qvd43Sl45ImybQJnD0mPwkx4Q5IL+8RiQc7XHTIDjKURSQogvzyihrQKnYClCGf
         XpipS33NDDFZjRzbPHoWBadfoc6wMtsIeARyF12dMWdajOcTpk9QxTfELtZ/m5/KweuI
         oepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=LvXQ5omU2ilXI+7MYOIcaLDrqSkdx80QT9+pJoSPncQ=;
        b=RvTgZhSKkBZi9AQBU6WSsM2HbeQkF/FngKB/QQR7vXfsdb2YwJLJ8Xae6/CssSCN3U
         nobRf2KIPA84z9F4nnrrh1pnGwpUYlG+8rmJzHMSmeXb7FSTlMV9sj7wuk6vUxqbv7oY
         jyQdrzBOuYYN5ByiyFylx2m8aFmZmBP2Kxh+yoVXcYwSjwgkqg2jom9J2sRYi5DiiecY
         VtWF+adjhJ7p2lQkeBMoEl5qqwjeKw2jScgzT3v5JwAQB1BTmqzxGa6H6kS0Zhm8qFF4
         ygKwig3K//kHARi0BtaO+ARTCaZdGDbDWUhLdBwGCFcXPsSHHPSJ/cjoiFUqsIBgtpVi
         0wZg==
X-Gm-Message-State: ALoCoQknhWW95YIoJwSZM7+BvlVgPmOK9Xr8L0PUPMbMzY10jKVdXAQxFBZX7IdYDHNnX7/C/1Z6tPPt+w9UZljGj8rG+DoA0g==
X-Received: by 10.194.115.67 with SMTP id jm3mr39977316wjb.9.1450124303640;
        Mon, 14 Dec 2015 12:18:23 -0800 (PST)
Received: from spirit.home.kaarsemaker.net ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id q4sm31278714wja.6.2015.12.14.12.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2015 12:18:23 -0800 (PST)
In-Reply-To: <566F1F96.4060806@gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282399>

On ma, 2015-12-14 at 14:59 -0500, Thomas Nyberg wrote:
> I'm guessing you're looking for namecollisions of some kind?

I was thinking the same. Can you share the (sanitised) output of 

git for-each-ref?

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
