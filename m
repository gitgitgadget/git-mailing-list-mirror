From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Documentation status
Date: Mon, 5 May 2008 09:34:38 +0200
Message-ID: <200805050934.40851.jnareb@gmail.com>
References: <20080502053051.c8066c4e.chriscool@tuxfamily.org> <200805050548.58905.chriscool@tuxfamily.org> <7vy76pnzo9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Jeff King <peff@peff.net>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	"Manoj Srivastava" <srivasta@ieee.org>,
	"Ping Yin" <pkufranky@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 05 09:35:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsvES-00007W-4A
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 09:35:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbYEEHen (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 03:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752931AbYEEHen
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 03:34:43 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:19031 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbYEEHen (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 03:34:43 -0400
Received: by fg-out-1718.google.com with SMTP id 19so28262fgg.17
        for <git@vger.kernel.org>; Mon, 05 May 2008 00:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=ARsZcWYcnxaLOUxNekLVTOffVRXOVJhy++pP0/2b3ws=;
        b=ePnP694GX8KppcPKUi9aLcLZKfXdBTYqJRlLomPTvCrLSzH4U8qyeXs1oGNPr6gmnF1rF4YxvbxzSWASVeUzdr8uX+x/G35KHrI5sojMEtmbRS6c5Vp0FuAyZlijg/h0ldfx+DYNJbwWuC7lHqK8WR+vkOMZuvXEsiqEUZ+G6sg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=X+Wj/qDKwC18qmyoI8i+/MhC9cKJl7aNFbQYBQ0SxFxbkZINWH2XX2vZzVB7lfK5GVeqvMEF3mxIpwVSGR1Bf4/rbkfY5r2mKwVChJcDhUZ8+slBTve/KfOXSJalqOpEfjSE2DSRtye+4n58JosIAIRH94KKvQtOiyRVuNUSCUc=
Received: by 10.86.66.11 with SMTP id o11mr9098666fga.74.1209972881503;
        Mon, 05 May 2008 00:34:41 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.199.6])
        by mx.google.com with ESMTPS id u9sm26302220muf.12.2008.05.05.00.34.37
        (version=SSLv3 cipher=OTHER);
        Mon, 05 May 2008 00:34:40 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vy76pnzo9.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81237>

Junio C Hamano wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
[...] 
>> Ok, I will do that.
>> Then what about tutorials (that I put in section 7) ?
> 
> Please step back a bit.  What's the reason why you need to make
> everything into manpages?

I think the main idea was to make into manpages all documentation which 
is referenced from manpages, perhaps with the exception of 
documentation listed in git(7)/git(1).

This way one use man viewer such as 'pinfo', and follow references to 
other manpages...

-- 
Jakub Narebski
Poland
