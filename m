From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cherry-pick -x formats the message incorrectly
Date: Tue, 16 Nov 2010 15:34:00 -0600
Message-ID: <20101116213400.GA28402@burratino>
References: <loom.20101116T100730-967@post.gmane.org>
 <7vpqu5gjmv.fsf@alter.siamese.dyndns.org>
 <20101116193504.GB15828@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Svensson <martin.k.svensson@netinsight.se>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 22:34:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PITAw-0007oo-BA
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 22:34:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757738Ab0KPVen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 16:34:43 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:35494 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755595Ab0KPVen (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 16:34:43 -0500
Received: by gwj17 with SMTP id 17so726231gwj.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 13:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=SvKdmXLuMSphh9+kwFvyVy86GOcp03oBafecL0yDZXA=;
        b=VEXzOQmMJB3iPar3LbS5zF5J1EdIyM0y/4Sm+BLOYoKOmLhzW2p9iyNJ/cER5gEaJC
         mpBov/Xrybp2CW9iysJPxnRu9V6vDZ2AhLFD1MWyQc+3p2hxCwaWP5ud1Pzz+1c9w2PR
         PyFbE3b4ziU3DQQ0H9CjdzYJfJwk35YXtSX6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=naE8gdvGTL9yW+9A4zEdztc/FEANwqeJC7R28W8iq0HfG34xIebwUCAZ9z+wRdp7LZ
         NopQ7PQUPkMo27DyhmNsost3XqsNR9AzwaMvGwfPHkuzSKMQe1bUNTzmYA0mq0KG5NXg
         ERp5Js8v5Jr2hfDKk+PHtBuFfgPwYf1AUtO9U=
Received: by 10.223.102.79 with SMTP id f15mr4693055fao.134.1289943281822;
        Tue, 16 Nov 2010 13:34:41 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id b20sm1481912fab.11.2010.11.16.13.34.39
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Nov 2010 13:34:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101116193504.GB15828@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161588>

Jonathan Nieder wrote:
> Junio C Hamano wrote:
>> Martin Svensson <martin.k.svensson@netinsight.se> writes:
>
>>> It should be:
>>>
>>>   foo
>>>   
>>>   (cherry picked from commit eb42a6475d2c2e4fff7a1b626ce6e27eec21e886)
>>>
>>> Am I right?
>>
>> I tend to agree (modulo s/summary/subject/ would be the wording I would
>> have used).
[...]
> Mm, I use it and do not agree; I think the rule should rather be:
> 
>  - if there is a Signed-off chain, quietly integrate into that (no added
>    newline)
> 
>  - if there is not a Signed-off chain, add the extra newline.

Hmm, probably it is obvious, but I sent this reply to the wrong message.
Sorry for the nonsense.

Martin, I do agree with you and would be happy to see cherry-pick -x
respecting the

	One-line subject

	Possibly multi-line, detailed description.

	Signed-off-by: chain

format.
