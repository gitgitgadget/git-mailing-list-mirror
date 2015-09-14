From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: accelerators for the main menu
Date: Mon, 14 Sep 2015 11:51:45 -0700
Message-ID: <xmqq7fnsx29q.fsf@gitster.mtv.corp.google.com>
References: <1441804853-28346-1-git-send-email-giuseppe.bilotta@gmail.com>
	<20150913122451.GB12913@fergus.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@ozlabs.org>
X-From: git-owner@vger.kernel.org Mon Sep 14 20:51:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbYr2-0000wT-7z
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 20:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbbINSvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 14:51:47 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35845 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751357AbbINSvr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 14:51:47 -0400
Received: by padhk3 with SMTP id hk3so151049649pad.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 11:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wMBpNgNPzpWA0uwmZl05B7Qgk4Ovl9fHsgvy/nxr+yI=;
        b=SBNAiW5qKaYBFx5+ROaXVBQ/5hpdGFhtIuoI99Mv477D7DlDs8KtJ1N4TmQqU4yn+6
         M0q1BKYBSazQ0dSZ4TzVnxs3O8nGsn9rGCJJZZIkqGr6lKrNqroZi6di2yH99pcomcHI
         uqGlWMyDxetLg1ME3PS7DiYMfTuhXzUUG59rREFAOzW7MCFKX8kfauqbRUlA9IYKIPBE
         DnqxUG+tqI+b7DN61YMK9Q4K/fwBbYUK6KxKlkJnrlSFt72iHONnJ5Ti9wHmd/kUiUrQ
         wFqxB7acOPnt4TqJcJat7U49D53RZ0HFMf2PqLvt+4u/bEhFnizNFfDmbEKWp6Jirsma
         eqrA==
X-Received: by 10.66.121.229 with SMTP id ln5mr36819107pab.133.1442256706695;
        Mon, 14 Sep 2015 11:51:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:611e:bac9:b978:992c])
        by smtp.gmail.com with ESMTPSA id vw7sm17672289pab.15.2015.09.14.11.51.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 11:51:45 -0700 (PDT)
In-Reply-To: <20150913122451.GB12913@fergus.ozlabs.ibm.com> (Paul Mackerras's
	message of "Sun, 13 Sep 2015 22:24:51 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277860>

Paul Mackerras <paulus@ozlabs.org> writes:

> On Wed, Sep 09, 2015 at 03:20:53PM +0200, Giuseppe Bilotta wrote:
>> This allows fast, keyboard-only usage of the menu (e.g. Alt+V, N to open a
>> new view).
>> 
>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>
> Thanks, applied.

Thanks; will pull from you before tagging 2.6-rc2.
