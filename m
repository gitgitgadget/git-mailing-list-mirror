From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/11] parse-options.h: add macros for '--contains' option
Date: Mon, 15 Jun 2015 12:27:20 -0700
Message-ID: <xmqqbngg93hj.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZRA7jVhs-NixjP+EFqfBNwLEfU-WgEMMQzb5NC+HZDYiw@mail.gmail.com>
	<1434226706-3764-1-git-send-email-karthik.188@gmail.com>
	<1434226706-3764-9-git-send-email-karthik.188@gmail.com>
	<CAP8UFD02qxKJYJ=hg7ZWsvUZfJe85CY-v2V-64swdxnibF=mmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 21:27:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4a2b-0002vf-NA
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 21:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbbFOT1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 15:27:24 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:32994 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbbFOT1X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 15:27:23 -0400
Received: by ykfr66 with SMTP id r66so64857377ykf.0
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 12:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=faRhROHe+w5a3edbSbc55TQiV1RkgZnHtvP5XdRPbbo=;
        b=TdbRYEQSFtC0gw101CWfutNzgFnb1E4RhSpPD+OVRXhFRtNnoektRPAHctBJ2ghl13
         e7E7Aybdf62pzlksvnDOkUhG0yhMJrOOsss8EOBs0VtJFgAQikDKTJD8eQMB/ucByssM
         4evUtNbF8uwISx8XAPZ5kHfHkRcS7Y+7mDqieaSidFmEacBcoRT9xEU2fEgY34toWaGz
         P3BjBRDsBL69hBMmbO7NILDnix+DhQQ3e5U0w2dXoLZh1UZkkdGYyC48pROG6ivC58vN
         4sFudIxGJbcngAKbXciajWs9P2jJfjImeJbLoTVu8txp22WZsrODBH1CQlEeZWpV4XIi
         JfVg==
X-Received: by 10.129.52.129 with SMTP id b123mr35808980ywa.58.1434396442635;
        Mon, 15 Jun 2015 12:27:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:16f:c4ab:c37f:75f8])
        by mx.google.com with ESMTPSA id g39sm1389227yhb.25.2015.06.15.12.27.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jun 2015 12:27:21 -0700 (PDT)
In-Reply-To: <CAP8UFD02qxKJYJ=hg7ZWsvUZfJe85CY-v2V-64swdxnibF=mmg@mail.gmail.com>
	(Christian Couder's message of "Sun, 14 Jun 2015 08:13:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271709>

Christian Couder <christian.couder@gmail.com> writes:

> The PARSE_OPT_HIDDEN flag is removed below. This means that "--with"
> will appear in the "git tag -h" output, which means that "--with"
> should appear in the documentation...
> The commit message may also want to tell that with is not hidden any more.

Or why is it a good idea to stop hiding.

I would prefer to keep it hidden to avoid "what's the difference
between the two" confusion.
