From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Something weird is happening...
Date: Thu, 29 Jan 2009 23:35:29 +0100
Message-ID: <20090129223529.GB1465@elte.hu>
References: <49814BA4.6030705@zytor.com> <7vfxj1eqh6.fsf@gitster.siamese.dyndns.org> <49822944.8000103@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 23:37:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSfVS-0006zo-17
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 23:37:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753310AbZA2Wfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 17:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753372AbZA2Wfk
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 17:35:40 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:60131 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678AbZA2Wfj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 17:35:39 -0500
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1LSfTv-0000uC-0m
	from <mingo@elte.hu>; Thu, 29 Jan 2009 23:35:36 +0100
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id F06503E21AA; Thu, 29 Jan 2009 23:35:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49822944.8000103@zytor.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00 autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107742>


* H. Peter Anvin <hpa@zytor.com> wrote:

>> But it still does the connectivity check fully from your refs.  And if 
>> it finds an object that ought to be reachable from your refs that it 
>> hasn't validated, it gives the "missing" warning above.  There is a 
>> check to exclude objects in packs when running "git fsck" without 
>> --full from this warning but I do not see a corresponding exclusion of 
>> objects that were borrowed from your neighbour which we didn't check 
>> either.
>>
>> But that is just a conjecture from a cursory looking at the current 
>> code. I do not remember (or did not know from the beginning) some 
>> details of it. And that is why I asked you if "git fsck --full" reports 
>> it missing in my earlier response to you.
>
> Just tried it, it doesn't.  So I guess things are OK.

hm, it reported missing items here - but maybe i misremembered that. 
Re-running it currently. (takes quite a while)

	Ingo
