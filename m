From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 6/6] test: fix '&&' chaining
Date: Thu, 8 Dec 2011 11:18:05 -0600
Message-ID: <20111208171805.GG2394@elie.hsd1.il.comcast.net>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323349817-15737-9-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 18:18:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYhbs-0002PO-4a
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 18:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752630Ab1LHRSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 12:18:12 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:46023 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502Ab1LHRSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 12:18:09 -0500
Received: by ggnr5 with SMTP id r5so2237180ggn.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 09:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=kX9tBTfSZHIK8mGW+qOlajxvFEIiVPEAH+I9kXkh6u4=;
        b=ceZAXPwIJhPCPO/rEV05KN3ykKRDas+S5zp02p7LTbxBsYJXdnNetfEDECgZ/8h8Xh
         fIABPlKNZKXUdoljq+i/uAWJAfWHjdin5tPief9kgi6xXjBhoKQakgbSTUXBKUxAIL2P
         hRjxxdsb0yhp3Q1lVH7K+o7Mt2LhMJAkkPGD4=
Received: by 10.101.214.28 with SMTP id r28mr916000anq.118.1323364688527;
        Thu, 08 Dec 2011 09:18:08 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id i22sm10033245yhm.10.2011.12.08.09.18.07
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 09:18:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1323349817-15737-9-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186578>

Ramkumar Ramachandra wrote:

> Breaks in a test assertion's && chain can potentially hide failures
> from earlier commands in the chain.  Fix instances of this in the
> following tests:
> 
> t3419 (rebase-patch-id)
> t3310 (notes-merge-manual-resolve)
[...]

The reader can read the diffstat, so I am not sure this list is very
useful.

With the space gained, it might be helpful to mention that this patch
only adds " &&" to the ends of lines and that any other kind of change
here would be unintentional, to put the reader's mind at ease.

[...]
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

The patch proper looks good, so if this is tested,
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
