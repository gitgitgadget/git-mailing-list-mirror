From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 17/19] fsck: Introduce `git fsck --quick`
Date: Fri, 19 Jun 2015 20:24:15 -0700
Message-ID: <xmqqbngb5ag0.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<5f1c4c16027b00ef80490d67bec5e948481153ec.1434720655.git.johannes.schindelin@gmx.de>
	<xmqq1th77829.fsf@gitster.dls.corp.google.com>
	<95e42f21de69ab5299c03ce6ad107037@www.dscho.org>
	<xmqqoakb5sk2.fsf@gitster.dls.corp.google.com>
	<20150619235748.GA23394@odin.ulthar.us>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Scott Schmit <i.grok@comcast.net>
X-From: git-owner@vger.kernel.org Sat Jun 20 05:24:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z69Oa-0007Qv-8y
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jun 2015 05:24:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbbFTDYT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 23:24:19 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:33644 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804AbbFTDYS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 23:24:18 -0400
Received: by iebgx4 with SMTP id gx4so85760344ieb.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 20:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=GGo7DpYwl1q1a/UlVnKMQRj1nV5o5CHBP4S63+KZSO0=;
        b=B4MpgEnCcNEj9TbAsKlqUzk04zu0oLVDtT5Z6dDfEWu0disADPxrtXo613BXNODfmr
         9fGNZoORe/S9Ck4aRsYcvE1zE3PgzggEWmTCEa3h4XsOeWplswvxXnp7Mhnf5itBZ9Vh
         N8bA/upxvJPOW5Xxvx3lTaJ5gfMvY7ki2zfkZf22eNf8R8GgwlOv+U1wA08N52u0HFPn
         IRXhyiSxyQ9rSK6F8BCElwr/A0nXXke6EvLtcqCmFJkZWTpa2BWl3djFM0WW1/ieHcm4
         77QA0HjKafDqA3qeHAzaOokrHi+gil7Yrt2NPUZPauDjwmRu/9PLb5v7c+iXNWMBaEVI
         hdGg==
X-Received: by 10.50.134.196 with SMTP id pm4mr7785144igb.6.1434770657642;
        Fri, 19 Jun 2015 20:24:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id ot6sm3038697igb.11.2015.06.19.20.24.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 20:24:16 -0700 (PDT)
In-Reply-To: <20150619235748.GA23394@odin.ulthar.us> (Scott Schmit's message
	of "Fri, 19 Jun 2015 19:57:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272221>

Scott Schmit <i.grok@comcast.net> writes:

> On Fri, Jun 19, 2015 at 01:53:01PM -0700, Junio C Hamano wrote:
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > Can you think of a name for the option that is as short as `--quick`
>> > but means the same as `--connectivity-only`?
>> 
>> No I can't.  I think `--connectivity-only` is a very good name that
>> is unfortunately a mouthful, I agree that we need a name that is as
>> short as `--xxxxx` that means the same as `--connectivity-only`.  I
>> do not think `--quick` is that word; it does not mean such a thing.
>
> How about `--linkage` or `--links`?

Even though "link" may be shorter than "connectivity", the real
difficulty is to come up with a phrase that conveys the "-only" part
of the fully spelled name, which is more important, without spending
5 letters that take to say "-only".
