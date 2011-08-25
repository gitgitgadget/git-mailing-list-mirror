From: Boaz Harrosh <bharrosh@panasas.com>
Subject: Re: [RFC/PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Thu, 25 Aug 2011 15:01:19 -0700
Message-ID: <4E56C62F.1000403@panasas.com>
References: <20110825200001.GA6165@sigill.intra.peff.net> <20110825204047.GA9948@sigill.intra.peff.net> <CAPig+cQ33PESWC5fzN8enLFRwNPx8o+PgRUTeCva4dSJ_EdwOw@mail.gmail.com> <20110825210654.GA11077@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Eric Sunshine <sunshine@sunshineco.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 00:01:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwhzY-0005OI-1S
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 00:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591Ab1HYWBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 18:01:34 -0400
Received: from natasha.panasas.com ([67.152.220.90]:48658 "EHLO
	natasha.panasas.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436Ab1HYWBe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 18:01:34 -0400
Received: from zenyatta.panasas.com (zenyatta.int.panasas.com [172.17.28.63])
	by natasha.panasas.com (8.13.1/8.13.1) with ESMTP id p7PM1Qom003543;
	Thu, 25 Aug 2011 18:01:26 -0400
Received: from [172.17.132.75] (172.17.132.75) by zenyatta.int.panasas.com
 (172.17.28.63) with Microsoft SMTP Server (TLS) id 14.1.289.1; Thu, 25 Aug
 2011 18:01:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:5.0) Gecko/20110707 Thunderbird/5.0
In-Reply-To: <20110825210654.GA11077@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180129>

On 08/25/2011 02:06 PM, Jeff King wrote:
> On Thu, Aug 25, 2011 at 05:00:51PM -0400, Eric Sunshine wrote:
> 
>>> Also, any other extensions that would go into such a list? I have no
>>> idea what the common extension is for something like pascal or csharp.
>>
>> C# uses extension ".cs".
>>
>> ".cpp" is common, in fact often required, by Windows compilers.
> 
> Thanks, added both to my list.
> 
>> What about ".h" and ".hpp"?
> 
> How well do our cpp patterns do with header files? I imagine they're
> better than the default, but I don't think I've ever really tried
> anything tricky.
> 
> -Peff

Thanks Jeff, thanks everyone! This looks very promising. Specially that
it's all already there and I don't have to code it up.

RTFM time for me now
Boaz
