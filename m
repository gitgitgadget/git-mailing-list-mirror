From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Tue, 30 Apr 2013 01:13:54 +0530
Message-ID: <CALkWK0=Qo2aPz3+DDiHV77Z=+jeqwanAOMZHFLLMzm5BS_n0uw@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 21:44:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWu0C-0001ZP-9x
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 21:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760980Ab3D2Toh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 15:44:37 -0400
Received: from mail-ia0-f178.google.com ([209.85.210.178]:64816 "EHLO
	mail-ia0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759065Ab3D2Tof (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 15:44:35 -0400
Received: by mail-ia0-f178.google.com with SMTP id j38so6065925iad.9
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 12:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=WvBe6sgfC4kSjvqdHqLnWvvjk18hIT2OXXtfDtrUPHk=;
        b=RKcv0kSK6y9cRi6a8ijyWfWoiiWKWra1m6YG3BAoUIAErqP7htH3JTa7FdVvHobEwL
         uV2ZC79PTt8mwywGCcXo/Ws6x20x5G911NQNFnenRsTpk64AszjKfFJBURF6/ayOrPry
         pKy1yhw7no2T8lzthEWDPAPhnv8AfuL7a8njQ/JTGn1rARt+gOfIp6tFP33hL987Itlw
         jRJek109yRGsoSkC5aN3aFd6uk05fJepUq2tG9OGkPtafBz+MX07JN4D8gZcSapcrA+D
         OrToCgChe6pfKpCZKm/wsTa7VFN9F7hz94L8jPRMsC7BeGJlt07zHVYyrHl6znMtQT2k
         zAJQ==
X-Received: by 10.43.125.199 with SMTP id gt7mr1692484icc.48.1367264675096;
 Mon, 29 Apr 2013 12:44:35 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 29 Apr 2013 12:43:54 -0700 (PDT)
In-Reply-To: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222854>

Felipe Contreras wrote:
> So we can type '@' instead of 'HEAD@', or rather 'HEAD'. So now we can
> use 'git show @~1', and all that goody goodness.

Good one.  This is what I didn't think of.

The implementation looks beautiful, and I have nothing more to say
about the patch.
