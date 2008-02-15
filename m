From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/3] mailinfo: ensure handle_filter gets only one line at a time
Date: Fri, 15 Feb 2008 18:37:06 -0500
Message-ID: <76718490802151537r7658e109o3c981832ae32154d@mail.gmail.com>
References: <1203112418-25199-1-git-send-email-jaysoffian@gmail.com>
	 <7vodahg5w4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 00:37:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQA7k-0001Ke-KF
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 00:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324AbYBOXhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2008 18:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753519AbYBOXhK
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 18:37:10 -0500
Received: from hs-out-0708.google.com ([64.233.178.251]:8038 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753804AbYBOXhI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 18:37:08 -0500
Received: by hs-out-0708.google.com with SMTP id 54so616641hsz.5
        for <git@vger.kernel.org>; Fri, 15 Feb 2008 15:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RF5FkpKfVYnkJ30E2eE0D/vc1GsX7pSjPOX+3/Uy0jE=;
        b=gMxg+5F8UzZd+t0nNaVJWIxks34FqW/BNLVqsfnMM4iOJ4HWcCtmHqLbGHqyorWOs7lH2vSRGK/+HkhSem3yxelk2/PyPhWYM8O3XsIdct5XqfS+8Wd+V4bLcwu81gM96PnO2kjxbIpMiwzL6QxmUzCN7pQWMrYaL7QmkCUflXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QDtnjHXBWNuQ4+ZPkvCx8DX9M31C1t1NoU7CL8P/FRt7HWuosiwS2K/Jwea1VImJJrSzDmZ7CQ79JPbNGWxMJ0HdbA1ZOPTaf2NGg/ZK65i0qjPnJDZl8kCdAZDaAWWnlE3GDZVd4oxWqGQU7PX//HMh7QltKofHoDz/vsYfRrQ=
Received: by 10.114.52.1 with SMTP id z1mr3583267waz.123.1203118626128;
        Fri, 15 Feb 2008 15:37:06 -0800 (PST)
Received: by 10.114.255.11 with HTTP; Fri, 15 Feb 2008 15:37:06 -0800 (PST)
In-Reply-To: <7vodahg5w4.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73998>

On Feb 15, 2008 6:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> And it appears to be an obvious fix that should even go to
> 'maint' where no new features will land.

Yes.

> Care to provide a test case for this one?

I'll see what I can do. I'm not sure it makes a difference w/o my
format=flowed additions, so there may not be a test case, but I'll poke
it with a stick some more.

-- 
j.
