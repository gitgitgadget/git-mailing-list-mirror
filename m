From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 09/11] parse-options.h: add macros for '--contains' option
Date: Tue, 16 Jun 2015 02:19:09 +0530
Message-ID: <CAOLa=ZROvzZD2Qz6gMLeciipJRyAGR5q3isR9zOih9v=GP17EA@mail.gmail.com>
References: <CAOLa=ZRA7jVhs-NixjP+EFqfBNwLEfU-WgEMMQzb5NC+HZDYiw@mail.gmail.com>
 <1434226706-3764-1-git-send-email-karthik.188@gmail.com> <1434226706-3764-9-git-send-email-karthik.188@gmail.com>
 <CAP8UFD02qxKJYJ=hg7ZWsvUZfJe85CY-v2V-64swdxnibF=mmg@mail.gmail.com> <xmqqbngg93hj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 22:49:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4bKE-0006A8-9i
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 22:49:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756019AbbFOUtl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 16:49:41 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:34862 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756002AbbFOUtk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 16:49:40 -0400
Received: by oiax193 with SMTP id x193so10048406oia.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 13:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=IjMaOxYEP63OEz1DzJSKuMp4VZyV/mWyVGcmnrCOWJM=;
        b=fGw1hlIoYLuvk+kNh7p/Wgp2z6a8vlF/VD5AE6QRqF5kmt+dWQYZwi6j2mFUResaw9
         /rzc1pPVG6lCeHZUpvcTwCXbwwu2oXYE+J9Dgw9yYQCeQd7TXxYJH36H0t0dkMTByQaP
         7aaHZ7O8Cw0VKnylQYDugZYX5rh9FB45mFcp6WWAGdOtT/JdMPViGjCmr8mVNL0m+QHJ
         A7Nog+4VE+Ah1uR+Y5qFV28LwUyO+DAy1i39Y9qWVOAAVd6krfhZEn6yY3oiXz/W3lSY
         xj3Nsg9+JG+ZfRNowld35uC9I5qY7puv9y37IV+8EIlYp3fFupXnrubU2vt0srNkv3IC
         4VWA==
X-Received: by 10.60.52.174 with SMTP id u14mr26274717oeo.9.1434401380330;
 Mon, 15 Jun 2015 13:49:40 -0700 (PDT)
Received: by 10.182.95.165 with HTTP; Mon, 15 Jun 2015 13:49:09 -0700 (PDT)
In-Reply-To: <xmqqbngg93hj.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271726>

On Tue, Jun 16, 2015 at 12:57 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> The PARSE_OPT_HIDDEN flag is removed below. This means that "--with"
>> will appear in the "git tag -h" output, which means that "--with"
>> should appear in the documentation...
>> The commit message may also want to tell that with is not hidden any more.
>
> Or why is it a good idea to stop hiding.
>
> I would prefer to keep it hidden to avoid "what's the difference
> between the two" confusion.

Ok than, will do that.

-- 
Regards,
Karthik Nayak
