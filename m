From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [RFC/PATCHv8 00/10] git notes
Date: Fri, 20 Nov 2009 10:28:00 -0000
Message-ID: <20091120192800.6117@nanako3.lavabit.com>
References: <1258681154-2167-1-git-send-email-johan@herland.net> <7vk4xl5y3z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 11:28:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBQj6-0007mX-W7
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 11:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752391AbZKTK2C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 05:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752393AbZKTK2C
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 05:28:02 -0500
Received: from karen.lavabit.com ([72.249.41.33]:57509 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752190AbZKTK2A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 05:28:00 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 16BA411B88D;
	Fri, 20 Nov 2009 04:28:05 -0600 (CST)
Received: from 5990.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id FAWFP9PHRGXV; Fri, 20 Nov 2009 04:28:05 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=QUqcFOAK6U1DMsAZLaSqYWsoTodKwpwuSIzEeNzg5t20HjHiHh1qqb8PLg8OeoOyeO8mvTdaWODqF+cNRR1GR3NrCLuRz7jw7hjceNwnJRHxU/vFjGpXTSF3Jm1xw0bv7nHW4F7xc4eaNc7jNiM/OZSTmF7D7N71ySceGs5TsYo=;
  h=From:To:Cc:Subject:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
In-Reply-To: <7vk4xl5y3z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133326>

Quoting Junio C Hamano <gitster@pobox.com>

> So here is what I did tonight.
>
> Step 0.  Apply as you specified on top of 'next'
>
>     $ git checkout next^0
>     $ git am -s your-10-patches
>     $ M=$(git describe)
>
> Step 1.  Rebase back to the bottom of the old series
>
>     $ git checkout next...jh/notes

What do three-dots mean in this command?

>     $ git rebase --onto HEAD next $M
>     $ N=$(git describe)

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
