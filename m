From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetool: use more conservative temporary filenames
Date: Fri, 10 Oct 2014 11:23:13 -0700
Message-ID: <20141010182312.GA78117@gmail.com>
References: <1412758562-25402-1-git-send-email-davvid@gmail.com>
 <xmqq8ukp6qgf.fsf@gitster.dls.corp.google.com>
 <20141010081034.GA44749@gmail.com>
 <2DA99335-66B9-438E-A445-EB54B81EBE7A@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Sergio Ferrero <sferrero@ensoftcorp.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Oct 10 20:23:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XceqQ-0006IP-CD
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 20:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027AbaJJSXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2014 14:23:09 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:57433 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbaJJSXI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2014 14:23:08 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so2232781pad.15
        for <git@vger.kernel.org>; Fri, 10 Oct 2014 11:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=67bj6bmTvIwCbuitFdnIo+8PsP+5RA92wwEMyQNiyJQ=;
        b=CGurcpuVVjE+FM7NQkg+VOnGNsquPcRcvxBDjqs90V0sZ+4/YM+67GMfYRqv0U+5yt
         nHt0k/eaMHoXvQso5VpSjYWz9AnOR5e25tef42+5KsIf+mpJbAsnS4NrQC2YXMmlJN51
         qzSmO86QrfoPGbvHTxWeNHtXv4xCGjgkaUdC0QYZSWEiabhZNttlsJFH2Z+7n/uFeO8q
         P1UPtM0+4m5HDv89pUtxc85V2VzG4cQP3+9Wo7JHsISnxAxP35M+b/fwSGnzly/qr/In
         9VFN+mEF2DAtqLKzkehVgYu4sQ0ztVyAZBrLXe7/qob/Q3gvxN2jAgtgV40MGRpfvmni
         2sGw==
X-Received: by 10.66.194.101 with SMTP id hv5mr7125232pac.82.1412965388036;
        Fri, 10 Oct 2014 11:23:08 -0700 (PDT)
Received: from gmail.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPSA id nz4sm4119000pdb.51.2014.10.10.11.23.06
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 10 Oct 2014 11:23:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2DA99335-66B9-438E-A445-EB54B81EBE7A@hashpling.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 10, 2014 at 10:07:20AM +0100, Charles Bailey wrote:
> While you have the lid of this section of code, should we
> consider (optionally?) using a tmpdir to alleviate the eclipse
> issue where it wants temporary merge files to be the canonical
> locations for definitions of things that it finds when
> scanning source files in the project tree?

Hiding it behind mergetool.usetmpdir seems like a good idea.

That could be a good follow-up patch.
I don't use eclipse so I wasn't aware that this is an issue.

Thanks,
-- 
David
