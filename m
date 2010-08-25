From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v5 3/5] merge: Make 'merge.log' an integer or boolean
 option
Date: Wed, 25 Aug 2010 09:22:31 +0530
Message-ID: <20100825035228.GA3280@kytes>
References: <1282494398-20542-1-git-send-email-artagnon@gmail.com>
 <1282494398-20542-4-git-send-email-artagnon@gmail.com>
 <7vmxsbu963.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Yaroslav Halchenko <debian@onerussian.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 05:54:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo74V-0001U3-Ki
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 05:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434Ab0HYDy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Aug 2010 23:54:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50265 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752194Ab0HYDyY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 23:54:24 -0400
Received: by iwn5 with SMTP id 5so213656iwn.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 20:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=HW72/aHiwm7UXIx/bf9L2U+yyIP/m/9WEiqulu5dbxI=;
        b=iS1EeBcfXL6IKVjXK4ujGRLBRnrLn6OrPU5/JxusrDPZIc5+56lBp8Ad4W4HMHnqi1
         N+D/IZ6d8Msa639d9mgbFhoQLRJ6Wqh6XvcU4j6bD/KcK/wxa4MKLocEsXvC0WxnMnIV
         p+NmDmTAeZRjwcbsl/d7zGcM+xRqgpafQ9R4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gYWBrxfhN/1phrxW5+Ck1uKyRSxPbi5Dxwir5DRsQbQI+qomLg9nqOKkPqlKoJ2/pj
         UH1cGomUTu5NNa2oQW64Qt3DPHT6wC+/XI5R/GHr5NYsVp11xW4AC3ounD5xnVtiGtxU
         k9q9KOVgK5hJc6XnTaaVUvvZE6QVy24FlkLms=
Received: by 10.231.152.78 with SMTP id f14mr9766220ibw.60.1282708464303;
        Tue, 24 Aug 2010 20:54:24 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id r3sm820177ibk.13.2010.08.24.20.54.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 20:54:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vmxsbu963.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154408>

Hi Junio,

Junio C Hamano writes:
> This makes sense, but I agree with Jonathan's reviews on 1/5 and 2/5, I'll
> ask you to reroll this on top of what I'll push out shortly.

Thanks! I'll rebase on top of rr/fmt-merge-msg in `pu` and re-roll
later today.

> As to 4/5, I think we should proceed a lot more carefully than what your
> patch does, just like we were extra careful when we went to v1.7.0 than
> when we went to v1.6.0 (see release notes to 1.6.6 for a summary,
> especially paying attention to the third and the fourth paragraph in
> "Preparing yourselves" section).

Ok, I'll look at this and fix the patch accordingly.

> I've queued 5/5 directly on maint.

Right, I saw that.

-- Ram
