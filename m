From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/6] Bring "format-patch --notes" closer to a real feature
Date: Thu, 18 Oct 2012 14:24:32 +0200
Message-ID: <507FF500.2090702@drmicha.warpmail.net>
References: <1350539128-21577-1-git-send-email-gitster@pobox.com> <CACsJy8Dxx6JtRXP_HWNBrobNems+4UsaOGSRef08cf8--b5dOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 18 14:24:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOp9c-0005LF-9y
	for gcvg-git-2@plane.gmane.org; Thu, 18 Oct 2012 14:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751Ab2JRMYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2012 08:24:34 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:60563 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754687Ab2JRMYe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Oct 2012 08:24:34 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9747C2029D;
	Thu, 18 Oct 2012 08:24:33 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Thu, 18 Oct 2012 08:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=iYthatOcKpFjNz/VXGb3T2
	8eOUQ=; b=m+qj/R3Rp3jeDEvq+vOzla/4um6XTf8Jui2nUyFB24WRewl49kJ9rZ
	s9tyFIfwL7A7dKdal6yUv+OMr4OzajWArihF9VOzLYkLumSzof75F3ZrJx+jdZRm
	RxMc405PT68+ou6pEFdoT+jOTfN7R93c6eJDDn+jbbNZK+pOmdz/M=
X-Sasl-enc: gwXORjoBfD/0xXa9mia6PKsK8RQBZkjr54blzfCauoqT 1350563073
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0AC4E482730;
	Thu, 18 Oct 2012 08:24:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121011 Thunderbird/16.0.1
In-Reply-To: <CACsJy8Dxx6JtRXP_HWNBrobNems+4UsaOGSRef08cf8--b5dOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208003>

Nguyen Thai Ngoc Duy venit, vidit, dixit 18.10.2012 13:06:
> On Thu, Oct 18, 2012 at 12:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> This replaces the earlier "wip" with a real thing.
>>
>> We never advertised the "--notes" option to format-patch (or
>> anything related to the pretty format options for that matter)
>> because the behaviour of these options was whatever they happened to
>> do, not what they were designed to do.
> 
> Stupid question: does "git am" recreate notes from "format-patch
> --notes" output? If it does not, should it? I think it could be a nice
> way of copying notes from one machine to another, but not enabled by
> default (iow "am --notes").
> 

Not yet, but you can already start basing your am patches on top of
Junio's series ;)

am should allow a notes ref (--notes=hereyougo) like other similar
instances.

Michael
