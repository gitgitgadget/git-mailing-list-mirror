From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] pull: handle --log=<n>
Date: Thu, 21 May 2015 14:24:46 -0700
Message-ID: <xmqq1ti9ipy9.fsf@gitster.dls.corp.google.com>
References: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
	<5661061272076a1883cfde1087be4a42@www.dscho.org>
	<20150521103617.GA6159@yoshi.chippynet.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 21 23:25:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvXxW-0003XS-8a
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 23:24:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756042AbbEUVYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 17:24:51 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:32820 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198AbbEUVYt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 17:24:49 -0400
Received: by igbpi8 with SMTP id pi8so21467002igb.0
        for <git@vger.kernel.org>; Thu, 21 May 2015 14:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=WcgZPBEGomVKVXG+FQvDBE+Fm48GpeXsyw7vb8A1A5o=;
        b=nfcW24KoOVg9ig39+f4F71+ctCprJgEj3z1sa5Qb8gWH3RuSvy6DXmHA7ZSiwfiN8d
         WVPgjVRaiuePJFJgw/oiUjrHXskHkpAbtshx0gdBb+uj/MpKvjRTWmMyRyp6lcZ2ZDd4
         cJ8lms++7bQTowQSW8zbFO7sBLgQusVcSKNwkjiMxVmBtAGq0/BmYxwujvQG8JUovQDk
         rUtewJ+qVeGZu8NYHXRuyq4JPr6zlCqFfY6o4tqiQyPkJfwhmjWaLZiYO6J3u/hSgN4g
         +831ZxHi2wMDBRR3s3z536Dh6Jxx93eNScxNhmbxpcsO8IG2iRQT1Mnon/tGJiZ6+2j6
         xLAA==
X-Received: by 10.107.18.104 with SMTP id a101mr4119580ioj.51.1432243488963;
        Thu, 21 May 2015 14:24:48 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:19:f810:32d8:695f])
        by mx.google.com with ESMTPSA id 71sm64793ioe.16.2015.05.21.14.24.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 21 May 2015 14:24:47 -0700 (PDT)
In-Reply-To: <20150521103617.GA6159@yoshi.chippynet.com> (Paul Tan's message
	of "Thu, 21 May 2015 18:36:17 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269664>

Paul Tan <pyokagan@gmail.com> writes:

> So, here's the re-rolled patch.

Sigh, too late.

I thought the previous round was good enough and the patch is
already on 'next'.

If the incremental change is still worth doing on top, please do so.

Thanks.
