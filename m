From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] send-email: fix uninitialized var warning for $smtp_auth
Date: Fri, 18 Sep 2015 15:50:09 -0700
Message-ID: <20150918225009.GA46959@google.com>
References: <1442614370-39880-1-git-send-email-computersforpeace@gmail.com>
 <20150918222524.GA22410@flurp.local>
 <20150918224242.GA45466@google.com>
 <CAPig+cR+W0Kt2y+vspS5dF6FHU=XLWZXJR46r7Rv4JP4gNiKTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jan Viktorin <viktorin@rehivetech.com>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Sep 19 00:50:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zd4Tz-0005Zo-T4
	for gcvg-git-2@plane.gmane.org; Sat, 19 Sep 2015 00:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbbIRWuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 18:50:13 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35779 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbbIRWuM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 18:50:12 -0400
Received: by pacfv12 with SMTP id fv12so62990224pac.2
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 15:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=dusMSHxQ8bkxjB/6HNUCdjrNwtdtG5mOhKLeUoMuAPY=;
        b=pJM2Rgs3xbNPJKv2eOAUBhsMUMe+w7w2cxjMTYnBr/ZfsRowStcNlTPgGmSbUl2/PF
         TZBuFvWLwyLAEDd0fjaVS3V4PDzz5Ity1zx1LoibTDKaRg2EC/YwPaK40EyboWYMcPYa
         X3pohhMu3nGGzp+Yry7Z49Y/TNAvMdE8xMyj1YsOeaA8I3SN9JYpevA986+VPsi5U4oz
         nyJueGJ8GfxVImdf3atCOl1nLE8xJstBF4FWJJFW3WhWGMdQ+v0ROahqPx8y0EMHTwrS
         XUtbFPiivPxYdckuqCV5049pFH+WzbR2RA3jLshWGHKNyd/qc71J7ZzxgZqdbQIicAPT
         Rifw==
X-Received: by 10.68.233.200 with SMTP id ty8mr9783988pbc.80.1442616611630;
        Fri, 18 Sep 2015 15:50:11 -0700 (PDT)
Received: from google.com ([2620:0:1000:1301:a098:188d:dd8b:3b19])
        by smtp.gmail.com with ESMTPSA id si1sm10885593pbc.72.2015.09.18.15.50.10
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 18 Sep 2015 15:50:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPig+cR+W0Kt2y+vspS5dF6FHU=XLWZXJR46r7Rv4JP4gNiKTA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278227>

On Fri, Sep 18, 2015 at 06:47:20PM -0400, Eric Sunshine wrote:
> Makes sense (again). Thanks for the explanation.

No problem. Thanks for the review.
