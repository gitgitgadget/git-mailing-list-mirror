From: Phil Hord <hordp@cisco.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Sun, 27 Feb 2011 13:46:52 -0500
Message-ID: <4D6A9C1C.5000907@cisco.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>	<20110213193738.GA26868@elie>	<7v8vxjwnhj.fsf@alter.siamese.dyndns.org>	<AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>	<20110214231920.GA24814@elie> <AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 19:47:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ptle2-0002sA-Ow
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 19:47:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182Ab1B0Sq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 13:46:57 -0500
Received: from sj-iport-4.cisco.com ([171.68.10.86]:55735 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992Ab1B0Sq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 13:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1247; q=dns/txt;
  s=iport; t=1298832416; x=1300042016;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=qjuEXTSq2CK4B9BY5gwVCCWzlXflTcMpXt90TxB9Gr0=;
  b=ht2s/ex6rszc6FaEnxVDpPJIusZGc4yuHKsmkLiB3SmH0AIs33tb3Ysi
   QnNtR7atzc/QQy1ZNPKFo7YU3aN5/x6S3WaFYANc0aZc2MZ3cwtKaGJCC
   UFz+VsmqK2kcpodxxYJwj6L4E2HdwoMOSe7UP3GirvRh0NxEYAGv5UgCL
   0=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av0EAGsrak2rR7Ht/2dsb2JhbACEJKIgdJ4ziwWPPYEng0R2BIUQhw2DPg
X-IronPort-AV: E=Sophos;i="4.62,235,1297036800"; 
   d="scan'208";a="265935480"
Received: from sj-core-1.cisco.com ([171.71.177.237])
  by sj-iport-4.cisco.com with ESMTP; 27 Feb 2011 18:46:55 +0000
Received: from [10.117.80.100] (rtp-hordp-8913.cisco.com [10.117.80.100])
	by sj-core-1.cisco.com (8.13.8/8.14.3) with ESMTP id p1RIkrek017960;
	Sun, 27 Feb 2011 18:46:53 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168047>

On 02/26/2011 04:09 PM, Felipe Contreras wrote:
> I don't like the phrase "staging area". A "stage" already has an area.
> You put things on the stage. Sometimes there are multiple stages.

A "staging area" (idiomatically, perhaps) is a location where things are
collected to be organized before deployment.  Sounds a lot like our index.

http://en.wikipedia.org/wiki/Staging_area

> If only a subset of the files are there, it's an 'index', if not, then
> I'd say it's a 'registry'. Anyway, it's something the user shouldn't
> care about.

When we pack up our kayak club for a trip, we stage equipment we're
bringing.  Eventually we make a decision about which equipment is going
and which is staying.  The decision is codified by the equipment we
leave in the staging area versus the equipment we remove to local
storage.  Everyone seems to understand the term when we use it in this
context.

I think the parade analogy is also pretty common.

I like "staging area(n)/stage(v)" better than "index" or "cache" because
of the connotation in English.  But if it doesn't translate well, the
search may need to go on.  Maybe we can fall back on stdc methods and
invent generic terms like strcpy.  How about "xnar"?

Phil
