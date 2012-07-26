From: Alexey Muranov <alexey.muranov@gmail.com>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Thu, 26 Jul 2012 19:24:40 +0200
Message-ID: <91CA9DC6-FBAE-410F-A182-E83FBA769AC6@gmail.com>
References: <20120719213225.GA20311@sigill.intra.peff.net> <20120719213311.GA20385@sigill.intra.peff.net> <50092993.6010203@alum.mit.edu> <20120720154403.GB2862@sigill.intra.peff.net> <5009892E.9010808@kdbg.org> <20120720170913.GA14057@sigill.intra.peff.net> <CACsJy8BtcvuW2HKPSki7meyHMsvpLS0b8QG5M_083HEwy=-9EQ@mail.gmail.com> <10DD3DE0-E554-4BE3-A20B-FDBC73219646@gmail.com> <vpq8ve6qxui.fsf@bauges.imag.fr> <20120726165949.GB13942@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 26 19:24:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuRnv-0004Vv-1F
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 19:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab2GZRYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 13:24:45 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:54763 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422Ab2GZRYo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2012 13:24:44 -0400
Received: by eeil10 with SMTP id l10so444555eei.19
        for <git@vger.kernel.org>; Thu, 26 Jul 2012 10:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=R52xVDO6ka5nuPo7FaFADakBS3Y2AwOAOVzdffggvFw=;
        b=Fp2ZSEwNWUq2iDEkzSzQRM3XEKvxR4Kl3eq5Ejep8BwXr21knXfXPO387CRcNnALjR
         P2ou3zFf9z5llvTXFdMLYHdx7TTKZVLDW3ad61AYDEsyXcRUiv8u9MW4Y22GfFmpzThP
         HgNl/UngiROviuit7aa+4GX7P0wGIy9YwXkrztRwcEGgjjWu0uCfRXimSSv5+OYrUEsz
         IY7eQAMNUoR+Zi66UKuCeE2JCUzu0cAZCM4h5SZHYeSD5a3qfUtVi1vS91LLFVU+yYVh
         ZUBKzjRjzSctmTtV0/Hm+S7tsqvI4oBye1N/mTku/M/7pRVYDTEO/Ka0Zdr3fS0vvca9
         AqFQ==
Received: by 10.14.214.196 with SMTP id c44mr4993999eep.7.1343323483465;
        Thu, 26 Jul 2012 10:24:43 -0700 (PDT)
Received: from ?IPv6:2a01:e35:2f10:380:223:12ff:fe56:641a? ([2a01:e35:2f10:380:223:12ff:fe56:641a])
        by mx.google.com with ESMTPS id s8sm10371791eeo.8.2012.07.26.10.24.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 26 Jul 2012 10:24:42 -0700 (PDT)
In-Reply-To: <20120726165949.GB13942@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202280>

On 26 Jul 2012, at 18:59, Jeff King wrote:

> Not to mention git itself, as it splits up the refs/remotes hierarchy
> into subdirectories. I think deprecating "/" is out of the question.
> 
> -Peff

Ok, i guess you know better than me, my vision of Git is probably still too simplistic.

-Alexey.