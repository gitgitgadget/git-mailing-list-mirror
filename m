From: Andreas Ericsson <ae@op5.se>
Subject: Re: Approxidate with YYYY.MM
Date: Tue, 10 May 2011 08:54:33 +0200
Message-ID: <4DC8E129.2020306@op5.se>
References: <CAE5FB52-0F90-4F21-828F-7E40ED596B33@gernhardtsoftware.com> <4DC8DCC2.8050208@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue May 10 08:54:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJgqB-0007AT-FF
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 08:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922Ab1EJGyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 02:54:38 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:36511 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649Ab1EJGyh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 02:54:37 -0400
Received: by ewy4 with SMTP id 4so1743275ewy.19
        for <git@vger.kernel.org>; Mon, 09 May 2011 23:54:36 -0700 (PDT)
Received: by 10.14.53.11 with SMTP id f11mr3158326eec.204.1305010476191;
        Mon, 09 May 2011 23:54:36 -0700 (PDT)
Received: from vix.int.op5.se (c83-248-99-226.bredband.comhem.se [83.248.99.226])
        by mx.google.com with ESMTPS id k32sm4067426eea.27.2011.05.09.23.54.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 May 2011 23:54:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10 ThunderGit/0.1a
In-Reply-To: <4DC8DCC2.8050208@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173317>

On 05/10/2011 08:35 AM, Michael J Gruber wrote:
> Brian Gernhardt venit, vidit, dixit 09.05.2011 21:02:
>> (This is in response to a discussion on #parrot.)
>>
>> Rakudo (https://github.com/rakudo/rakudo/) uses tags of the form
>> YYYY.MM for their monthly releases.  When we were attempting to find
>> the cause of a slowdown, somewhat was trying to find what commits
>> occurred after the 2011.01 release with "git log --after=2011.01".
>> His mistake was pointed out but this led to the confusion of why this
>> was parsed as "May 1 2011" instead of "Jan 1 2011".  Shouldn't
>> date.c:match_multi_number() parse something with only two numbers as
>> a beginning of month instead of allowing it to pass through to the
>> generic parsing?
> 
> I just don't think there is a format like that. There is dd.mm.[yy]yy
> and apparently also yyyy.mm.dd, but without leading zeros in mm for the
> latter. Our date parser also takes "." for a space so that you don't
> need to quote a space ("1.day.ago"). I can see the logic behind parsing
> 2011.01 as January 2011, but it's a stretch from the existing formats:
> 

It would be far more logical to parse "2011-01" as "January 2011" as
that's the preferred way to write month-precision dates in most
countries that use both the metric system and the gregorian calender.

I've never seen that date-type with dot as a separator, but with the
dash it's very, very common.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
