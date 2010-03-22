From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v3] git checkout: create unparented branch by --orphan
Date: Mon, 22 Mar 2010 09:54:47 +0100
Message-ID: <4BA73057.1020602@drmicha.warpmail.net>
References: <1269185678-3039-1-git-send-email-erick.mattos@gmail.com> 	<20100321171431.GE2557@m62s10.vlinux.de> <7vd3yxqxdj.fsf@alter.siamese.dyndns.org> <55bacdd31003211415k79b7a039n3f19eb95eefcad43@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 09:57:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtdSA-0007FJ-MP
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 09:57:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754009Ab0CVI5h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 04:57:37 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:60144 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751578Ab0CVI5g (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Mar 2010 04:57:36 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D3C15E95EE;
	Mon, 22 Mar 2010 04:57:35 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 22 Mar 2010 04:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=arpqtWw4d3TTGZxbyPHA6iWHzCs=; b=tSGH8eUmX7U44cSRaUbyyUu/hd5gPSbcQUoLQhOzM1GzjbcpSg2J0FIB2R4C+roQnmw35x+8Q8k+RXnWTWeC5OLrRHTXRu44qqf2TkdIUrVNQCsjDH/Iv6CrG6m9tak+67NPuL8enddpcQ+Zhw6TA6hddYVwZNT47U6GU4MtqC8=
X-Sasl-enc: YOhHjnlK8TztUoXbljSXjY0LvlhoAKPaSxHoOxiwQtzL 1269248255
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 167D835D83;
	Mon, 22 Mar 2010 04:57:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <55bacdd31003211415k79b7a039n3f19eb95eefcad43@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142911>

Erick Mattos venit, vidit, dixit 21.03.2010 22:15:
> Hi,
> 
> 2010/3/21 Junio C Hamano <gitster@pobox.com>:
>> I'm not native either, and "orphan" sounded strange in that we've never
>> used that word in any of our use case or workflow description in our
>> documents.
> 
> I didn't know.  I thought you were American.
> 
>> The main point of the feature is not the emptyness of the resulting tree
>> (it is merely one possible outcome), but is the lack of parents in the
>> resulting commit.  So I would recommend against --empty.  --root might be
>> a good synonym, though, and we _do_ already use that word for that purpose
>> in some commands (e.g. "log --root").
> 
> --root could be a synonym but the reason I haven't chosen it was the
> fact that it could mislead people to think the functionality will do
> something with/based on the first commit of the actual branch,
> subjectively thinking "THE ROOT".
> 
> IMHO --orphan (no parents) is more obvious.
> 
> We should argue one of our native English speaker amidst this
> developer community to be sure.

[Disclosure: non-native speaker but having lived with natives ;)]

I'd favour "root" for several reasons:

- "root" is the correct technical term in graph theory
- "root" is used the same way in other (Git) places
- "orphan" is someone who used to have parents, so with "orphan" I would
rather associate the process of removing parents from the picture
(removing parentship information from an existing commit)

Just my two Euro-cents :)
Michael
