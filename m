From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 2/5] git-tag: introduce long forms for the options
Date: Sun, 28 Aug 2011 16:03:46 +0200
Message-ID: <4E5A4AC2.5000908@drmicha.warpmail.net>
References: <20110825175301.GC519@sigill.intra.peff.net> <f02e446227a93fff37591f1a866566e6220ce283.1314367414.git.git@drmicha.warpmail.net> <7vpqjsdrnp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 28 16:55:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxglP-000078-My
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 16:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631Ab1H1Oy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 10:54:59 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47039 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751580Ab1H1Oy4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Aug 2011 10:54:56 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 36FF320D15;
	Sun, 28 Aug 2011 10:54:56 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute6.internal (MEProxy); Sun, 28 Aug 2011 10:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=cNsj5FjHZBbZy/h8S4wvWq
	wGyUo=; b=Lyg1OVuAGugZofWjynCrtAEtp1qPdHWM1nvRv2Gzw8lMBBChUsl2xn
	ZDZwy677qXgsEr/+CzzC11Z5pzEw6FO+1ujxnj3o/kKA5KDxQhbMs/3nNPaRo3tq
	bvlIKYNWeY6nkFqJChX+YmwDi65C4RRDqu8+MlLVKy61fG2cg6STk=
X-Sasl-enc: RMkroOG7Y0OL673XMTDgzseo7SVMsTgR72d8n6sHjMtq 1314543295
Received: from localhost.localdomain (p54859364.dip0.t-ipconnect.de [84.133.147.100])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 75219A00255;
	Sun, 28 Aug 2011 10:54:55 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <7vpqjsdrnp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180274>

Junio C Hamano venit, vidit, dixit 26.08.2011 19:11:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Long forms are better to memoize, and more reliably uniform across
>> commands.
> 
> I think people "memorize" and machines "memoize"; machines will do so just
> fine without long forms, but I think you are talking about helping people.

Yep.

> The part after ", and" lacks a verb, making it a non-sentence.

They are better to memorize, and they are more reliably uniform... Maybe
drop the comma?

> 
>> Design notes:
>>
>> -u,--local-user is named following the analogous gnupg option.
>>
>> -l,--list is not an argument taking option but a mode switch.
> 
> Ok.
> 
> The remainder looks good. Thanks.
