From: Andreas Ericsson <ae@op5.se>
Subject: Re: Fix signal handler
Date: Thu, 04 Feb 2010 08:23:24 +0100
Message-ID: <4B6A75EC.6030509@op5.se>
References: <4B684F5F.7020409@web.de> <20100203102915.GA25486@coredump.intra.peff.net> <4B696447.10803@web.de> <201002031412.53195.trast@student.ethz.ch> <4B699A45.7000905@web.de> <4B699C08.50400@op5.se> <4B69A34B.7010309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Thu Feb 04 08:23:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncw3o-0007El-CN
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 08:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755551Ab0BDHX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 02:23:27 -0500
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:54754 "HELO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755201Ab0BDHX0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2010 02:23:26 -0500
Received: from source ([209.85.219.215]) by na3sys009aob113.postini.com ([74.125.148.12]) with SMTP
	ID DSNKS2p17as5kQBTgBNgXNe1DLpcnDBTFkW1@postini.com; Wed, 03 Feb 2010 23:23:26 PST
Received: by mail-ew0-f215.google.com with SMTP id 7so435193ewy.10
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 23:23:25 -0800 (PST)
Received: by 10.213.1.143 with SMTP id 15mr583356ebf.42.1265268205368;
        Wed, 03 Feb 2010 23:23:25 -0800 (PST)
Received: from clix.int.op5.se (90-227-176-162-no128.tbcn.telia.com [90.227.176.162])
        by mx.google.com with ESMTPS id 16sm360336ewy.2.2010.02.03.23.23.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Feb 2010 23:23:24 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.9.1.7) Gecko/20100120 Fedora/3.0.1-1.fc11 Thunderbird/3.0.1 ThunderGit/0.1a
In-Reply-To: <4B69A34B.7010309@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138955>

On 02/03/2010 05:24 PM, Markus Elfring wrote:
> 
>>
>> The general feeling on this list is that patches are listened to, no
>> matter how foul they are, and you will get a (hopefully) polite
>> rejection if it is considered useless because it addresses a problem
>> that doesn't exist.
>>
> 
> I hope that a healthy balance will be found between correct software
> design, development and quick "hacking".

What's considered a "healthy balance" varies from person to person
though.

> There might also be more
> efforts if too many patches will be rejected just because the suggested
> and planned changes were not discussed before.
> 

Perhaps, but those wasted efforts would have been yours, not ours. Sorry,
but the sad fact is that unless you're willing to "fix" this (which you
should show by submitting patches), it's entirely uninteresting to even
discuss it. We're all busy folks here, and we do not have unlimited time
on our hands to masturbate mentally when most of us realize that it's
not a practical approach to blindly follow standards.

> Would you like to get an acknowledgement for signal handler problems
> from people in other discussion groups like "comp.programming.threads"?
> 

No. I have no interest in theoretical best practices for a program that
has no known issues with its use of multiple threads.

I do have interest in bug-reports about my favourite scm and patches to
make it better. So far you have only shown a willingness to discuss
possible problems instead of real-world ones. I've mentally marked you
down as "the threads theory troll". To remedy that sad title, you should
deliver some patches pointing out and fixing problems in the sources.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
