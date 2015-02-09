From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 2/2] sha1_file: fix iterating loose alternate objects
Date: Mon, 9 Feb 2015 01:44:51 -0800
Message-ID: <9DC6FCD7-8C5B-464F-B47F-EC8AC37E9549@gmail.com>
References: <20150209011159.GA21072@peff.net> <20150209011538.GB21123@peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jonathon Mah <me@jonathonmah.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 09 10:45:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKktn-00040L-Hq
	for gcvg-git-2@plane.gmane.org; Mon, 09 Feb 2015 10:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760016AbbBIJoz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2015 04:44:55 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34807 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759767AbbBIJoz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2015 04:44:55 -0500
Received: by mail-pa0-f44.google.com with SMTP id kq14so4038116pab.3
        for <git@vger.kernel.org>; Mon, 09 Feb 2015 01:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=QX8e2jrORAjvhzDK9yoCYv+4xb2DKir0EH026A/EVHQ=;
        b=Iko1h0euoZBp4fvneYFBsVmeEHeNYUwMcShT8ncqN/aN8WOeRUHzbOn3t5wzXaAogf
         Jl+q1O+HkzpPPXrkRLVMrT7YtHODjBY2DcwY+4tfN35MshZjx6aNqAsT+mDaF0O8F5qv
         maKSsj+ivdedrbcNbEm1x99oDX/EifFQjZBDodC8iimZBcvFgUT59ZKzlbwaJa8n1qUB
         knJIp5pn9XGtAHnbDGFpdREJMQAxj/BhJh19VxOrvwYq+NdLPpNxYJv4WOI4+pScgrAc
         zs3vfcKcr9EPut4LVlztPl54FlasFrnBY2kszQzdwGeLoIdkkSC6pBjXes46S7LhFGX8
         7qPg==
X-Received: by 10.68.125.227 with SMTP id mt3mr27378448pbb.118.1423475094583;
        Mon, 09 Feb 2015 01:44:54 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ge7sm15756721pbc.16.2015.02.09.01.44.53
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Feb 2015 01:44:53 -0800 (PST)
In-Reply-To: <20150209011538.GB21123@peff.net>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263558>

On Feb 8, 2015, at 17:15, Jeff King wrote:
[...]
> Signed-off-by: Jonathon Mah <me@JonathonMah.com>
> Helped-by: Kyle J. McKay <mackyle@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I think the S-O-B should still stand, as the code is now a mix of our
> work, and the tests are still Jonathon's. But let me know if you do  
> not
> want your name attached to this. ;)

That's fine.

This fix looks much better. :)

Unfortunately I can no longer reproduce the original bug as the  
repository that caused it is no longer in a state that triggers the  
problem (and my backups of it are either slightly too old or slightly  
too new).

-Kyle
