From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [feature request] git add completion should exclude staged content
Date: Mon, 28 Jan 2013 15:02:35 +0100
Message-ID: <510684FB.80104@gmail.com>
References: <20130126172137.GB5852@mobster.11n_AP_Router> <7vip6iteod.fsf@alter.siamese.dyndns.org> <5106444F.2040007@gmail.com> <51067487.9050505@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	wookietreiber <kizkizzbangbang@googlemail.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jan 28 15:03:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzpIj-0002c4-Dm
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 15:03:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756709Ab3A1OCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 09:02:48 -0500
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35107 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755991Ab3A1OCq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 09:02:46 -0500
Received: by mail-wi0-f171.google.com with SMTP id hn14so1432390wib.16
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 06:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=NukcmRaa7RqSSD/HGVwjw9Q96uS9P81lQTFmk+bmyl0=;
        b=duHesvvgdlYCj/Rj5atFdcBPvuffHUuZhRsw/Tr0W/MHdAiD24UJ2qC0fUwbtj43vV
         cHcbqie/6FFVekciEANcJutFgV3oYKmcxhfYpTKse50X8GKb+mB5tk2OvQR9tutlYJkM
         lPK71y/R3Xlpmy4nU+NZhABD7yAYsdzItIiA/8jyOkgfnJJRbF9eXKsgVpuYukiZRq+X
         eCpv2HHaNwud+rmn+ouwzXegS63i5w5dNwv8qnYRueYX4ruXtfZwqyODZfy2lLTyELmh
         D9Ea8j9HUbOFyWRFukFxZuSPPbyXu2U2zWhjpnQAjVXQYgW/wNv8wpNCVV3o4TUmiGgL
         kHHA==
X-Received: by 10.194.90.238 with SMTP id bz14mr21600755wjb.9.1359381765394;
        Mon, 28 Jan 2013 06:02:45 -0800 (PST)
Received: from [192.168.0.3] ([151.70.195.28])
        by mx.google.com with ESMTPS id hu8sm12242593wib.6.2013.01.28.06.02.40
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 06:02:44 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <51067487.9050505@drmicha.warpmail.net>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214836>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 28/01/2013 13:52, Michael J Gruber ha scritto:
> Manlio Perillo venit, vidit, dixit 28.01.2013 10:26:
>> Il 28/01/2013 00:00, Junio C Hamano ha scritto:
>>> wookietreiber <kizkizzbangbang@googlemail.com> writes:
>>
>>>> I have a feature request for `git add` auto completion:
>>>>
> [...]
>> For the OP: the last patch can be found in the mailing list archive,
>> with the subject:
>> 	[PATCH v5] git-completion.bash: add support for path completion
>> and date:
>> 	Fri, 11 Jan 2013 19:48:43 +0100
>>
>> Can you please test it?
>>
> 
> I haven't looked at the patch, but in the example above, untracked
> files) could be added as well (unless you use -u), so maybe the scope
> should depend on the option? If the new completion code kept me from
> adding untracked files easily it wouldn't be an improvement.
> 

The patch will suggest (for git add command), all the files that are
candidate to be added to the index file.

Please, test it and report any behaviour you think is incorrect.


Regards   Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlEGhPsACgkQscQJ24LbaUTYOwCdFagTRkHzUHoFwy3U+Vz6tAzE
tVIAnj8fAbyGrlNUoUgI4ZshwOtlEH8v
=jy8R
-----END PGP SIGNATURE-----
