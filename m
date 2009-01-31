From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 1/2] fsck: HEAD is part of refs
Date: Sun, 01 Feb 2009 06:45:20 +0900
Message-ID: <20090201064520.6117@nanako3.lavabit.com>
References: <49814BA4.6030705@zytor.com>
 <7vfxj1eqh6.fsf@gitster.siamese.dyndns.org> <49822944.8000103@zytor.com>
 <20090129223529.GB1465@elte.hu> <20090129224357.GA18471@elte.hu>
 <498231EA.3030801@zytor.com> <7vvdrxd8jz.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.2.00.0901291512260.3054@localhost.localdomain>
 <7veiylb1in.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 22:47:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTNgf-0008PE-4X
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 22:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbZAaVqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 16:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752239AbZAaVqJ
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 16:46:09 -0500
Received: from karen.lavabit.com ([72.249.41.33]:44891 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678AbZAaVqI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 16:46:08 -0500
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 18E6BC86B4;
	Sat, 31 Jan 2009 15:46:07 -0600 (CST)
Received: from 9691.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 67SVCV04TPAJ; Sat, 31 Jan 2009 15:46:07 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=YP9nMlF3KGFztyWpvKx7m+gwcoogDBTcFJ4t5jQkBl2j5yXPTc6PArOF6pZjO91g8FLOdRGI7HCRWm0mkdhPne9bSmqjmBNQKLZbDPiADFRXL9ndUyxct4O8Jc6JBuAglz5/1wspBJZF7puVn5KQC86ZVm+CncscO8DvteIMrI4=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7veiylb1in.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107943>

Quoting Junio C Hamano <gitster@pobox.com>:

> By default we looked at all refs but not HEAD.  The only thing that
> made fsck not lose sight of comments that are only reachable from a
> detached HEAD was the reflog for the HEAD.
>
> This fixes it, with a new test.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

I think you meant to say commits, not comments.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
