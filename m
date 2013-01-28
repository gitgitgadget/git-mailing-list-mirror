From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [feature request] git add completion should exclude staged content
Date: Mon, 28 Jan 2013 10:26:39 +0100
Message-ID: <5106444F.2040007@gmail.com>
References: <20130126172137.GB5852@mobster.11n_AP_Router> <7vip6iteod.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: wookietreiber <kizkizzbangbang@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 10:27:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzkzl-0008SG-SZ
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 10:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755690Ab3A1J0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2013 04:26:55 -0500
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36216 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754241Ab3A1J0v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2013 04:26:51 -0500
Received: by mail-wi0-f177.google.com with SMTP id hm14so148820wib.4
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 01:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=cTC6e//zULFbKvv9QxsrJwApi8x1M6SJ99/RjnUSXUM=;
        b=gLn2VPLvaVU81Hfhyo6fUE0EW1bgP1y5YouJMvHEgxmHDlNvniCnK5yIck4d9PLqmd
         xy7bGIEjcrLaasxHUEgKB8+D+W4H6axuJbevpi5kDE780fj/DAQ/zFQ89F+y2jROPWBK
         uZcxbv57S6Z34By+8LPk8+wIePtjyr9w7YynAgyw7C5er0uYUEX5nOraessuPvEHLXtd
         OrkTpZS6c3jY6ecljvT3K6AKMd/he9/xSXx9D5yU8F11C2XLgUb57BbwvUIbiUvkpLmb
         PpnCDvCKl3HlrsZGK4dVIx3iawivdlMD/Ze5Eb96mLmQV/naWRbp+ZZUiJb5EQStxVpJ
         biZg==
X-Received: by 10.194.177.199 with SMTP id cs7mr19858937wjc.41.1359365210294;
        Mon, 28 Jan 2013 01:26:50 -0800 (PST)
Received: from [192.168.0.3] ([151.70.195.28])
        by mx.google.com with ESMTPS id ge2sm5292748wib.4.2013.01.28.01.26.48
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Jan 2013 01:26:49 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <7vip6iteod.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214825>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 28/01/2013 00:00, Junio C Hamano ha scritto:
> wookietreiber <kizkizzbangbang@googlemail.com> writes:
> 
>> I have a feature request for `git add` auto completion:
>>
>> `git add` auto completion suggests all files / directories,
>> filtered by nothing. I guess it would be much nicer (as in
>> increasing productivity) if it would only suggest unstaged
>> content, as reported by `git status`, because that would be the
>> only content one would be able to add.
> 
> I think that is what Manlio Perillo tried to do with the stalled
> mp/complete-paths topic that is queued in 'pu'.
> 
> Manlio, any progress?

Well, I assumed that the patch was stalled due to missing review from
git completion experts...

For this reason I have not updated it with your latest suggestions,
waiting for the review (also, because now I'm busy with other projects).

For the OP: the last patch can be found in the mailing list archive,
with the subject:
	[PATCH v5] git-completion.bash: add support for path completion
and date:
	Fri, 11 Jan 2013 19:48:43 +0100

Can you please test it?




Regards   Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlEGRE8ACgkQscQJ24LbaUSX9ACfUMBH/X6lVH4V7FUaB2wlqj8C
eYQAnAzuYwhYhDvkW3d29IeqHsDFyWBT
=BpRi
-----END PGP SIGNATURE-----
