From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] prune: allow --dry-run for -n and --verbose for -v
Date: Fri, 06 Aug 2010 23:41:39 +0200
Message-ID: <4C5C8193.1040608@lsrfire.ath.cx>
References: <4C5C7055.3090100@lsrfire.ath.cx> <20100806210429.GA6495@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 06 23:42:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhUfw-0005p4-30
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 23:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762089Ab0HFVl4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 17:41:56 -0400
Received: from india601.server4you.de ([85.25.151.105]:36669 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762086Ab0HFVlz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 17:41:55 -0400
Received: from [10.0.1.101] (p57B7F69B.dip.t-dialin.net [87.183.246.155])
	by india601.server4you.de (Postfix) with ESMTPSA id 4498A2F80B5;
	Fri,  6 Aug 2010 23:41:53 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.7) Gecko/20100713 Thunderbird/3.1.1
In-Reply-To: <20100806210429.GA6495@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152821>

Am 06.08.2010 23:04, schrieb Jonathan Nieder:
> Ren=E9 Scharfe wrote:
>
>> +++ b/builtin/prune.c
>> @@ -125,10 +125,9 @@ int cmd_prune(int argc, const char **argv, cons=
t char *prefix)
>>   {
>>   	struct rev_info revs;
>>   	const struct option options[] =3D {
>> -		OPT_BOOLEAN('n', NULL, &show_only,
>> +		OPT_BOOLEAN('n', "dry-run", &show_only,
>
> For the curious: avoiding OPT__DRY_RUN allows us to give a better
> description:
>
>>   			"do not remove, show only"),
>
> which makes sense to me.  Thanks.

Indeed.

Adding a helptext parameter to OPT__DRY_RUN =E0 la OPT__COLOR would mak=
e=20
it usable here as well as in commit.c and fetch.c.  Similar changes=20
could help OPT__VERBOSE and OPT__QUIET.  Their standard helptexts don't=
=20
add a lot of information..

Ren=E9
