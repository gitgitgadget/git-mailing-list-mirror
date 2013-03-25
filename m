From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH] Documentation/commit-tree: mention -S option
Date: Mon, 25 Mar 2013 16:15:30 -0400
Message-ID: <5150B062.9060303@kitware.com>
References: <14b024f9ee5c6319a0ff1f700f52d29b2464764f.1364240065.git.brad.king@kitware.com> <7v7gkvxn0b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 25 21:16:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKDoR-0005cy-4J
	for gcvg-git-2@plane.gmane.org; Mon, 25 Mar 2013 21:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933217Ab3CYUPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 16:15:44 -0400
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:35886 "HELO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932801Ab3CYUPn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Mar 2013 16:15:43 -0400
Received: from mail-ob0-f197.google.com ([209.85.214.197]) (using TLSv1) by na3sys009aob131.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUVCwbkX873QIYf7RPwFeMmse9GMQaZt+@postini.com; Mon, 25 Mar 2013 13:15:43 PDT
Received: by mail-ob0-f197.google.com with SMTP id ef5so14056060obb.8
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 13:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:x-received:message-id:date:from:user-agent:mime-version
         :to:cc:subject:references:in-reply-to:x-enigmail-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=GfEuLN+skX+gawbl8HF03t9jdUWa+z2r4fWNAjZPVhY=;
        b=hRJK/pXcFa5JQgv9ovovldViGW+EdrM9RVJTndg/CyJM3VFm9ABhbL0Ejk6xCeLeaO
         eSaQiRByuQbh3EyD3AQwd1+pCQKNOs1mpS6PukPSlaO8/XHCLqFXewcUDgFdhe8F1czG
         FPIH5jNOpj7tdpXvPJz7Je7/jChd82cdrjcpkezHWxcZOjswLQ3rNl6x+11/gOSulBdG
         inr14lUxUjCSk4BeYWkAScAkgMMQtbGlhKHC1ttqB+Qm0wgRjdI5dhK5/9ZdWGQhCqMQ
         KLTQhhL1CmTBhzAeKA0ghhvehr+03IKOVG+xQfTnhItuYTfM9uXOX/qqFJf9apaiQMUz
         w/Eg==
X-Received: by 10.60.169.231 with SMTP id ah7mr12008761oec.142.1364242542340;
        Mon, 25 Mar 2013 13:15:42 -0700 (PDT)
X-Received: by 10.60.169.231 with SMTP id ah7mr12008756oec.142.1364242542250;
        Mon, 25 Mar 2013 13:15:42 -0700 (PDT)
Received: from [192.168.1.236] (66-194-253-20.static.twtelecom.net. [66.194.253.20])
        by mx.google.com with ESMTPS id ad19sm16195239oec.0.2013.03.25.13.15.41
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 25 Mar 2013 13:15:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.10) Gecko/20121027 Icedove/10.0.10
In-Reply-To: <7v7gkvxn0b.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4
X-Gm-Message-State: ALoCoQmh9VvT5Z/AFaHIxLvGlDOsBHUPEtu37zrU8MnuGXslaWlCjl6reBt/RCzZ4cUS8qXN5cXfreClkMlSKRSczgSEYv0WXeLm7reAzjy0ssQ28IACP6iXJTPTYA/6a0jYTAmAafezx92gJSd9RKoF9TGY3igCiQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219078>

On 03/25/2013 04:06 PM, Junio C Hamano wrote:
> Brad King <brad.king@kitware.com> writes:
> 
>> Commit ba3c69a9 (commit: teach --gpg-sign option, 2011-10-05) added the
>> -S option and documented it in the command usage.  Then commit 098bbdc3
>> (Add -S, --gpg-sign option to manpage of "git commit", 2012-10-21)
>> documented it in the porcelain manpage.  Use wording from the porcelain
>> to document the option in the plumbing manpage too.
>> ---
> 
> Thanks; sign-off?

Oops!

Signed-off-by: Brad King <brad.king@kitware.com>

-Brad
