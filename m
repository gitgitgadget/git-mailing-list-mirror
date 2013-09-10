From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH v6 0/8] Multiple simultaneously locked ref updates
Date: Tue, 10 Sep 2013 12:54:54 -0400
Message-ID: <522F4EDE.1010104@kitware.com>
References: <cover.1378732710.git.brad.king@kitware.com> <cover.1378773895.git.brad.king@kitware.com> <xmqqob80zlju.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 18:57:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJRFW-0001Ik-Of
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 18:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731Ab3IJQ5G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 12:57:06 -0400
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:57002 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752546Ab3IJQ5E (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Sep 2013 12:57:04 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]) (using TLSv1) by na3sys009aob113.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUi9PX8AtAjMHlbloCYONPAqlATwTEXKq@postini.com; Tue, 10 Sep 2013 09:57:04 PDT
Received: by mail-ob0-f180.google.com with SMTP id va7so2454159obc.39
        for <git@vger.kernel.org>; Tue, 10 Sep 2013 09:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=h88MLcs2y3NVXvrLLAvRzAoc+tL72OW+6hrBLw5xyxU=;
        b=FKe/w4SEhuppvJd8tSQrShbL6WtoRG6SkegW3cFUNG7djg+xgpT6Mt6Q+GGE7Ortul
         NCbILbU6KAmR+mokhowYZdMDStCMAsofP9CYDOZSf0607iOyMMVAWfCm+2Xk/J+qKh6g
         kbFcmWqg0H/UfkvqhV+kKegiRaRyUTtjOUYptZD08sLP7EU5S6LZbd55dmgnKkwQTLa0
         YJQs0n1ibm1Diiab1pTuXBl7O4ptgYTMEnHjH6l6pvHK2JYItZxNUFh1MEX04D9mIJbg
         G2dpG59ycz125u4UjII/G7rGdGS2sq9EdJ86ozXWPDLP1QJwVwYzUyYP6EVihd3c1qRO
         WYNw==
X-Gm-Message-State: ALoCoQnJ//2YvdzmDwmwrzCCYum7IX4dgXJmot56FOF8TEfgTZSzbM+DnR0K/TPvyzZMPVp8pNWhom4yvls1pYya+m0VZodSeaxbYYjhAet27JKXwbgWMWPYPuK27DC2fcDmlZSH+39Ps84B+vkdWHgO++r8P/7DBg==
X-Received: by 10.182.213.97 with SMTP id nr1mr16377215obc.48.1378832223250;
        Tue, 10 Sep 2013 09:57:03 -0700 (PDT)
X-Received: by 10.182.213.97 with SMTP id nr1mr16377204obc.48.1378832223169;
        Tue, 10 Sep 2013 09:57:03 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id tz10sm21429380obc.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 10 Sep 2013 09:57:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <xmqqob80zlju.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234444>

On 09/10/2013 12:30 PM, Junio C Hamano wrote:
> Thanks.  I am not sure if I should rewind and rebuild the series
> with these patches, though.  This is a new feature and does not have
> to be merged to 'maint', so rebasing is perfectly fine, but it is
> not strictly necessary, either.

I just thought I'd help out with the conflict resolution.  If you're
happy with resolving the conflicts in v5 then there is no reason to
use v6.

Thanks,
-Brad
