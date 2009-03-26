From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH TopGit] hooks/pre-commit.sh: fix bashism
Date: Thu, 26 Mar 2009 15:21:58 +0100
Message-ID: <36ca99e90903260721l128efcbep1a45d7639733e49d@mail.gmail.com>
References: <1237981384-7857-1-git-send-email-bert.wesarg@googlemail.com>
	 <20090326090009.GA7570@pengutronix.de>
	 <49CB4B12.3020408@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org, martin f krafft <madduck@debian.org>,
	Marc Kleine-Budde <m.kleine-budde@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
X-From: git-owner@vger.kernel.org Thu Mar 26 15:24:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmqVE-0001Hd-Fs
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 15:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757510AbZCZOWE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 10:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757005AbZCZOWD
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 10:22:03 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:56654 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756863AbZCZOWB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 10:22:01 -0400
Received: by ewy9 with SMTP id 9so587485ewy.37
        for <git@vger.kernel.org>; Thu, 26 Mar 2009 07:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iXnuR+T04sXOsYYpcpOhzqBs65L/1dTGACL3vHsUF8M=;
        b=oeDcoAyT49th9V8P+odcyhB8OIJg4EOIqLUJ/Ac7CF63WzmwmWc/CYu9QWsYcdSUGb
         q/I/knGritZ0FWpt0CaM6EKayJrtC+kAMUuHVrFEFAbpjsW5VhIhNzxUPewZODdFCp/W
         c+R/wXKdZojADNY0OIz2BuecWTsGyDPT5vkQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h6GIGjJrNYAXBH2JZ2i87q3ZyAtCSSCXXu4DCJHWOugkjvitfKfKbjOJ9rS+La4/BE
         CLK++A3MQZ/MtkJZGNMp53PccQ5hQ49nWxR3R/Jp6/3juBlECkciwVYaBfkxMwGwfBBR
         HtQzJ4JDYFCkxzytNoHFEiwzVlskAgGzjWLtU=
Received: by 10.210.35.17 with SMTP id i17mr681105ebi.77.1238077318793; Thu, 
	26 Mar 2009 07:21:58 -0700 (PDT)
In-Reply-To: <49CB4B12.3020408@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114781>

2009/3/26 Marc Kleine-Budde <mkl@pengutronix.de>:
> Uwe Kleine-K=C3=B6nig wrote:
>> This was introduced in fcb488d51e72c7414f9beb40ad06bf529b8b38dc.
>> A similar fix was suggested by martin f krafft, too.
>
> Works here on ubuntu bin /bin/sh is a link to /bin/dash
>
>> Reported-by: Bert Wesarg <bert.wesarg@googlemail.com>
>> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de=
>
> Tested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Acked-by: Bert Wesarg <bert.wesarg@googlemail.com>
Tested-by: Bert Wesarg <bert.wesarg@googlemail.com>

Thanks Uwe.

Bert
