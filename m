From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 2/2] read-tree: at least one tree-ish argument is required
Date: Sat, 19 Dec 2009 12:25:09 +0900
Message-ID: <20091219122509.6117@nanako3.lavabit.com>
References: <4B274BDE.8000504@viscovery.net> <fabb9a1e0912181137t1265f86cs9e02019da136a0a@mail.gmail.com> <7veimsvz8a.fsf@alter.siamese.dyndns.org> <200912182304.27656.j.sixt@viscovery.net> <m3d42cc4i8.fsf@localhost.localdomain> <7vr5qrsv4g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 04:29:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLq0G-0003uf-CX
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 04:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846AbZLSD3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 22:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754111AbZLSD3F
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 22:29:05 -0500
Received: from karen.lavabit.com ([72.249.41.33]:35128 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753783AbZLSD3E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 22:29:04 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id D7842157552;
	Fri, 18 Dec 2009 21:28:59 -0600 (CST)
Received: from 1890.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id R8CB4833TQYJ; Fri, 18 Dec 2009 21:28:59 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=GnAL9tpTP2Sa64pgQK3ZqemRb/Xo4N9vGq6rqJFnb0oz9++sDb0JeWp+udQ7V286jVK0DHDVd36rz3hxop/YLpUp67xrWTv+lq4dv5ZeMMkCpiq0pnm5/gi78dj5DxUzv/AjEim8pkUTXeuRPMiR21vidDjhyp4vbzMUwFg/vdE=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vr5qrsv4g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135459>

Quoting Junio C Hamano <gitster@pobox.com>

> Come back with a proof that there has never existed any script that uses
> "read-tree" without arguments to purge the index, and I'd immediately
> accept and apply the patch to retroactively forbid what the implementation
> has allowed users to do for a long time.

For what it's worth, I compiled the very first version of git

 commit e83c5163316f89bfbde7d9ab23ca2e25604af290
 Author: Linus Torvalds <torvalds@ppc970.osdl.org>
 Date:   Thu Apr 7 15:13:13 2005 -0700

     Initial revision of "git", the information manager from hell

and its read-tree fails with 

  read-tree: read-tree <key>

Is it a proof enough?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
