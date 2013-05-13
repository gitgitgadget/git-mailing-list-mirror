From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] git-prompt.sh: strip unnecessary space in prompt string
Date: Mon, 13 May 2013 15:43:43 +0530
Message-ID: <CALkWK0m+mG39W7RqU-9KfPWLnaey5pL+jvfdZg49ixsASE+QoQ@mail.gmail.com>
References: <1368289513-8700-1-git-send-email-artagnon@gmail.com>
 <1368289513-8700-2-git-send-email-artagnon@gmail.com> <7v61ynsci8.fsf@alter.siamese.dyndns.org>
 <CALkWK0m0dT-sX=nu5jaDj=y1oOSo0cRKQ=2K_S-yepnsm8ny7A@mail.gmail.com> <20130513091718.GA21636@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon May 13 12:14:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbpmK-00071S-Mk
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 12:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719Ab3EMKO3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 May 2013 06:14:29 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:56801 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab3EMKOX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 May 2013 06:14:23 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so11909510iec.22
        for <git@vger.kernel.org>; Mon, 13 May 2013 03:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=tYJzeddN3Ku0BTZhdmc5LAkkmUdZFFbt4KjEtiPCV+k=;
        b=YLiX8i0AJSWOo4VmsmEmw2NeynXusw/kDAUl0Ul2wBaxzqlWmvJ75HvtykvrAQDo9f
         sxmXxCkmYsC4s33HwIsoOBA7lWh1EXq7gDX5r/uvJPns4Ink52n/t/zDsyt447accnJk
         LuGoI0AbEPe7Js73SUR7mfpkzRViuGY5ws3hezcugIik4wWMbh7Fskmjk3iM6PIqzTsP
         xo9RJgMpq8C9YjpxUd7QkKKJyxhNoTK6Z0j17VXG9JazG6mjD6YqgQmsJ+TdY0fwJdXb
         bngQIUNdWJzhm63C6cwNgHEbRlwjWXjKVq3Ck4j3Z68MVU9wTB+V7SEsAuiVy6JhTQWK
         1RqA==
X-Received: by 10.50.3.38 with SMTP id 6mr9529144igz.44.1368440063317; Mon, 13
 May 2013 03:14:23 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 13 May 2013 03:13:43 -0700 (PDT)
In-Reply-To: <20130513091718.GA21636@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224118>

SZEDER G=C3=A1bor wrote:
> Don't forget that others might use a different prompt format and usin=
g
> colors in the prompt is optional.  With the default prompt format and
> without colors I find that that space definitely helps readability.

I'm finding it hard to believe that anyone would want to use a colorles=
s prompt.

> IMHO that's just ugly ;)

If we can agree that it's just a matter of taste, we should both be
able to have what we want.  Any suggestions on how to make this
configurable?
