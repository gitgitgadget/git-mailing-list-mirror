From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] fast-import: add 'ls' command
Date: Thu, 2 Dec 2010 13:37:24 +0100
Message-ID: <AANLkTi=HuPK+q_+hdkg4yK45UcoOA5PAGi4OmsojCsFa@mail.gmail.com>
References: <1291286420-13591-1-git-send-email-david.barr@cordelta.com> <1291286420-13591-2-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 13:37:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO8Q7-00089M-Ft
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 13:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757458Ab0LBMhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 07:37:46 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:55976 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757441Ab0LBMhp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 07:37:45 -0500
Received: by yxt3 with SMTP id 3so3540104yxt.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 04:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=L8d0MPYKO5haypyd6nAuJ1KS+YRrAmg4KFLKq4dp7lE=;
        b=iTCPnnkiNXa79O3WgZo7OccDBehJ1jl3vhB2idjeOrW0MtKhkJcYSxyIOIOQ628T7W
         UujDfxU8WzHMj1vfQmZW1iXgPJcvtCuX118K0SlSyCbNLvhgBjI7PG+clhgEN3ygNkUY
         H89fHoK9R5qztcMi7RzoZ/Q697yMjRi+YhFsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qBJOCT8SMwH2yOcu4WggCXH/zTYl55qiiwzxMXbdfibj9KJZ6slBh2VvtFeWHj+UlF
         /b1hOVyGl+pGq8pdTcEiEXzPdUZ/ID4vOQ5r9yAdrTMl24qdIRvwAhKHQdeoHwSKNErg
         r764l8knx2BMfKLfosA0dOl225O9RNSe4tUDs=
Received: by 10.151.10.3 with SMTP id n3mr1377292ybi.245.1291293464392; Thu,
 02 Dec 2010 04:37:44 -0800 (PST)
Received: by 10.151.100.19 with HTTP; Thu, 2 Dec 2010 04:37:24 -0800 (PST)
In-Reply-To: <1291286420-13591-2-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162697>

Heya,

On Thu, Dec 2, 2010 at 11:40, David Barr <david.barr@cordelta.com> wrote:
> There are two forms of the 'ls' command, one that takes a tree-ish and
> one relative to the index. Allow the tree-ish variant to be used anywhere
> a comment is allowed. Allow the index variant to be used within a commit
> where file change commands would be used.

The commit message doesn't explain why the index variant isn't allowed
anywhere a comment is allowed. I assume that's because there's a
half-constructed index if you're in the middle of a modify operation
or such?

-- 
Cheers,

Sverre Rabbelier
