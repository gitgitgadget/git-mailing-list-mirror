From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] fix pack.packSizeLimit and --max-pack-size handling
Date: Thu, 13 Nov 2008 06:42:24 +0900
Message-ID: <20081113064224.6117@nanako3.lavabit.com>
References: <7vk5b8q1l4.fsf@gitster.siamese.dyndns.org>
 <cccedfc60811120712o7fcbf648l9f4b8e6f52e50e39@mail.gmail.com>
 <alpine.LFD.2.00.0811121109420.27509@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Nicolas Pitre <nico@cam.org>, Jon Nelson <jnelson@jamponi.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 22:44:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0NW8-00033r-Gp
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 22:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbYKLVnL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 16:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752818AbYKLVnK
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 16:43:10 -0500
Received: from karen.lavabit.com ([72.249.41.33]:48241 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249AbYKLVnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2008 16:43:09 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id D81FAC86A7;
	Wed, 12 Nov 2008 15:43:07 -0600 (CST)
Received: from 1492.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id QS3UCFT73H7S; Wed, 12 Nov 2008 15:43:07 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=1vfzHeSpzXvPrnE6ij5FB/mR29if72nPvIQatmy/POrgWVac5VFOzQuUSgctgtwgszKsohouNaFm9D9Wnpj51yOk5gdWcgzyElH3dl1y2FEQUElVynMTfOV4mNDQp19kVn36gkiYLwn6HlAXsZPQti527NBg1XSfVYoNB9hVS0g=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vk5b8q1l4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100817>

Quoting Junio C Hamano <gitster@pobox.com>:

> I think --max-pack-size is what should be fixed to use git_parse_ulong()
> to match the configuration, if you find the discrepancy disturbing.

But doesn't that break existing scripts and habits?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
