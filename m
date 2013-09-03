From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] revision: introduce --exclude=<glob> to tame wildcards
Date: Tue, 03 Sep 2013 22:02:56 +0200
Message-ID: <52264070.3080909@kdbg.org>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com> <7vhae7k7t1.fsf@alter.siamese.dyndns.org> <CAMP44s1y2kvSnF3dKDMr9QtS40PNSW93DWCxFUoL658YkqYeVA@mail.gmail.com> <CAPc5daVSqoE74kmsobg7RpMtiL3vzKN+ckAcWEKU_Q_wF8HYuA@mail.gmail.com> <CAMP44s0P=XF5C8+fU2cJ-Xuq57iqcAn674Upub6N=+iiMpQK0g@mail.gmail.com> <xmqqeh9b15x6.fsf@gitster.dls.corp.google.com> <xmqq1u5aybri.fsf_-_@gitster.dls.corp.google.com> <5224F0EE.1080205@kdbg.org> <xmqq4na1vqng.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 22:03:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGwoc-0001mm-Cb
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 22:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760199Ab3ICUDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 16:03:01 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:16054 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754063Ab3ICUDA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 16:03:00 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 32219CDF88;
	Tue,  3 Sep 2013 22:02:57 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2906019F3F8;
	Tue,  3 Sep 2013 22:02:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <xmqq4na1vqng.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233770>

Am 03.09.2013 18:03, schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>> So I like the relative simplicity of this approach. Here is a bit of
>> documentation.
> 
> Oh, thanks for helping.  An example or two may also help, and using
> your original "I have branches and wip/" situation would be good.
> 
>         git log --exclude='wip/*' --branches::
> 
>                 Show history of local branches whose names do not
>                 match pattern `wip/*`.
> 
> 	git log --remotes --not --exclude='wip/*' --branches::
> 
> 		Show history of other people's work that are not
> 		merged to local branches whose names do not match
> 		pattern `wip/*`.
> 
> or something like that, perhaps?

Agreed and noted.

The new option must also be integrated in rev-parse. That will take a
bit more work.

I'll pick up the topic when I find the time to do so.

-- Hannes
