From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH] git submodule foreach: Provide access to submodule name,
 as '$name'
Date: Mon, 17 Aug 2009 20:54:39 -0400
Message-ID: <4A89FBCF.1080400@gmail.com>
References: <200908160310.08459.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Lars Hjemli <hjemli@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Aug 18 02:55:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdCyf-0001NY-89
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 02:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509AbZHRAy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 20:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbZHRAy4
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 20:54:56 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:44844 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbZHRAy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 20:54:56 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1124361qwh.37
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 17:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=BU/eFmb1pbLlBIcWZmqQTCfPrq30oz/ET12Ib1mohEI=;
        b=ZuY+6Q9qUsyTy75/KxeQ1R0ZC44rqpeDUQ7mdnMOFIglO0RFkT2vmVX4Xkw5/ZjDsJ
         Rb46YeN9FXKGq0xuWR0MFIJBV/6HBNprxbXYuJ3TIOkPGY0ZadHJbOckCErkCsHHxYRg
         aYHBDH4/NZlyC9r9c0YzfKIq8T1dxSx2oh5Xo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=AYaYfoJw78+G7vNwGJwSqkLa7xeiXEuPTEkhJBpqb6pO7xupe9d12KQ4owZNfEVb4l
         RV2a0kdZwJf3WZcb5AL1dAO1DvA3eeIRKvDKKiecnvQYhv6ZNTlFLYOZYV/lbMCYfKBW
         M8a5yYOMi+d4NFvwXUd43YXF8jCChok8OE1ho=
Received: by 10.224.10.147 with SMTP id p19mr4907580qap.166.1250556897101;
        Mon, 17 Aug 2009 17:54:57 -0700 (PDT)
Received: from ?192.168.10.147? (pool-173-79-112-61.washdc.fios.verizon.net [173.79.112.61])
        by mx.google.com with ESMTPS id 8sm9279405qwj.6.2009.08.17.17.54.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Aug 2009 17:54:56 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <200908160310.08459.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126333>

Johan Herland wrote:
> The argument to 'git submodule foreach' already has access to the variables
> '$path' (the path to the submodule, relative to the superproject) and '$sha1'
> (the submodule commit recorded by the superproject).
>
> This patch adds another variable -- '$name' -- which contains the name of the
> submodule, as recorded in the superproject's .gitmodules file.
>
> Signed-off-by: Johan Herland <johan@herland.net>
> ---
>   
This patch *looks* ok to me, but I'm out of the office for most of 
August so I cannot actually test this code for another couple of weeks.

Mark
