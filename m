From: Marius Storm-Olsen <mstormo@gmail.com>
Subject: Re: [PATCH] generators/vcproj.pm: remove UNICODE from build
Date: Mon, 28 Sep 2009 14:39:24 +0200
Message-ID: <4AC0AE7C.3080308@gmail.com>
References: <d2e97e800909280346s12c205f2gf95ff4c135d4625c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Wookey <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 28 14:44:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsFaF-0001xV-I1
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 14:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752716AbZI1Mjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Sep 2009 08:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752689AbZI1Mjb
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Sep 2009 08:39:31 -0400
Received: from ey-out-2122.google.com ([74.125.78.27]:41875 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbZI1Mja (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Sep 2009 08:39:30 -0400
Received: by ey-out-2122.google.com with SMTP id 4so467674eyf.5
        for <git@vger.kernel.org>; Mon, 28 Sep 2009 05:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=tTWMeESmGY1vgZwXEDTrtSoy5p2F/LeT8zhEHJkNHOw=;
        b=FzQxsEfRYcqqIyR7xXfgrGuStHyjphR3WG9WHe4JqT6mMT2v6CBbzlJga4GSVbrot5
         760ePlDcKIu5UHalFwBCCu61mGX6BcGxdriTtpvV/G2OBgmj/LeEV4SpIxKbOphp0BFF
         B5vZKLCKTggRy+7OLFeZSjBgAYaktz9e0j6l0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=rPn2r4ddtpxX3duAjVn1081Tv2oVKWvj2WqqgMG6d8kRjDpsur8xk5Fgj2cWVqjXVn
         f0e8GUEAi+zoWIVgKxvNbDIlpjSto+lOGjzMnxT15zItCBFGcfkVyy6pf9TIgeLsSyJf
         B7ixqufr+AMD4p7eQFvQM3EFsWyYIsNj9CJrM=
Received: by 10.211.144.9 with SMTP id w9mr3041729ebn.45.1254141573573;
        Mon, 28 Sep 2009 05:39:33 -0700 (PDT)
Received: from ?172.24.90.95? ([62.70.27.104])
        by mx.google.com with ESMTPS id 10sm200933eyz.18.2009.09.28.05.39.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 28 Sep 2009 05:39:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Lightning/0.9 Thunderbird/2.0.0.23 ThunderGit/0.1a Mnenhy/0.7.6.666
In-Reply-To: <d2e97e800909280346s12c205f2gf95ff4c135d4625c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129256>

Michael Wookey said the following on 28.09.2009 12:46:
> Defining UNICODE for MSVC IDE builds results in certain Win32 WIDE API's
> receiving ANSI strings. The result of which is an invalid use of the API
> and will end in either data corruption or an application crash.
> 
> Prevent the use of WIDE API's when building with the MSVC IDE for
> compatibility with msysGit.
> 
> Signed-off-by: Michael Wookey <michaelwookey@gmail.com>
> ---

After manually editing the patch until it applied (some headers which 
gt-am didn't like):

     Acked-by: Marius Storm-Olsen <mstormo@gmail.com>

--
.marius
