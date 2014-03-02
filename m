From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] implemented strbuf_write_or_die()
Date: Sat, 1 Mar 2014 21:55:52 -0500
Message-ID: <CAPig+cRXSQkC6eG+TAZQoZ5kJNjuv9Rq5QYjpFbEqDSeuVWU3g@mail.gmail.com>
References: <53126051.7030904@alum.mit.edu>
	<1393719527-24221-1-git-send-email-faiz.off93@gmail.com>
	<CAPig+cR0gTeB1oUUPQ=W_wWGPMDaY4gkG7+531HT-ktnwn5L-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Sixt <j6t@kdbg.org>, He Sun <sunheehnus@gmail.com>
To: Faiz Kothari <faiz.off93@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 03:55:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJwZK-00013x-Hs
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 03:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753470AbaCBCzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 21:55:54 -0500
Received: from mail-yk0-f175.google.com ([209.85.160.175]:56579 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbaCBCzx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 21:55:53 -0500
Received: by mail-yk0-f175.google.com with SMTP id 131so5337878ykp.6
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 18:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Py45VWh4n3n9BjBZos2jULw3vqqW5wjp6Btz4ES1GU4=;
        b=InNBM3zbWMlOI5Cxa2JiSZLKvTWgA3dCQH2HC8gKC69aomV34Yjx9P8LyRp4ehRQ4K
         bmcTjo93weWnEAGp+EoULPZprls+FUBl3F68LNZEeX1KNplQCQe7mIobWXn8RR+cnbWF
         5Fz6dPpObdHU1cKMvc2lcdyL+iDVgjjCQLy+ZnoaQlImG40FL2jugPoD4KRPfsaZLs3A
         ZYEctMLZaVL4LGjR7Ams/GQS0zdlFbx4BfpZBM3rAauGirhzReZo+39M1T974L66grSE
         zri4+79w0tl3NsJSCwes9uzom8PzRwXaH2YhhmmSiXZsE5uJNCF9IxMTX9aGfWeNsQ30
         sbjw==
X-Received: by 10.236.137.14 with SMTP id x14mr12752210yhi.4.1393728952941;
 Sat, 01 Mar 2014 18:55:52 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sat, 1 Mar 2014 18:55:52 -0800 (PST)
In-Reply-To: <CAPig+cR0gTeB1oUUPQ=W_wWGPMDaY4gkG7+531HT-ktnwn5L-Q@mail.gmail.com>
X-Google-Sender-Auth: FS81dyKk2b-HRuZxxU_8hY0qZ-M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243125>

On Sat, Mar 1, 2014 at 9:47 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sat, Mar 1, 2014 at 7:18 PM, Faiz Kothari <faiz.off93@gmail.com> wrote:
>> Implementing this clearly distinguishes between writing a normal buffer
>> and writing a strbuf. Also, it provides an interface to write strbuf
>> directly without knowing the private members of strbuf, making strbuf
>> completely opaque. Also, makes the code more readable.
>
> These three sentences which justify the change should go above the
> "---" line so they are recorded in the project history for future
> readers to understand why the change was made. As for their actual
> value, the first and third sentences are nebulous; the second sentence
> may be suitable (although strbuf's buf and len are actually considered
> public, so the justification not be supportable).

...justification *may* not be...
