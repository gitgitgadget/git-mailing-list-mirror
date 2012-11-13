From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: What's cooking in git.git (Oct 2012, #09; Mon, 29)
Date: Tue, 13 Nov 2012 18:47:48 +0000
Message-ID: <50A295D4.1080609@ramsay1.demon.co.uk>
References: <20121029102114.GA14497@sigill.intra.peff.net> <5092C234.9000307@ramsay1.demon.co.uk> <CAEUsAPb7hUViLn7V7v65r6mOqRHr+180ynRX8K9t3nuJVyePfg@mail.gmail.com> <20121102094259.GA28414@sigill.intra.peff.net> <20121102095632.GA30221@sigill.intra.peff.net> <50943C1A.4090706@ramsay1.demon.co.uk> <20121104122926.GD336@sigill.intra.peff.net> <509E9E02.3000500@ramsay1.demon.co.uk> <20121111174136.GC13188@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Chris Rorvick <chris@rorvick.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 19:57:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYLfe-0000Vd-9r
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 19:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755421Ab2KMS47 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 13:56:59 -0500
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:33871 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab2KMS46 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 13:56:58 -0500
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 6915CA0C080;
	Tue, 13 Nov 2012 18:56:56 +0000 (GMT)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id ABEDAA0C07F;	Tue, 13 Nov 2012 18:56:55 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;	Tue, 13 Nov 2012 18:56:54 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <20121111174136.GC13188@sigill.intra.peff.net>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209656>

Jeff King wrote:
> On Sat, Nov 10, 2012 at 06:33:38PM +0000, Ramsay Jones wrote:
> 
>>> We should probably wrap it. I'm planning to queue this on top of Chris's
>>> patch:
>>
>> Unfortunately, I haven't had time yet to test this patch. (Early this week, I
>> went into hospital for a "minor" surgical procedure - I have not yet fully
>> recovered). The patch looks good and I don't anticipate any problems. I will
>> hopefully test it soon (I see it's in pu now) and let you know.
> 
> Thanks. I merged it to "next" on Friday, so we will see if anybody
> screams. But please take your time and recover. Git will wait. :)

I have tested this patch and, as expected, it fixes things up for me.
(To be more precise: the current next branch works, but if I revert
commit c2b3af05, then t9604-cvsimport-timestamps.sh fails in the
same way as before!)

Thanks!

ATB,
Ramsay Jones
