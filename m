From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCHv2] commit: reword --author error message
Date: Tue, 27 Jan 2015 12:22:04 +0000
Message-ID: <54C782EC.3020309@ramsay1.demon.co.uk>
References: <xmqqfvba1p07.fsf@gitster.dls.corp.google.com> <7e2e1d1e7f4a25d84a6f7a1c0cb035221529f189.1422286879.git.git@drmicha.warpmail.net> <20150126190711.GA13582@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Philip Oakley <philipoakley@iee.org>,
	Gunnar Wagner <gunnar.wagner@irisgermanica.com>
To: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jan 27 13:22:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YG59u-0003s8-UD
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 13:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758038AbbA0MWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 07:22:12 -0500
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:38003 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754720AbbA0MWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 07:22:09 -0500
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 2FBDEA65558;
	Tue, 27 Jan 2015 12:22:09 +0000 (GMT)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id E863FA65556;
	Tue, 27 Jan 2015 12:22:08 +0000 (GMT)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Tue, 27 Jan 2015 12:22:07 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <20150126190711.GA13582@peff.net>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263064>

On 26/01/15 19:07, Jeff King wrote:
> On Mon, Jan 26, 2015 at 04:48:33PM +0100, Michael J Gruber wrote:
> 
>> -	die(_("No existing author found with '%s'"), name);
>> +	die(_("--author '%s': neither 'Name <email>' nor a match for an existing author"), name);
> 
> I had to add to the bikeshed, but I had to read this several times to
> make sense of it. It is grammatically:
> 
>   X [is] neither Y nor Z
> 
> except that by eliding the verb ("is"), I somehow had trouble making
> sense of Z ("a match...") as a noun.
> 
> I came up with:
> 
>   --author '%s': neither 'Name <email>' nor matches an existing author
> 
> only to see that it was suggested earlier in the thread as a predecessor
> to this. ;)
> 
> I wonder if adding back in the missing verb, rather than a colon, would
> also make more sense:
> 
>   --author '%s' is neither 'Name <email>' nor a match for an existing author
> 

I usually don't like to add anything to the bikeshed, but ...

This sounds odd to me, so maybe:

  --author '%s' is neither in the form of 'Name <email>' nor a match for an existing author

although that is getting a bit long! :-D

ATB,
Ramsay Jones
