From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] disallow refs containing successive slashes
Date: Mon, 12 Oct 2009 11:47:00 +0900
Message-ID: <20091012114700.6117@nanako3.lavabit.com>
References: <4AD0C93C.6050306@web.de>
	<7vws327wbp.fsf@alter.siamese.dyndns.org> <4AD1B6A4.8060405@web.de>
	<7vbpkdwyo2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 04:48:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxAxp-0000qo-Bd
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 04:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753261AbZJLCsG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 22:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216AbZJLCsF
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 22:48:05 -0400
Received: from karen.lavabit.com ([72.249.41.33]:49927 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753194AbZJLCsF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 22:48:05 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 4EAA911B8F6;
	Sun, 11 Oct 2009 21:47:28 -0500 (CDT)
Received: from 6443.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id D1TZSJ7BJ8LT; Sun, 11 Oct 2009 21:47:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=c8aTrmQRQwVPY1TtEuchAlKU4ZFyDF2qphcQbC4kEpLcI1O9KfFrIDd8cWIN+m7IOcsH7F5+cZpxb/DPVdxYh31CeeCqe1RG5PxX+8iNChKTsr9UaEGHWgQOs6ty6e+XwIhwLoZ7h9VDTytZFwT22YvXY/NSGF7HpeR03kZylOs=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vbpkdwyo2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129968>

Quoting Junio C Hamano <gitster@pobox.com> writes:

> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> Yes, one solution could be to fix every application handling branch, tag
>> or repo names to mimic the namechange done in the bowels of git. But i
>> think it is not worth the hassle.
> Besides, by rejecting what we used to accept you are breaking people's
> expectations.  So I am moderately negative, unless you can say your "every
> application" is literally _tons_.

Isn't 1.7.0 a good release to break such people's expectations?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
