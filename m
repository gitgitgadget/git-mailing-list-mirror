From: Nicolas Sebrecht <nicolas.s-dev@laposte.net>
Subject: [PATCH RFC 1/6] Re: send-email: Add --delay for separating emails
Date: Thu, 9 Apr 2009 18:17:56 +0200
Message-ID: <20090409161756.GA12910@vidovic>
References: <49dcb464.06d7720a.66ca.ffffbd30@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 18:19:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lrwye-0006yl-S4
	for gcvg-git-2@gmane.org; Thu, 09 Apr 2009 18:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758597AbZDIQSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Apr 2009 12:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753548AbZDIQSF
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Apr 2009 12:18:05 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:44492 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754233AbZDIQSC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Apr 2009 12:18:02 -0400
Received: by ewy9 with SMTP id 9so764887ewy.37
        for <git@vger.kernel.org>; Thu, 09 Apr 2009 09:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=x+Ckw84PRGGT+Wwi+D4EcxpuCi4KRNUmozUE41N1IVg=;
        b=fbMxz+ff+OWPGuRwtqGmMFOgZwTI2HEJ8Q9tC6LH5y6s6xqdhT0r23PS67+qY9VB4X
         PIaF9d+f8eir+EjZv39ue0sD3Ice2VY8xxizAbThtYvTxVAyxtbqTozOJfFWFfPqSopm
         U6rVi/PsOF2HRl7MQMZ0mbuPzRQgK7enpKGNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GPotVimSwkU0MaZmXJ58AxaY2RP906YCEycjdbdzePyyfVrHQmcfmcrWJOnr8G/BRu
         bYOMBNxThO8toy5DqQb8zE4cyW7zPQFexvUyrFRLe6yx7o4h6U/AmnOGEzvsjnRwfUw9
         oenXsXtupSxDdokHqsJ1mxS04/VcOsjue8qN8=
Received: by 10.216.13.74 with SMTP id a52mr653180wea.145.1239293880519;
        Thu, 09 Apr 2009 09:18:00 -0700 (PDT)
Received: from @ (91-165-136-189.rev.libertysurf.net [91.165.136.189])
        by mx.google.com with ESMTPS id x6sm1048721gvf.0.2009.04.09.09.17.58
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 09 Apr 2009 09:18:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <49dcb464.06d7720a.66ca.ffffbd30@mx.google.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116178>

On Wed, Apr 08, 2009 at 09:25:25AM -0500, Michael Witten wrote:


> This has nothing to do with what the receiver wants. This has everything
> to do with what the sender wants. I want my patch series to be in order
> even for wrongheaded receivers.

The --delay option may have an undesirable side effect. In case of
non-chained emails, unrelated mails could be insterted between patches
where *all* MUA would be affected. It's not only true for very high
volume message mailing-lists (million monkeys receiving...). FMPOV, it's
worse than all display issues we already know or have with the current
behaviour. 

-- 
Nicolas Sebrecht
