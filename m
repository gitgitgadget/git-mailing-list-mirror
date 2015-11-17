From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] check-ignore: correct documentation about output
Date: Mon, 16 Nov 2015 16:22:16 -0800
Message-ID: <CAGZ79ka2t7qZGSa5vOUsgXz7atuWmz_soCj39T85T21SmAthNA@mail.gmail.com>
References: <20151108201036.GA28434@spirit>
	<1447683184.2733.0.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 17 01:22:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyU2P-0006qV-Oi
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 01:22:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbbKQAWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 19:22:17 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35095 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbbKQAWR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 19:22:17 -0500
Received: by ykba77 with SMTP id a77so267636892ykb.2
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 16:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ajiVNYGeCD/TVwCv8oSSuXhnFd6nDDQeevs1XU7jydM=;
        b=IlG28eUV3/yuknXNgr3X38RSUurUt+T54oMa01cNDvdza9VvADl1+YsjC7P8eojBUM
         Jw/aLv9x88NAjQx52Roepl2COvPTkvjlJm+V/6rwDqNJju4sjj3Dxy8jDLHxLvZLFTO/
         gbg9TFWKusuVBn7/u9IlI/OCoQS/xnGVJMxo6QR018U3nrp+khM6q70zLBa0eQ+JsNM0
         ZJRTe192ttPb7L6kfyuARFo3o74zYiVlKg8SKke1689cXgCm2+CJrmrPhG8zRFovZ+FT
         elFwKT5EICkUyc79rnz0Pq2i3pNOlL7259Q8W1abWAkq65fqQ4RUbamQ3j2KX7OJRgVB
         7WfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ajiVNYGeCD/TVwCv8oSSuXhnFd6nDDQeevs1XU7jydM=;
        b=YLIXDoekkLnS865aVvO/nQkyvVhPv5qm12a5I0Vs+A38iGpyEkcpMnm1D0lCd18k7B
         GceZH3IFVZPQ4mN4uZbatIxcQzRL+lUC8Aw1AGwBjuN4xDRsIBk2IZ4jPqZD+5iZ00jp
         mb1T6C0VYLU7YlD9kv+aBhlAemAfstF5W1BkgYGg43DBo8OsTp6uzn+7YPH2HYd2cNwd
         LTZF8kNdzi6WMNgl5KADhDM3Ha9YS74Bv5ZmDS24OOo3KTsSONKCtDDGPZVcLGudTK+r
         /GEM3verfSb1TQCmgHP+OLsE9jiNCF39OF7s8COJvk/Rt2PtaiKTBkBBZiexYtu0jYAf
         GtQA==
X-Gm-Message-State: ALoCoQmrFFCBXCLR2dlenBEJFZDEROv0QhRxzsqDZdYyLiknKLNs9uSPlPmR6gNQZdG+DbN6jJyw
X-Received: by 10.13.251.2 with SMTP id l2mr39247057ywf.44.1447719736388; Mon,
 16 Nov 2015 16:22:16 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Mon, 16 Nov 2015 16:22:16 -0800 (PST)
In-Reply-To: <1447683184.2733.0.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281372>

+cc Jeff

On Mon, Nov 16, 2015 at 6:13 AM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> Ping.

Junio is on vacation, so Jeff is our interim maintainer,
and it seems he isn't up to full power as Junio. :)
