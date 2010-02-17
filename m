From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH v3 1/4] Refactoring: remove duplicated code from 
	builtin-send-pack.c and transport.c
Date: Wed, 17 Feb 2010 10:23:07 +0800
Message-ID: <be6fef0d1002161823u48dc42f9g8b532e03763af17@mail.gmail.com>
References: <cover.1266360267.git.michael.lukashov@gmail.com>
	 <57f2a1b845f82f86709c71d1fbc530bb5fdb1a7f.1266360267.git.michael.lukashov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael Lukashov <michael.lukashov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 03:23:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhZZN-00077A-7E
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 03:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933466Ab0BQCXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 21:23:12 -0500
Received: from mail-iw0-f185.google.com ([209.85.223.185]:42650 "EHLO
	mail-iw0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933335Ab0BQCXL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 21:23:11 -0500
Received: by iwn15 with SMTP id 15so5952483iwn.19
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 18:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=/CKMlQqR2bMDZKUfqcMxYogUKBvTFNU4fncVjIqvUxo=;
        b=qIfp9rPSTvPGOXzdMUhkZzVen2beO1OAiCFx/eHgQHzDJsHeC3bniBQnYvMSqru8GV
         ZkIsbmFHab/pHQ89tZxKqrwrijI5dPoTTufyr0Vz7z7Iazz+wEX5SucLYnXVjBXyRUiA
         H/CzGC+4X7WEGIAx4vAMbcXlG0m/VgxseiPII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=evptvl+EfnjLLY2q/OxmYOIOJ5gBzfuo3inbULE9h7gYm9RvWPQ6lzaSFfqFsgOehl
         kDrzAAXCIjy9qG3SmSL4qxUxvCtI6FIHxWkz6dM23Yn6dVgqgvSWseFDWVlVaLGjxTow
         RlUeZGFlorvLx3dTHrD0jPWG+qnEm7Xb/BZzY=
Received: by 10.231.190.146 with SMTP id di18mr4282581ibb.19.1266373387329; 
	Tue, 16 Feb 2010 18:23:07 -0800 (PST)
In-Reply-To: <57f2a1b845f82f86709c71d1fbc530bb5fdb1a7f.1266360267.git.michael.lukashov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140199>

Hi,

On Wed, Feb 17, 2010 at 7:42 AM, Michael Lukashov
<michael.lukashov@gmail.com> wrote:
> [snip]
> Also, move #define SUMMARY_WIDTH to transport.h and rename it TRANSPORT_SUMMARY_WIDTH
> as it is used in builtin-fetch.c and transport.c
>
> Signed-off-by: Michael Lukashov <michael.lukashov@gmail.com>

Apart from the long line in the patch message, looks ok to me.

Acked-by: Tay Ray Chuan <rctay89@gmail.com>

-- 
Cheers,
Ray Chuan
