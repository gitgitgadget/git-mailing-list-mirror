From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH (resend)] Let core.excludesfile default to ~/.gitexcludes.
Date: Thu, 26 Nov 2009 14:27:45 +0100
Message-ID: <4B0E8251.7050605@drmicha.warpmail.net>
References: <1258840832-22130-1-git-send-email-Matthieu.Moy@imag.fr> <1259231726-5218-1-git-send-email-Matthieu.Moy@imag.fr> <4B0E6DC9.3070105@drmicha.warpmail.net> <helthi$8k5$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Thu Nov 26 14:29:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDeP7-0001HU-OA
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 14:29:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759172AbZKZN2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 08:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754066AbZKZN2t
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 08:28:49 -0500
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:43340 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753901AbZKZN2t (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Nov 2009 08:28:49 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 28E55C2CB6;
	Thu, 26 Nov 2009 08:28:53 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 26 Nov 2009 08:28:54 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=FHnErHGXvzhEUBXENOeKRHzafek=; b=PZmkH2/0qV5ZiGy5mhn+TnUwkYK1KM44HRrloebKjdAfztbF+XQi4XjXeLBMeWlghk0L37MLPr/1eUHmMtmcL+1221MGquKhDsBSfdaO/EojOnKs56HLZQceGhaISmrdjZylokhztY4MuBVzDPM1nynhsZVwNgUepzRFsZTAChs=
X-Sasl-enc: NoScAYXgJuo/y3/Hm/KVum79ZatABIAthYnpey0Ij88l 1259242133
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3B20E2E65F;
	Thu, 26 Nov 2009 08:28:53 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.6pre) Gecko/20091125 Lightning/1.0pre Shredder/3.0.1pre
In-Reply-To: <helthi$8k5$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133794>

Paolo Bonzini venit, vidit, dixit 26.11.2009 13:49:
> On 11/26/2009 01:00 PM, Michael J Gruber wrote:
>> I'm sorry to jump in so late, and this may sound like bike-shedding, but
>> right now we have
>>
>> .git/info/exclude
>> .gitignore
>>
>> and this would add
>>
>> ~/.gitexcludes
>>
>> That is, three terms, or two, where one comes in two variations
>> (exclude/exludes). I always wondered why we have two.
> 
> Would you be fine with ~/.gitexclude?

Not really. You see, a user tracking his $HOME will have a ~/.gitignore
and a ~/.gitexclude then. I think we should distinguish local and global
"config" files more systematically. Which is why I suggested the subdir,
or having global in the name.

Michael
