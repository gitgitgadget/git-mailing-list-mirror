From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t7300: repair filesystem permissions with
 test_when_finished
Date: Wed, 2 Jul 2014 12:01:59 -0700
Message-ID: <20140702190159.GC5816@google.com>
References: <20140702184429.GA32538@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 02 21:02:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2PnF-0008Bb-4s
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jul 2014 21:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757545AbaGBTCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2014 15:02:04 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:39461 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754675AbaGBTCD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2014 15:02:03 -0400
Received: by mail-pa0-f50.google.com with SMTP id bj1so12955618pad.23
        for <git@vger.kernel.org>; Wed, 02 Jul 2014 12:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=24nYVIli/JS8YL+RJql2eP85QrxtkcQo3CpVWrFULWE=;
        b=pk5Jy3tMIeK7RdOn+bWE4+mpobeHB8Gl2X9jcBacQ7KE2XA6OQr2l0fvxd5uiGBtSa
         5S31yyRrLzgA+cikw/FnhgggaOvsu4hJwIcpnkt1BzCB9OFMQntIms3Ul1e/DtynwKzX
         RhN4Oysbhhf+Lxc5mh/oIeqMbkVofZ1WOm6FNYU/zHIU75GFeTe5bbSiyshQqnW5fOBA
         1XfJvTCr6RbZWAYECbzlux+FNxrF2hdfR2I+ioaBKvPro6HYyWJ3J12ncle4/LPyAY4/
         ZeYyRveaX3TOYyvIEicZyixQ5QRagA1Z/6NCWpeVz0NL0xfEu377/idd0fZjTbGaUw4/
         sZhg==
X-Received: by 10.66.122.208 with SMTP id lu16mr5568353pab.129.1404327722069;
        Wed, 02 Jul 2014 12:02:02 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:9026:10c8:17a1:3751])
        by mx.google.com with ESMTPSA id qk9sm133207360pac.16.2014.07.02.12.02.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 02 Jul 2014 12:02:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140702184429.GA32538@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252829>

Jeff King wrote:

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t7300-clean.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Does the later "git clean -d with an unreadable empty directory" test
need the same treatment?

Thanks,
Jonathan
