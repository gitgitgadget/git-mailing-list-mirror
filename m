From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv4] git-p4: add initial support for RCS keywords
Date: Wed, 22 Feb 2012 22:44:20 +0000
Message-ID: <4F456FC4.7060007@diamand.org>
References: <1329905741-2092-1-git-send-email-luke@diamand.org> <1329905741-2092-2-git-send-email-luke@diamand.org> <20120222125327.GA2292@padd.com> <7vy5ruacpa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Eric Scouten <eric@scouten.com>,
	Pete Wyckoff <pw@padd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 23:44:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Kv5-0005x9-2a
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 23:44:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676Ab2BVWoJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 17:44:09 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:64427 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab2BVWoH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 17:44:07 -0500
Received: by wics10 with SMTP id s10so370676wic.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 14:44:05 -0800 (PST)
Received-SPF: pass (google.com: domain of luke@diamand.org designates 10.180.78.130 as permitted sender) client-ip=10.180.78.130;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of luke@diamand.org designates 10.180.78.130 as permitted sender) smtp.mail=luke@diamand.org
Received: from mr.google.com ([10.180.78.130])
        by 10.180.78.130 with SMTP id b2mr550770wix.1.1329950645203 (num_hops = 1);
        Wed, 22 Feb 2012 14:44:05 -0800 (PST)
Received: by 10.180.78.130 with SMTP id b2mr455160wix.1.1329950645135;
        Wed, 22 Feb 2012 14:44:05 -0800 (PST)
Received: from [86.6.30.7] (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id fl2sm1539177wib.4.2012.02.22.14.44.03
        (version=SSLv3 cipher=OTHER);
        Wed, 22 Feb 2012 14:44:03 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.21) Gecko/20110831 Iceowl/1.0b2 Icedove/3.1.13
In-Reply-To: <7vy5ruacpa.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkFpP00joPDasjkckz/s5CsbbfHX9SJ6+B+XwLuSeOvOG9eM1MLqWcTpnW0RW5yUc7zyAB8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191302>

On 22/02/12 19:29, Junio C Hamano wrote:
> Pete Wyckoff<pw@padd.com>  writes:
>
>>> Improved-by: Pete Wyckoff<pw@padd.com>
>>> Signed-off-by: Luke Diamand<luke@diamand.org>
>>
>> Looks brilliant.  Ack.  Thanks for suffering through N rounds of
>> review.  :)
>
> Well, I hate to say that I need to ask another round, to redo this patch
> on top of ld/git-p4-expanded-keywords topic that has already been in
> 'next'; a patch that replaces what is in 'next' will lose fix-ups for
> issues I pointed out in the first round that you forgot to follow and were
> fixed up locally by me when I queued the existing one.
>
> When working on an improvement to what you have sent out, please make it a
> habit of comparing your result with what are already queued, even when the
> earlier patches are still in 'pu'.  They often are polished with trivial
> improvements (both to the patch and the log message) based on review
> comments from people when they are queued, which you do not want to lose.

Sorry - I had completely forgotten about that.

No need to apologize for asking me to rework this. I'm using this 
amazing version control system that makes it really easy.

Now, if I was using Perforce, then by now I would pretty unhappy.... P

>
> Thanks.
