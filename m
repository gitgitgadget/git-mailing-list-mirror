From: Per Cederqvist <cederp@opera.com>
Subject: Re: "git branch --contains x y" creates a branch instead of checking
 containment
Date: Thu, 21 Feb 2013 17:05:37 +0100
Message-ID: <512645D1.4040607@opera.com>
References: <51261A6B.5020909@opera.com> <20130221155827.GA20640@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 21 17:06:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8Yez-0000Kq-UB
	for gcvg-git-2@plane.gmane.org; Thu, 21 Feb 2013 17:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754842Ab3BUQFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 11:05:49 -0500
Received: from smtp.opera.com ([213.236.208.81]:56962 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754403Ab3BUQFt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 11:05:49 -0500
Received: from [10.30.2.116] (oslo.jvpn.opera.com [213.236.208.46])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id r1LG5dJ6010268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 21 Feb 2013 16:05:39 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <20130221155827.GA20640@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216780>

On 02/21/13 16:58, Jeff King wrote:
> On Thu, Feb 21, 2013 at 02:00:27PM +0100, Per Cederqvist wrote:
>
>> That command does something completely different,
>> though. The "--contains x" part is silently ignored,
>> so it creates a branch named "y" pointing at HEAD.
>>
>> Tested in git 1.8.1.1 and 1.8.1.4.
>>
>> In my opinion, there are two ways to fix this:
>>
>>   - change the "git branch" implementation so
>>     that --contains implies --list.
>
> I think that is the best option, too. In fact, I even wrote a patch. :)
>
> It's d040350 (branch: let branch filters imply --list, 2013-01-31), and
> it's already in v1.8.2-rc0.
>
> -Peff

Great! Thanks for the quick fix of my bug report. Negative response
time... not bad. Not bad at all. :-)

     /ceder
