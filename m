From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 2/2] fix clang -Wtautological-compare with unsigned enum
Date: Thu, 17 Jan 2013 00:10:11 +0100
Message-ID: <CALWbr2ztJi209w82Kmu876QB9tSdheO8zgNXTv_8USR4eRX8Sw@mail.gmail.com>
References: <20130116182449.GA4881@sigill.intra.peff.net>
	<1358376443-7404-1-git-send-email-apelisse@gmail.com>
	<1358376443-7404-2-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: John Keeping <john@keeping.me.uk>, Max Horn <max@quendi.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:10:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvc7y-0005Jw-St
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 00:10:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268Ab3APXKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 18:10:16 -0500
Received: from mail-ee0-f54.google.com ([74.125.83.54]:41208 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816Ab3APXKP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 18:10:15 -0500
Received: by mail-ee0-f54.google.com with SMTP id c41so935818eek.41
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 15:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=HYzweUppDTNb6W+NlZDYfJcV6CAa/0u/ZARtzGebIuM=;
        b=sTvRTCJQ6SAmd8ygZktn8s3UbeyE3j1ippzBrbt7aQgLuZdvYg5gjRjoi0Jtl/KwNJ
         UKB8KcqEw/uqDoiTBOPTZqcDZvPC1eawA+7x/2hNWF5tAG61fB+wz9zjf33GY92GvBOq
         Nb3nM3eX0G7bQ3OwJ+8oN0Jpp3e3pezeICZfXmOJOiKE9/kvrskBEJWfih7Tf4mxpCFy
         v495gX0kkMD2Ccx5r6MNn3dBNp93egobl7a8PI/VWH4GiPluk4U8bTmd8QSaUdOzxIq5
         sj4uxzfooA7NldGg3TbEdS+gTb2m1cq0kXykfKNq4FeuJBOxfoNUV1HVp35F2UEKyahy
         46GA==
X-Received: by 10.14.225.72 with SMTP id y48mr6523675eep.46.1358377811740;
 Wed, 16 Jan 2013 15:10:11 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Wed, 16 Jan 2013 15:10:11 -0800 (PST)
In-Reply-To: <1358376443-7404-2-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213823>

> With these two patches and the patch from Max Horne,

I'm deeply sorry for this typo Max
