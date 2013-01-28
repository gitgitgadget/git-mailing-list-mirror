From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [feature request] git add completion should exclude staged content
Date: Mon, 28 Jan 2013 21:13:25 +0100
Message-ID: <5106DBE5.6040507@gmail.com>
References: <20130126172137.GB5852@mobster.11n_AP_Router> <7vip6iteod.fsf@alter.siamese.dyndns.org> <5106444F.2040007@gmail.com> <51067487.9050505@drmicha.warpmail.net> <510684FB.80104@gmail.com> <5106A5CE.3000800@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	wookietreiber <kizkizzbangbang@googlemail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jan 28 21:14:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzv5l-0002pC-29
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 21:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045Ab3A1UNr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 15:13:47 -0500
Received: from mail-wg0-f42.google.com ([74.125.82.42]:39989 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565Ab3A1UNq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 15:13:46 -0500
Received: by mail-wg0-f42.google.com with SMTP id 12so1495460wgh.3
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 12:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=Mn0MfIjK7YfkW5giUW76ucYHHklhGxGfBGQX8bkRNE8=;
        b=DNdF00704NP24T45/v58I3e5pXXWOALZ2Vex/L0AypohsubD0SdfdsynL5tiDUpAie
         I5hjThyt8tSmLRb+7lFHRedn0oIa4rIYtc5V2VjBV4TlYG7VDpwJ28NCx4f4orMpPp4g
         Xqv7zNvOn79IaPPngNCMm2gJ2+5HF8jFa1ztgOGWaPr9QTAKb0WKFQtBqHr4tYKRLOr2
         McEZE4WFmv2ln9eMq61t7CC/1nIG6WQR/qABIXZv7phy1ciD0ZXgsFICIsQ0vpb1YsQc
         kddFcX5PVywSoKYtvledgjvrQnUjQOAYvLX1UAJRqJppRAGqlyisD9Eu6SfA3kFvbekK
         l5jw==
X-Received: by 10.180.92.129 with SMTP id cm1mr9712787wib.10.1359404024314;
        Mon, 28 Jan 2013 12:13:44 -0800 (PST)
Received: from [192.168.0.3] ([151.70.195.28])
        by mx.google.com with ESMTPS id gz3sm13715536wib.2.2013.01.28.12.13.37
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 12:13:43 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <5106A5CE.3000800@drmicha.warpmail.net>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214861>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 28/01/2013 17:22, Michael J Gruber ha scritto:
> [...]
>> The patch will suggest (for git add command), all the files that are
>> candidate to be added to the index file.
>>
>> Please, test it and report any behaviour you think is incorrect.
> 
> OK, that seems to work and to be quite helpful.
> 
> Minor nit: "git add -u" could use the same fileset as "git commit". But
> I don't know whether completion can act upon the presence of options.

It is possible, but I have not implemented since I was not sure about it
and I wanted to avoid to make the patch more hard to review.

I will work on it after the patch is approved.

> Currently, it also includes untracked files (just like without -u) but
> omits unmodified and ignored ones, which is already quite an improvement.
> 
> I won't be able to review the completion code but may contribute a few
> lines to t/t9902-completion.sh, possibly.
> 

Ah, I missed this test; thanks.

The proposed patch must update it.



Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlEG2+UACgkQscQJ24LbaURstACfdNxuFvaokBSTls20bSQ7jPHA
8I0An3fX6oRKuc2lzAgPVBLjsbjbw91V
=igwr
-----END PGP SIGNATURE-----
