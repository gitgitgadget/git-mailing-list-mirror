From: James Pickens <jepicken@gmail.com>
Subject: Re: sparse support in pu
Date: Mon, 17 Aug 2009 09:49:17 -0700
Message-ID: <885649360908170949j3b5dddffq2bb36620187c2bbb@mail.gmail.com>
References: <2729632a0908162309ma6e7d41kc3bafe4575120630@mail.gmail.com>
	 <fcaeb9bf0908170117v67e9f8b1ga56edcda14821e91@mail.gmail.com>
	 <2729632a0908170149o425544dcw52aeb6ac6ee1437d@mail.gmail.com>
	 <fcaeb9bf0908170321o43fa4a6bv95dd78ff7889686f@mail.gmail.com>
	 <4A8932BB.7030002@viscovery.net>
	 <fcaeb9bf0908170441o30005085nb0d4e08f333b6146@mail.gmail.com>
	 <alpine.DEB.1.00.0908171425410.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, skillzero@gmail.com,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 18:50:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md5PQ-0005J7-05
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757568AbZHQQtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757566AbZHQQtU
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:49:20 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:17183 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757504AbZHQQtR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 12:49:17 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1029723qwh.37
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 09:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=76vcic6C2jiy/auOPOv/jKdsYjSDL6rABdh+IjP73lA=;
        b=AhAZ3FUgT+Yciu/Kj9VyDl5dZ18mYXVu4Q4QLxI7/m0PDWtJcvP1lSSMotP6RdNAst
         0FGOzYRNFOgX6ny+1Fy+QOLe7zsSKbw7rE5B+yNAE4bEN62fuhRc2NdQk9CWlnt3JqG/
         vtpUjBbQ0kAksap6tRxlZYtP2Iw59dtF255XI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xhtwdfKmT+YbfMXWLyoWAjIBaiGtZbDjtSPTDk5lVZXb8n0CcWpF7Fz2BEwsiJVCl5
         gf7zSSS0JAKgw4ARTBqmfBIKnKEMBihQdmYRRVj+mmC39nCjl5LRW4+cmikofW1Nv895
         uWdNM2JZfSfhOUbGYWc31AfcqHW+dzaeL7YK8=
Received: by 10.229.117.130 with SMTP id r2mr1948126qcq.12.1250527758059; Mon, 
	17 Aug 2009 09:49:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908171425410.4991@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126226>

On Mon, Aug 17, 2009, Johannes Schindelin<Johannes.Schindelin@gmx.de> wrote:
> The term 'phantom' is not specified at all.  At least interested people on
> the mailing list know 'sparse'.  But I agree that the naming is a major
> problem, hence my earlier (unanswered) call.

I don't particularly like 'phantom' either, but I haven't come up with any
good alternatives.  'sparse' seems fine to me, though it might make sense
to lengthen it to 'sparse-checkout'.

> However, I would find specifying what you do _not_ want in that file
> rather unintuitive, in the same leage as receive.denyNonFastForwards = no.
>
> If I want to have a sparse checkout, I know which files I _want_.

I agree; specifying which files you don't want seems backwards to me.

James
