From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [feature request] git add completion should exclude staged content
Date: Mon, 28 Jan 2013 21:16:07 +0100
Message-ID: <5106DC87.7090607@gmail.com>
References: <20130126172137.GB5852@mobster.11n_AP_Router> <7vip6iteod.fsf@alter.siamese.dyndns.org> <5106444F.2040007@gmail.com> <51067487.9050505@drmicha.warpmail.net> <510684FB.80104@gmail.com> <5106A5CE.3000800@drmicha.warpmail.net> <7vd2wpxki1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	wookietreiber <kizkizzbangbang@googlemail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 21:16:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzv8I-0003lr-MO
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 21:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759Ab3A1UQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 15:16:18 -0500
Received: from mail-we0-f181.google.com ([74.125.82.181]:54561 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717Ab3A1UQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 15:16:16 -0500
Received: by mail-we0-f181.google.com with SMTP id t44so1760817wey.12
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 12:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=+ucGw51jNqth1wsN7UVVViNHgs+/ly1/9UK+biHBauo=;
        b=iGTd4NlYaidkPgTq56k0KAJmYP+kLUobrENKUjdDO6hUf0mYKkYeiswDrrEWEzYK5Q
         9KQ1Dqt6xdYPPyAQTHrGX7GFjGyhlK/VkDDJHgFy6URaHZxFizzepSkZVNP/akFsRBaj
         kQZF5Rg2VfO+SZQMReyx71+7OU/ps3sZaGSauZs6ovmt9N791ByUChsUdo7il5KgOj6O
         o5/Y6/pUxYW9wrwz0F9CpJwOMbZ4lFAYN0fuUudMBmTtE+Xcp99AyRfNYGnJZhb3oJ1E
         xYIoqcf19msyhrFAqlitFH/O93MH6H9UFEWj11KwnxQA3Wq0/hU5RifzD1IdZvYJxFUZ
         3lxA==
X-Received: by 10.180.81.39 with SMTP id w7mr12027876wix.15.1359404174994;
        Mon, 28 Jan 2013 12:16:14 -0800 (PST)
Received: from [192.168.0.3] ([151.70.195.28])
        by mx.google.com with ESMTPS id eo10sm15173681wib.9.2013.01.28.12.16.12
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 12:16:14 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <7vd2wpxki1.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214863>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 28/01/2013 18:52, Junio C Hamano ha scritto:
> [...]
> 
> Thanks both for commenting.  I'll find time to read it over again
> and perhaps we can merge it to 'next' and advertise it in the next
> issue of "What's cooking" report to ask for wider testing to move it
> forward.

Thanks.

I will try to update the patch, with your latest suggestions (avoid
tricky POSIX shell syntax, and CDPATH issue - if I remember correctly),
and with an update for the t/t9902-completion.sh test (that I completely
missed).



Regards  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlEG3IcACgkQscQJ24LbaUTR/wCfSC/kHxseKAQ9rnK2ba/WwND1
cmsAn2CuHpRs2VjippTwkT5O3ul9cQKb
=5Way
-----END PGP SIGNATURE-----
