From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Idea: "git format-patch" should get more information out of git
Date: Thu, 01 Sep 2011 08:44:37 +0200
Message-ID: <4E5F29D5.4060205@drmicha.warpmail.net>
References: <4E587CC0.4090508@alum.mit.edu> <20110830152217.GA13022@sigill.intra.peff.net> <4E5D048D.4010902@drmicha.warpmail.net> <201108301939.53487.johan@herland.net> <4E5F0ACD.8050206@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Sep 01 09:04:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qz1Jg-0000Xv-Jo
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 09:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755155Ab1IAHDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 03:03:53 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:53748 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752429Ab1IAHDw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Sep 2011 03:03:52 -0400
X-Greylist: delayed 1152 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Sep 2011 03:03:52 EDT
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 6219720873;
	Thu,  1 Sep 2011 02:44:40 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 01 Sep 2011 02:44:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=JSBPcoChSYW/GJ6OP+ywRD
	n3mMM=; b=nrcLCIAnmOk/SNrdrTvaFplIr+z151DYXOIPv+Gs7eRZZ0tNz37/Z1
	J9UeJzlv4oTV42aHfhln2WuSYpaQP43RulQf3ZmKTd2X3uQHmSIrGZLGf86NBpa+
	jjXtPHgEWgpf/KPOG7QFvoNEvsA4HUmynunEukPuZH/hM+fwKKZbI=
X-Sasl-enc: EFF5L3wKTqJ+IlUcVNp/lch9SpnhJdSgYTScU7SFJerA 1314859480
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 65E13A00570;
	Thu,  1 Sep 2011 02:44:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <4E5F0ACD.8050206@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180523>

Michael Haggerty venit, vidit, dixit 01.09.2011 06:32:
> On 08/30/2011 07:39 PM, Johan Herland wrote:
>> On Tuesday 30. August 2011, Michael J Gruber wrote:
>>> Reminds me of the ref namespace restructuring which could help
>>> sharing notes... Oh, lots to do before git 3.0!
>>
>> Indeed. I am very sorry to not have been able to properly follow up on 
>> that proposal [...]
> 
> What "ref rename restructuring" are you talking about?  Can you give a
> mailing list link?
> 
> (I've been working on refs lately and want to know whether your proposal
> is relevant to my work.)

Searching for "namespace" in the subject should give you all relevant
proposals plus the new "namespaces" which might affect you also:

http://permalink.gmane.org/gmane.comp.version-control.git/140681
http://permalink.gmane.org/gmane.comp.version-control.git/165813
http://permalink.gmane.org/gmane.comp.version-control.git/165799

http://permalink.gmane.org/gmane.comp.version-control.git/176808

Michael
