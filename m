From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] mergetool: Remove explicit references to /dev/tty
Date: Fri, 20 Aug 2010 09:19:13 -0500
Message-ID: <20100820141913.GE16190@burratino>
References: <20100820035236.GA18267@gmail.com>
 <1282303049-11201-1-git-send-email-charles@hashpling.org>
 <20100820122724.GS10407@burratino>
 <4C6E883A.2030301@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Magnus =?utf-8?B?QsOkY2s=?= <magnus.back@sonyericsson.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 16:21:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmST1-0002Ny-GA
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 16:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635Ab0HTOVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 10:21:06 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34755 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab0HTOVF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 10:21:05 -0400
Received: by wwi17 with SMTP id 17so4138228wwi.1
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 07:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0OohO2ZxJ1Li6wRg8LGq8Ep/94WG56zE4LEQG4+mXP8=;
        b=IG1lAXt7Re4N4CyDfspMr6Xz9ZwdZz2GKDZwo8p0vSTqGi9+a+UxmgJMpGYWT0gggm
         fYeYjpvM7cxGChZC6vpM3Yq6FuYHnkxLEXJtPTGjlLGjDllEqI96pHpDCDkzPbiyMSP9
         /JxdoQ9hCH0y6nhFSCj44H8aFwBe8OcefygU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dW7AK6Cdx/Xglk+/eAiyGahduyl+efPv5zy5qLiaUPuDbdlEBqalZ5iLoGSMXLJRMM
         5SEgPgVvQsQx8Rpd1pQx+zclsrRNIFNFNpI7TnTFC47A+RfzGQF+rOg9s3RXjf9bdUhN
         qDiWNojXX5jwORxjFsk7ZKkMiS2j+rjlPfwaM=
Received: by 10.227.68.149 with SMTP id v21mr1280014wbi.138.1282314063291;
        Fri, 20 Aug 2010 07:21:03 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id m25sm2481829wbc.7.2010.08.20.07.21.00
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 07:21:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C6E883A.2030301@hashpling.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154042>

Charles Bailey wrote:
> On 20/08/2010 13:27, Jonathan Nieder wrote:

>> With the patch below on top, it passes with dash and ksh.
>
> Thanks, I'll re-roll in a bit at squash your fixes in, if that's OK?

Yeah, that's okay. :)

Thanks for your work.
