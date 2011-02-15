From: Michael J Gruber <drmicha@warpmail.net>
Subject: Re: [PATCH 6/7] commit,status: describe -u likewise
Date: Tue, 15 Feb 2011 07:53:07 +0100
Message-ID: <4D5A22D3.2080605@warpmail.net>
References: <cover.1297695910.git.git@drmicha.warpmail.net> <959cfaee441413401ddb7ad7fd29f4a98f668bec.1297695910.git.git@drmicha.warpmail.net> <7vei7as82n.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 15 07:56:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpEpe-0001vh-6z
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 07:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023Ab1BOG4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 01:56:13 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51130 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751681Ab1BOG4M (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Feb 2011 01:56:12 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C202E206DA;
	Tue, 15 Feb 2011 01:56:11 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 15 Feb 2011 01:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=EU25OyuCKIDVF+JpSMgMoAMeGvU=; b=WOKoGgExuQtjAanOZGaWU9w8ChQf63Al5/XGcCT+I2i6izRAd8QgLcVWw/C8dr7ZwoIvPv8OEb8Yh3BjafYJYm2Ddb4B2ibMaJ/lm7NsB7AOK9CIHcDQ7UTiFYiDlJqHigEOUT+JWVa4OpZ4jMJMwG9BWyvtV+E3GjukSfiszt8=
X-Sasl-enc: 0KlTsTApRZr0mBiV5ZDwV6jh01sCbYOpxSniPk46NYze 1297752971
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 566A6402327;
	Tue, 15 Feb 2011 01:56:11 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <7vei7as82n.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166816>

Junio C Hamano venit, vidit, dixit 14.02.2011 20:57:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> They differ by one character only. Being exactly equal should help
>> translations.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 8a534de..ef2114b 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -150,7 +150,7 @@ static struct option builtin_commit_options[] = {
>> ...
>> -	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal, no (Default: all)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
>> +	{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, "mode", "show untracked files, optional modes: all, normal, no. (Default: all)", PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
> 
> Makes sense; thanks.
> 
> I however wonder if we have an opportunity for even more unifying these
> two arrays, typing the same thing only once.
> 

I was surprised we have two arrays at all, "status" being "commit
--dry-run". I'll check whether we can remove redundancy without too much
effort.

Michael
