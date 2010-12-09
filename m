From: =?UTF-8?B?IkFsZWphbmRybyBSLiBTZWRlw7FvIg==?= <asedeno@MIT.EDU>
Subject: Re: [PATCH] git-send-email: Accept -n as a synonym for --dry-run
Date: Thu, 09 Dec 2010 11:21:10 -0500
Message-ID: <4D0101F6.9060602@mit.edu>
References: <1291869878-19645-1-git-send-email-asedeno@mit.edu> <201012091435.02669.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Dec 09 17:21:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQjF9-0007b8-BG
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 17:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155Ab0LIQVO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 11:21:14 -0500
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:55770 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750972Ab0LIQVN (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Dec 2010 11:21:13 -0500
X-AuditID: 1209190f-b7c1dae000000a2b-7d-4d0101f8cc8b
Received: from mailhub-auth-4.mit.edu ( [18.7.62.39])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Brightmail Gateway) with SMTP id 9D.E1.02603.9F1010D4; Thu,  9 Dec 2010 11:21:13 -0500 (EST)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-4.mit.edu (8.13.8/8.9.2) with ESMTP id oB9GLCHi029170;
	Thu, 9 Dec 2010 11:21:12 -0500
Received: from darkmatter.mit.edu (DARKMATTER.MIT.EDU [18.238.2.175])
	(authenticated bits=0)
        (User authenticated as smtp/darkmatter.mit.edu@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id oB9GLApQ018442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 9 Dec 2010 11:21:11 -0500 (EST)
Received: by darkmatter.mit.edu (Postfix, from userid 108)
	id AE75A14C012; Thu,  9 Dec 2010 11:21:10 -0500 (EST)
Received: from asedeno.corp.itasoftware.com (ita4fw1.itasoftware.com [63.107.91.99])
	by darkmatter.mit.edu (Postfix) with ESMTPSA id 9512F14C011;
	Thu,  9 Dec 2010 11:21:10 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101110 Icedove/3.1.6
In-Reply-To: <201012091435.02669.trast@student.ethz.ch>
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163293>

On 12/09/2010 08:35 AM, Thomas Rast wrote:
> Alejandro R. Sede=C3=B1o wrote:
>> diff --git a/git-send-email.perl b/git-send-email.perl
>> index 76565de..7e3df9a 100755
>> --- a/git-send-email.perl
>> +++ b/git-send-email.perl
>> @@ -85,7 +85,7 @@ git send-email [options] <file | directory | rev-l=
ist options >
>>      --confirm               <str>  * Confirm recipients before send=
ing;
>>                                       auto, cc, compose, always, or =
never.
>>      --quiet                        * Output one line of info per em=
ail.
>> -    --dry-run                      * Don't actually send the emails=
=2E
>> +    -n, --dry-run                  * Don't actually send the emails=
=2E
>>      --[no-]validate                * Perform patch sanity checks. D=
efault on.
>>      --[no-]format-patch            * understand any non optional ar=
guments as
>>                                       `git format-patch` ones.
>=20
> Good change by itself, but this is the first short option for
> git-send-email.  Maybe --force should also get its analogous -f alias=
?
> Any others?

Sounds good to me, though I notice that --force isn't in git-send-email=
's
documentation at all.

If we're expanding this patch[set] to include other short options, -q f=
or
--quiet makes sense to me as well.

Other suggestions?

-Alejandro
