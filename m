From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Please make git-am handle \r\n-damaged patches
Date: Wed, 05 Aug 2009 06:15:14 +0900
Message-ID: <20090805061514.6117@nanako3.lavabit.com>
References: <4A7735B0.2040703@zytor.com>
	<81b0412b0908032335s3363849aj32a0e93efa15c012@mail.gmail.com>
	<7v7hxk5b4y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Alex Riesen <raa.lkml@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 23:15:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYRMG-00053A-Kw
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 23:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbZHDVPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 17:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbZHDVPf
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 17:15:35 -0400
Received: from karen.lavabit.com ([72.249.41.33]:43985 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932416AbZHDVPe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 17:15:34 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 761A511B9BC;
	Tue,  4 Aug 2009 16:15:35 -0500 (CDT)
Received: from 9884.lavabit.com (190-14-246-42.ip.mediacommerce.com.co [190.14.246.42])
	by lavabit.com with ESMTP id LKTDIBVPTNNG; Tue, 04 Aug 2009 16:15:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=GHw54vxSlMgTk7+4JWH8LJFa6hr2JviIVDlHSMSufyj2ulpMALrtJEUGGIbHpO4xDXT18kvcTh2z83dh2u+l5VeLW6r52jK5vbvD59/najMgmPfQKd5yhyz9XECF4r35KKuxv2ZpZuoRVUEcS/N9d6pBE8uXwkzq5Zt48EeljiI=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7v7hxk5b4y.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124812>

Quoting Junio C Hamano <gitster@pobox.com>

> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> Maybe it is as simple as that (not tested yet,
>> and sent through gmail, so please be careful):
>
> I thought about this approach, but it made me worried about a case where
> an otherwise sane piece of e-mail has \r at the end of one line as the
> real payload.  But as long as we are talking about a text e-mail (and we
> are talking about mailsplit here and a binary payload with a CTE applied
> counts as text), I think we can safely use an approach like this.

Is it safe to rebase a commit that introduces a carriage-return at the end of the line using the updated program?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
