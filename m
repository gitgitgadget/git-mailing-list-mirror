From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Remove unused t/t8005/iso8859-5.txt file
Date: Sat, 29 Aug 2009 17:08:09 +0900
Message-ID: <20090829170809.6117@nanako3.lavabit.com>
References: <20090829161637.6117@nanako3.lavabit.com>
	<7vy6p3giwf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 29 10:08:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MhIzJ-0002a3-6U
	for gcvg-git-2@lo.gmane.org; Sat, 29 Aug 2009 10:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbZH2IIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2009 04:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbZH2IIa
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Aug 2009 04:08:30 -0400
Received: from karen.lavabit.com ([72.249.41.33]:42024 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718AbZH2II3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2009 04:08:29 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id C3A0211B8A6;
	Sat, 29 Aug 2009 03:08:31 -0500 (CDT)
Received: from 9617.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id GDC7TIWTNS6M; Sat, 29 Aug 2009 03:08:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=jQqw0bNChQ3uYECcE7f7BAEN5M2cblO0Z66pQKxhC6k0G/7wtxkv+igQ4O/lywsKyZXj3IJYHCktpVkNXzZ2+u0OBC7p7gn4BnpLYWZZfRygYx5YskWLvGy/tpZcq30PGkvRXm5NaCw40dne/vQU0AJCWvwkZXcrHSp7+bptTXU=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vy6p3giwf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127377>

Quoting Junio C Hamano <gitster@pobox.com>

> Out of curiosity, how did you find this?

Soon after you posted your original in http://thread.gmane.org/gmane.comp.version-control.git/121881, I applied it to my tree, and I have been running 'git pull --rebase' for ever. I noticed that rebase didn't remove the commit, even after your 54bc13c.

Today I found that the rebased patch only removed that file. The real question is how you lost the deletion of the file when you applied. What happened?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
