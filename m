From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/6] http-auth-early
Date: Fri, 14 Oct 2011 15:24:02 +0200
Message-ID: <4E9837F2.4050404@drmicha.warpmail.net>
References: <4E9692BF.8040705@drmicha.warpmail.net> <cover.1318577792.git.git@drmicha.warpmail.net> <20111014131932.GE7808@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 15:24:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REhkL-0000Os-1k
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 15:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932876Ab1JNNYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 09:24:07 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:40965 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932744Ab1JNNYF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 09:24:05 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 4649D20B8E;
	Fri, 14 Oct 2011 09:24:04 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 14 Oct 2011 09:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=3GZRW4Q8xqwwBWsfzrjYcp
	0p3yo=; b=SZQszR4p4+jUWVSkU2WUO2DMfjzTIqF1tYmXE8Wg+6x5bPCFV12xcD
	w9NOAVXEh5Ldl0fo6/AlUvSE1q8WuGBMBhZBxWwhfupqOTyqgr6cnrDSaRLkX/y2
	CWhv5kTJHHDReXP9X1AIye8wYMw8S+eHhLjTl19CLUelGkVUycVdw=
X-Sasl-enc: yKBoIWeZRotSaKOtY+F+3Oc1MGLwZJcIaIgTD7j4/y05 1318598644
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A50F4404AC6;
	Fri, 14 Oct 2011 09:24:03 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:7.0) Gecko/20110927 Thunderbird/7.0
In-Reply-To: <20111014131932.GE7808@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183574>

Jeff King venit, vidit, dixit 14.10.2011 15:19:
> On Fri, Oct 14, 2011 at 09:40:34AM +0200, Michael J Gruber wrote:
> 
>> Here are the early parts of Jeff's http-auth-keyring series.
>> It contains only parts which are not using the credential API (which
>> is still under discussion), so that this can go in (and help users)
>> and alleviates the pressure on the credential discussion:
>>
>> Early bits with cleanups to http.c.
>> Cherry-picked bit for improved prompts ("Username for ..." etc.)
>> Cherry-pickes bit for using configured pushurls.
>>
>> I tried to pick/resolve in a way which should help rebasing Jeff's series
>> on top of this.
> 
> Thanks for working on this. One of my intended tasks for today is to
> rebase my series, so it is nice to wake up to half of the work done. :)

Good morning :)

>> Jeff King (5):
>>   url: decode buffers that are not NUL-terminated
>>   improve httpd auth tests
>>   remote-curl: don't retry auth failures with dumb protocol
>>   http: retry authentication failures for all http requests
>>   http_init: accept separate URL parameter
>>
>> Michael J Gruber (1):
>>   http: use hostname in credential description
> 
> Your changes all look right. The naming of git_getpass_one in the
> cherry-picked commit is a little odd without the rest of the series as
> context. I would maybe have called it "git_getpass_with_description" or
> something.

git_getpass_my_life_will_be_short_and_ended_by_credentials

I don't care. In fact, I wasn't sure whether I should I even change the
author on this one. It's not a straight resolution and does involve
choices, but the meat is from your series.

Michael
