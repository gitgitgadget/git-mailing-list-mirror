From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] t4300 (rebase): don't unnecessarily set GIT_TRACE
Date: Fri, 10 May 2013 12:07:05 -0700
Message-ID: <20130510190705.GA3478@elie>
References: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
 <1368196178-5807-5-git-send-email-artagnon@gmail.com>
 <7vmws2529j.fsf@alter.siamese.dyndns.org>
 <CALkWK0k_ArM9EpY0S7=mbgFpHsoauZCr9e=ESX_CEA5-vRHrHQ@mail.gmail.com>
 <7vr4he3kpz.fsf@alter.siamese.dyndns.org>
 <CALkWK0kLjf=m-_9PkXzxOpnpqfh-n004E0f7_mi-VL3SbYWFAg@mail.gmail.com>
 <7vk3n6206h.fsf@alter.siamese.dyndns.org>
 <CALkWK0kTvwxMFGUqH0wKNVpLg-qQQbN+vOcAxiEwmOeDe=87jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 10 21:07:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uasf4-0002JE-R2
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 21:07:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479Ab3EJTHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 15:07:16 -0400
Received: from mail-bk0-f52.google.com ([209.85.214.52]:53732 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285Ab3EJTHO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 15:07:14 -0400
Received: by mail-bk0-f52.google.com with SMTP id q16so2190277bkw.39
        for <git@vger.kernel.org>; Fri, 10 May 2013 12:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=LysuufRYrKSCePjFE//RwAlIkylUpgrnciCEVddQ2AM=;
        b=dKBUQStNchb2HXCHWaCclZdBv1EV97mLoim5+viK/Zcp3rEz9eV3iDI0K+x/0ZKdvt
         leqzx5/pGr8GRhM0D9LjdFp8HqNGsbnWLolEa62MXWrITNgt3U7fwJZDn5HpCikplzIY
         NchJgsaPHFaheqYFh5o2UYazcNfuRotVRzaZf0rx0RbuzH6oEFF27iGIkMjVLAzrIPZE
         GDweyDx2pisUuvUzum4KaeSaxJFVTGTQr0dTBIvsbSUkN8MAoPoqEF9ecIYE3je+2Fi7
         w4oJkVU4DHFgrUkvldAA6nIU5jB3lh8QADSDEfTI3sPxFPNsi/mw3k8f5nQnO340BEEb
         nTog==
X-Received: by 10.204.195.67 with SMTP id eb3mr4737522bkb.107.1368212833415;
        Fri, 10 May 2013 12:07:13 -0700 (PDT)
Received: from elie ([213.221.117.228])
        by mx.google.com with ESMTPSA id i15sm1028380bkz.12.2013.05.10.12.07.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 May 2013 12:07:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CALkWK0kTvwxMFGUqH0wKNVpLg-qQQbN+vOcAxiEwmOeDe=87jA@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223894>

Ramkumar Ramachandra wrote:

> Quite frankly, I think -v is completely useless; who likes to scroll
> through pages of terminal output?

I use "-v -i" together quite frequently when debugging.  I also use
"-v" automatically to debug test failures when tests are invoked
automatically on machines I do not have access to.

Please don't break it.

No particular opinion about the use of GIT_TRACE here: I haven't
looked at it closely (and in particular I didn't look up the purpose
of the commit that added it, so I can't really judge).

Thanks,
Jonathan
