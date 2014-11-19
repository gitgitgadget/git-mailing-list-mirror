From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] lock_ref_sha1_basic: simplify error code path
Date: Tue, 18 Nov 2014 18:07:13 -0800
Message-ID: <20141119020713.GT6527@google.com>
References: <20141119013532.GA861@peff.net>
 <20141119013739.GC2135@peff.net>
 <20141119020009.GR6527@google.com>
 <20141119020451.GA2734@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, sahlberg@google.com,
	gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 03:07:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqufv-0001bL-7n
	for gcvg-git-2@plane.gmane.org; Wed, 19 Nov 2014 03:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101AbaKSCHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 21:07:12 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:57293 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871AbaKSCHL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 21:07:11 -0500
Received: by mail-ie0-f170.google.com with SMTP id tr6so6424364ieb.29
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 18:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Uq//9mmDCS8IMvg9QoCPxVEyfKZzYACp4jfhtZe4yFg=;
        b=HIs8E1562K9Q7JU3wOMSJievVualry6uCLc2cyvrdC5GAjDMOIVCCaesEB4luY2XRl
         qMsUdB9BnZ6n0Igsi1EnY04+lgE+MtFy0WouHwb2qmAqJTHCvHL9HfnvYDtgKLpW74Jn
         hMdR4pV8Ww3BWHRVPnAxpENEER4sfkZRpLnxyVo/Yna90DnFBiWpXV/HStofbM1Fk9f3
         6upigYt84E6SnOKl49bm6g0tw8mEpN8rF5jyzaDWxeR3szKVwaKKmlkfzh5BKYe7vCO1
         4qt3n/p+2PHpwz81BRXeh2rw0ncCXL0VytGTYHE7UI1acry9x8/wiHexGzX8CCntZ6av
         a2xw==
X-Received: by 10.43.129.196 with SMTP id hj4mr470207icc.21.1416362831064;
        Tue, 18 Nov 2014 18:07:11 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:48de:79f7:30eb:4507])
        by mx.google.com with ESMTPSA id w7sm135218igl.7.2014.11.18.18.07.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 18:07:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141119020451.GA2734@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Hmph. Should we just abandon my series in favor of taking Ronnie's
> original patch, then? We can apply the "save/restore errno in error()"
> patch independently if we like.

I liked patches 1 and 2 and the explanation from patch 4.  Perhaps
patch 3 should be replaced with a patch renaming unlock_ref to
free_ref_lock or something.

Thanks,
Jonathan
