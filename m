From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH 3/7] i18n: Rewrite gettext messages start with dash
Date: Sat, 21 Jul 2012 18:23:16 +0200
Message-ID: <500AD774.4030008@gmail.com>
References: <cover.1342884458.git.worldhello.net@gmail.com> <a7d2248051ddc62e38e67d9efbb41c01498c7a4c.1342884459.git.worldhello.net@gmail.com> <0fd901035a418562d3d9282553a96124814a298a.1342884459.git.worldhello.net@gmail.com> <77cbbce0450735a66ef1d9101af0bc82e3fc545c.1342884459.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 18:23:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SscSl-0000TO-OI
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 18:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890Ab2GUQXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 12:23:23 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:64538 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754Ab2GUQXW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 12:23:22 -0400
Received: by bkwj10 with SMTP id j10so4170946bkw.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 09:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=XIzd9qnnHdk/j7YY6smB/b2ggiDgmaI9ZsVFfDlfy8E=;
        b=fiY99+MdaB/Cir/2m6/BUlcROpeHr8efumonc/lS+04y1FODpV8TrYL0Tdll5g04jC
         Ar6+u1wJK7yKDHsq02mT/AWGR7FG7wEatvrUxhE4evUbtmTISunn5IEmERWcNHcBQ6i6
         2ZV+WsVBgYAyzNDqALh9mcBtu/MJjdWJ2Xs9rXvglMN/Ik9NUeAjnwgAKpp388d1XaDa
         xwXL+q/M2uy1yJ3pxifcFK8Q/sgiuqy1ChXzaIe88ycqsaDh0Jgm99JRmZ9tTJdoFSgH
         43UU5ud8l4c+DFhoLzD+MmN57OwRA9+nddOpDFMunfsANSA+4oJeyxCfM4aNlawKnRcT
         Nx/w==
Received: by 10.205.135.146 with SMTP id ig18mr4830004bkc.80.1342887801341;
        Sat, 21 Jul 2012 09:23:21 -0700 (PDT)
Received: from [192.168.178.21] (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id hg13sm4258348bkc.7.2012.07.21.09.23.19
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2012 09:23:20 -0700 (PDT)
In-Reply-To: <77cbbce0450735a66ef1d9101af0bc82e3fc545c.1342884459.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201824>

On 07/21/2012 05:50 PM, Jiang Xin wrote:
> Gettext message in a shell script should not start with '-', one
> workaround is adding '--' between gettext and the message, like:
> 
>     gettext -- "--exec option ..."
> 
> But due to a bug in the xgettext extraction, xgettext can not
> extract the actual message for this case. Rewrite
>
s/Rewrite/Rewriting/ I think.

> the message is a simpler and better solution.
> 

Regards,
  Stefano
