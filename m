From: Jarkko Hietaniemi <jhi@iki.fi>
Subject: Re: wishlist: make it possible to amend commit messages after push
 to remote
Date: Fri, 07 Aug 2015 13:10:23 -0400
Message-ID: <55C4E67F.7050109@iki.fi>
References: <55C3FA66.90805@iki.fi> <xmqqd1yzyqzq.fsf@gitster.dls.corp.google.com>
Reply-To: jhi@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 19:10:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNlA7-0000GC-C0
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 19:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932479AbbHGRK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 13:10:27 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:33817 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932473AbbHGRK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 13:10:26 -0400
Received: by qgeg42 with SMTP id g42so42252198qge.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 10:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:reply-to:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=gtzsWL+CPapHxSz35foqIm33gu3iYpRwBufw6pWzoP8=;
        b=INRNWNX3vtra+YAU9j+sxD7YMgdqZ6wa0lCEsuEsnDs8mMvDObBTJyZQE3u4raJD9H
         WP0lNbHI/ErzMs3anu/vVgekjIbbV/kDOXmFRn2vWQqtAQREQ2yW6VVS11uqivijxy/C
         J09GmRNm2k+KiRekAwSpBKZzeNVt5Y1khFy9Pa8YZZalSzmBtXdjxDMypbbfLtNqX8FV
         i3+KrVk2st/imvaNYtgwOSpBXmd2UJNSxYEAwiySMTJw8NJLTrWlu6FkPDOaVe/aPToa
         uF2pQ59HKnJ7bwWmojRDDWeACPel+9e/BWlqxl3GuMK0wknsgjVCOmps6837ePaeX2YY
         Cjeg==
X-Received: by 10.140.195.210 with SMTP id q201mr15259246qha.54.1438967425762;
        Fri, 07 Aug 2015 10:10:25 -0700 (PDT)
Received: from Vredefort.local ([2601:18f:200:9bed:2cc6:5d87:5be1:8daf])
        by smtp.gmail.com with ESMTPSA id z18sm5275914qkz.3.2015.08.07.10.10.25
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Aug 2015 10:10:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqd1yzyqzq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275473>

On Friday-201508-07 12:59, Junio C Hamano wrote:
> You need to learn to consider the act of publishing as casting
your work in stone to give other people solid foundation to build
on.
> ...
> If you really "get" it, you wouldn't be complaining about the
> "impossibility" part;-)

I wasn't suggesting taking away the original SHA.

But to be honest, I wasn't expecting a miracle cure.  I guess the core
of my gripe is just that: how the commit message is part of the SHA.
But that's part of the SHA and genome of git.  In other words:
"sorry dude, you are out of luck".
