From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] tests: factor out terminal handling from t7006
Date: Wed, 13 Oct 2010 22:10:14 -0500
Message-ID: <20101014031014.GA14664@burratino>
References: <20101014030220.GB20685@sigill.intra.peff.net>
 <20101014030403.GA5626@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 14 05:13:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6EGH-00010N-UC
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 05:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314Ab0JNDNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 23:13:40 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:64332 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754062Ab0JNDNk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 23:13:40 -0400
Received: by gwj17 with SMTP id 17so2196549gwj.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 20:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uLi2qzSAcF+3kyKL8Xcf8rH/+C7C6rQpqD8/U2a45GI=;
        b=eTDRfgizme+rgxmZjCcBJdvhI8RfGbhy82tAj4gq3rbv0IemafW6Te/xk6QgJwozxQ
         yebAqawXqc2Z/YfZEWDwhZymwtACpgqFhXL6HScg5VFl0oKEeij0ibesuOQ52c6W8t8j
         rVvkz4eihKecXLSeoQOQO+pD8GXPHAo8MjbKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=oH/pH1uWEKVeQJ7VHp99ocvRRhcjQibcnZM9ZbFxFT4d5VXBxzCf+XbhxGl4XBNpKW
         xyocuaqqqe7dFZzzfhjsYYcS7a+z3aRl1bAt4ZSNtnQoCHllMDehyDvQbVmRiAVt8Cgm
         O9IC/QjeSddsCp0jASI0XjvuNYfocChS47jA8=
Received: by 10.100.45.1 with SMTP id s1mr905899ans.86.1287026019323;
        Wed, 13 Oct 2010 20:13:39 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id w3sm13057992anw.25.2010.10.13.20.13.37
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 20:13:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101014030403.GA5626@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159019>

Jeff King wrote:

> Other tests besides the pager ones may want to check how we handle
> output to a terminal. This patch makes the code reusable.
> 
> Signed-off-by: Jeff King <peff@peff.net>

Thanks!  Looks good to me.
