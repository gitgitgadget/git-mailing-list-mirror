From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/3] unaligned reads from .bitmap files
Date: Thu, 23 Jan 2014 15:17:38 -0800
Message-ID: <20140123231738.GC18964@google.com>
References: <20131221135651.GA20818@sigill.intra.peff.net>
 <20131221135953.GH21145@sigill.intra.peff.net>
 <20140123020536.GP18964@google.com>
 <20140123183320.GA22995@sigill.intra.peff.net>
 <20140123212036.GA21299@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 24 00:18:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6TXF-0004tM-E6
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 00:18:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbaAWXRp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 18:17:45 -0500
Received: from mail-bk0-f54.google.com ([209.85.214.54]:45829 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbaAWXRp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 18:17:45 -0500
Received: by mail-bk0-f54.google.com with SMTP id u14so751590bkz.13
        for <git@vger.kernel.org>; Thu, 23 Jan 2014 15:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Z+tSRj9DJFjHMB37efCCsDoS2BxKpt3fMx/BQEIK7tE=;
        b=Xuf+NN8+DMfIOtLVCiTtjy6aEmz/VFNYkSDXWsWPSX6YlH4VWYQ2VQxZy288qfW2C4
         WfRio2MU28zgfREcHp3nYR/q+h3oMchv+7IYWKW7TFtnhsBktOKFqTsmEQGbEx1+34qG
         HcxT0pBYL/xmszvZMuEYmjGXcE6U4ULpdIoL3U3izm0dZeAdtDMmspN1YmkOLbx4WqfD
         KyxFhHARdOHVzhRnetOntJD5j53O8sGSkckLJWTDDFADqN3pBIQA2n7xjYarEw8PVGQV
         wYwDK+tmy++wNKyac9PxD5hvVdsvUbgqwVFrFR5x8aN+4ej7Doa6JJKhGZ2cItfQcDq6
         ojxQ==
X-Received: by 10.204.172.145 with SMTP id l17mr4836171bkz.26.1390519063921;
        Thu, 23 Jan 2014 15:17:43 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ch4sm619419bkc.8.2014.01.23.15.17.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jan 2014 15:17:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140123212036.GA21299@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240971>

Jeff King wrote:

> Here it is again, fixing the issues we've discussed.

Thanks!  Passes all tests.

Tested-by: Jonathan Nieder <jrnieder@gmail.com> # ARMv5
