From: "Tom G. Christensen" <tgc@jupiterrise.com>
Subject: Re: git segfaults on older Solaris releases
Date: Thu, 7 Apr 2016 22:19:32 +0200
Message-ID: <5706C0D4.9030707@jupiterrise.com>
References: <5706A489.7070101@jupiterrise.com>
 <xmqqoa9lz2uw.fsf@gitster.mtv.corp.google.com>
 <xmqqk2k9z20p.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 22:20:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoGPV-0005oT-6W
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 22:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458AbcDGUUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 16:20:07 -0400
Received: from sub4.mail.dreamhost.com ([69.163.253.135]:35693 "EHLO
	homiemail-a31.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753175AbcDGUUG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Apr 2016 16:20:06 -0400
Received: from homiemail-a31.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a31.g.dreamhost.com (Postfix) with ESMTP id 4ED672020DF;
	Thu,  7 Apr 2016 13:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jupiterrise.com; h=subject
	:to:references:cc:from:message-id:date:mime-version:in-reply-to
	:content-type:content-transfer-encoding; s=jupiterrise.com; bh=Z
	lpe9tyERxIllGZFqUDXJv+J1TA=; b=kSjPTsrxyY5m+fCIiaTC9reZqXPqrfYM5
	l1mgR6kNt8INluvCdCeBWlE0Z33Wu9oTJN5CGBTEDMfaI2f/iAEK2KVJBLRRq8pz
	sP9OyE6XmsWpM4JYbanZHk1DFH5RIV2pT/KkWnyzmWTC+LtTexnzfg2LsaEpOKqD
	MMJNoQXVJ0=
Received: from localhost6.localdomain6 (2-106-159-182-static.dk.customer.tdc.net [2.106.159.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: tgc99@jupiterrise.com)
	by homiemail-a31.g.dreamhost.com (Postfix) with ESMTPSA id 5104D2020E1;
	Thu,  7 Apr 2016 13:19:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by localhost6.localdomain6 (8.14.4/8.14.4) with ESMTP id u37KJWW9018368;
	Thu, 7 Apr 2016 22:19:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <xmqqk2k9z20p.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290982>

On 07/04/16 20:50, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> So perhaps this is all we need to fix your box.
>
>   setup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>

Yes that seems to work very well.

I applied this patch to 2.8.0 and have completed a testsuite run on 
Solaris 2.6/x86 with only a few unrelated problems.
I will continue testing on the other Solaris < 10 releases but I do not 
expect any difference in the outcome.

-tgc
