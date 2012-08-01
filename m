From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCH/RFC] grep: add a grep.patternType configuration setting
Date: Thu, 02 Aug 2012 00:19:15 +0200
Message-ID: <876292ntlo.fsf@gmail.com>
References: <1343845781-69246-1-git-send-email-dark.panda@gmail.com>
	<7vpq7ae0pj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: J Smith <dark.panda@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 00:20:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwhGy-0006fy-Aj
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 00:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756076Ab2HAWT0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Aug 2012 18:19:26 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:62425 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab2HAWTZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Aug 2012 18:19:25 -0400
Received: by weyx8 with SMTP id x8so5428117wey.19
        for <git@vger.kernel.org>; Wed, 01 Aug 2012 15:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        bh=h3Gsmqudc8W5NamPwZlaog1oyH8S1VqUP9pINIDQxK8=;
        b=mvRsvZ61XXztV0gXtBuWid9bJRWjpTRmdR2zEqCOeuVc3X6IaCXPu38TNrrtUJNXRc
         ga/fOJ9Ur8K7yjlslbaNeYmke3SrX9HPo498iH0lFB+99zh8NUwfq7Y9ejPPNIypw01t
         5BUCE5BqvNazT03A6QVYrkUe8CX0l2aR8y0Y3aaJZgpDMOWf7MSKWhP1ymLi2QEn2y9D
         O5eYzDzM+3i4Tu7RJLLWDBLVIV42/hV3veWXHNz31tJQSj/SXbpj2IY8Qz1jtIiEfoGS
         YC5hRiXvGIh5Uko8fXDL2j7gy7NwLkbp7C2cw03J911E2DTClhh3EXJoGXV3Bd6AK0a9
         XUXw==
Received: by 10.180.78.2 with SMTP id x2mr19891659wiw.10.1343859563861;
        Wed, 01 Aug 2012 15:19:23 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz. [90.177.119.176])
        by mx.google.com with ESMTPS id k20sm30286524wiv.11.2012.08.01.15.19.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Aug 2012 15:19:18 -0700 (PDT)
In-Reply-To: <7vpq7ae0pj.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 01 Aug 2012 14:55:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202734>

On Wed, 01 Aug 2012 14:55:52 -0700
Junio C. Hamano wrote:

> J Smith <dark.panda@gmail.com> writes:
>
>>  grep.extendedRegexp::
>> -	If set to true, enable '--extended-regexp' option by default.
>> +	If set to true, enable '--extended-regexp' option by default. This
>> +	option is ignored when the 'grep.patternType' option is set.
>
> We are not going to make grep.patternType a boolean, so "when ... is
> set" is fine, but if we were to allow grep.patternType to be set to
> "false", the description gives ambiguity to some readers who do.
> Perhaps s/is set/is given/ is safer.

I'm not a native speaker, but to me "is given" implies command line (th=
e
meaning is clear here, it just sounds a bit weird). If it's not just me=
,
"is used" or "has a value" might be better.

--=20
=C5=A0t=C4=9Bp=C3=A1n
