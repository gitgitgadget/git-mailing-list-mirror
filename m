From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: [PATCH] Fast forward strategies allow, never, and only
Date: Sat, 19 Apr 2008 18:06:00 -0700
Message-ID: <402c10cd0804191806h5460eb82y2442517343734b8e@mail.gmail.com>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
	 <402c10cd0803172127u480276c9s4f9d716b4912ad5e@mail.gmail.com>
	 <7vskym310l.fsf@gitster.siamese.dyndns.org>
	 <402c10cd0803192347q7b4a3fb0s35737f361d53a86a@mail.gmail.com>
	 <7vbq56ilnj.fsf@gitster.siamese.dyndns.org>
	 <402c10cd0803252050u582111cag18674e0257ac2884@mail.gmail.com>
	 <402c10cd0803302119r251b3a43te69ce2a52e121ba5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 03:07:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnO1K-0006C8-IK
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 03:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbYDTBGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 21:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbYDTBGE
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 21:06:04 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:52850 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbYDTBGC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 21:06:02 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1178385fgb.17
        for <git@vger.kernel.org>; Sat, 19 Apr 2008 18:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CKDNBxRdUXg6/2gb45NIeC0u6VlEtcqTilnVbrRcgAE=;
        b=pZxEJEvZrMEPg00FsZOQcwT3dpNwnOs4ZTwj3bP6ERNczCUnqXWiHfevPs+UQwSVR7J9hH0k1YGfTVfhDQq47c4yxacNiU+hlby9d6fckPvkiZb1zoqTzZ0Zw8A5YM7PcQLizPdEwsjvmPX/sIo0Jwd1TEjuFM6SVv5XLioHals=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nXZ5kqCkIX6MMqMbfph+2+5B/rZCt1m0pkDkCL95qUxasr2h+nj7zRK71A8gAVI6IqNBE6s+bAH1jjb/IZbohOdCYBDfXG8oB3cjSLLWxND1b/dLmCuhuz5XITDS6JGOm+69RcFdx8Ojj8lhsRRlTL84RbgucrTBVMktu2hHxLM=
Received: by 10.82.127.14 with SMTP id z14mr5698879buc.33.1208653560323;
        Sat, 19 Apr 2008 18:06:00 -0700 (PDT)
Received: by 10.82.156.16 with HTTP; Sat, 19 Apr 2008 18:06:00 -0700 (PDT)
In-Reply-To: <402c10cd0803302119r251b3a43te69ce2a52e121ba5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79943>

On Sun, Mar 30, 2008 at 9:19 PM, Sverre Hvammen Johansen
<hvammen@gmail.com> wrote:
> I have attached a new set of patches to this email (to avoid
>
> line-wrapping issues if someone needs them for testing).  They are
>  also posted inlined for comments.
>
>  The patch series consists of the following five patches:
>
>    0001-New-merge-tests.patch
>    0002-Introduce-ff-fast-forward-option.patch
>    0003-Restructure-git-merge.sh.patch
>    0004-Head-reduction-before-selecting-merge-strategy.patch
>    0005-Introduce-fast-forward-option-only.patch

I consider myself finished with this and as far as I am concerned it
can be applied to git.git.  I am currently using this on top of 1.5.5
in production and assume it to be good.  All tests passes.

-- 
Sverre Hvammen Johansen
