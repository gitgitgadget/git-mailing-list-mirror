From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] bisect: print abbrev sha1 for first bad commit
Date: Mon, 11 May 2015 09:38:12 +0200
Message-ID: <CAP8UFD1Aq54dWvxo5JTP4Fqy5u-qhA0LAm3vRrw9=jYg3o_F+g@mail.gmail.com>
References: <1431128763-28453-1-git-send-email-tbsaunde@tbsaunde.org>
	<CAGZ79kYjES6DXmvQdmXLAXrKMGrnvQ-vqJuHQU2QxVC4+6M0aA@mail.gmail.com>
	<20150509014152.GA31119@tsaunders-iceball.corp.tor1.mozilla.com>
	<20150509040704.GA31428@peff.net>
	<20150510231110.GA25157@tsaunders-iceball.corp.tor1.mozilla.com>
	<20150511011009.GA21830@peff.net>
	<xmqqmw1bg2dd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Trevor Saunders <tbsaunde@tbsaunde.org>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 11 09:38:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YriI6-0002gp-Mc
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 09:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752373AbbEKHiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 03:38:14 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:38368 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbbEKHiN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 03:38:13 -0400
Received: by wiun10 with SMTP id n10so85725840wiu.1
        for <git@vger.kernel.org>; Mon, 11 May 2015 00:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=k/qwtLEJY0EbzNY/CT+XtPTluSVpubkOA3lOgO3n46U=;
        b=KoFno9nQvzTPsSZwIpJILLTcEBmW2NtmRuxvcF5MV8yBZIraRwjwdnoUTkp3bS7sx0
         nxlU0P39ayvRPBWt6AysYSy66+FhqROai2AmRatuYdr6fCRB7TI3MfD84SpfIsQt/M+7
         WZmUiwbMgcljawa6U040jIkcw9890N7u8LfJZ38lYfqPGIwEDmWUbS9wmOOSyJ94ZFIs
         kw1NgoVzCCoI44Bdgkv/gl6AJvKKy8cr6O5NtrPhQKU8WuUuYYC6Wn3LkuYZZSKxW0oi
         JFuLltNjn91TNbt1D8uJKlAlkjOSY3rjm+wVQ0l/RqyJ22U1JrxDjjE1blMqkL1W2xEL
         Ev7w==
X-Received: by 10.180.100.227 with SMTP id fb3mr16783707wib.90.1431329892830;
 Mon, 11 May 2015 00:38:12 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Mon, 11 May 2015 00:38:12 -0700 (PDT)
In-Reply-To: <xmqqmw1bg2dd.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268764>

On Mon, May 11, 2015 at 6:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> I'd argue for simply never showing the diff (dropping the "opt.diff = 1"
>> line from bisect.c:show_diff_tree), but that is mostly my personal
>> opinion.
>
> Yeah, I think that is sensible. It may even be OK to just give a
> "log --oneline".

Or maybe we could let the user configure the diff options or even the
command used when the first bad commit is found?
