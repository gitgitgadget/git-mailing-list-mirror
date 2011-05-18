From: Ferry Huberts <mailings@hupie.com>
Subject: Re: git & patterns
Date: Wed, 18 May 2011 15:36:15 +0200
Message-ID: <4DD3CB4F.6080304@hupie.com>
References: <4DD3A402.3040802@hupie.com> <4DD3C484.2070102@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed May 18 15:36:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMgvF-0007fo-Ak
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 15:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932876Ab1ERNgQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 09:36:16 -0400
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:50923 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932778Ab1ERNgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 09:36:16 -0400
Received: from paul.internal.hupie.com (paul.internal.Hupie.com [192.168.180.1])
	by mail.internal.Hupie.com (Postfix) with ESMTP id 2073A58BD73;
	Wed, 18 May 2011 15:36:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10
In-Reply-To: <4DD3C484.2070102@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173880>

On 05/18/2011 03:07 PM, Andreas Ericsson wrote:
> On 05/18/2011 12:48 PM, Ferry Huberts wrote:
>> Hi list
>>
>> After reading the manual page for git describe it was not clear to me what
>> kind of pattern the --match option should take. Was it to be
>> a shell pattern (to be expected) or a regular expression pattern?
>>
>> So I dug in the code to find fnmatch: shell pattern.
>>
>> Now my question(s):
>> - could the manual page be update to make this explicit please? (plus
>> other manual pages talking about (shell) patterns)
> 
> Patches welcome.
> 
>> - could git start taking regular expression patterns please?
>>
> 
> I'm not the maintainer, but with my incredible powers of foresight I'll
> take a wild stab at answering in his stead:
> Not with the current argument, no, but introducing '--rematch' or '--rmatch'
> to take a regular expression instead would probably be a welcome patch if
> it's well done.

agreed

> 
> 
>> I'm using the --match option on git describe to generate version
>> information from and matching against a regular expression is soooo much
>> more powerful and allows me to fully define my naming convention while
>> shell patterns do not allow me to do so.
>>
>> Or am I missing something?
>>
> 
> You're not, but we're missing the patch ;)

Will see if I can make some time but I'm pretty busy :-(

Thanks!

> For my own needs, the fnmatch patterns work quite well.
> 

grtz

-- 
Ferry Huberts
