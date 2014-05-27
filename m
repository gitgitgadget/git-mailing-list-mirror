From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH 01/15] builtin/add.c: rearrange xcalloc arguments
Date: Mon, 26 May 2014 19:38:38 -0700
Message-ID: <20140527023838.GA16507@hudson.localdomain>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
 <1401118436-66090-2-git-send-email-modocache@gmail.com>
 <20140526231156.GA8570@hudson.localdomain>
 <CAN7MxmUPH5-qgZQ-Wm0GeenNmqHvtwtx5WkXynNX9zRP3Yr1tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Gesiak <modocache@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 27 04:38:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wp7Hs-0000q5-Uy
	for gcvg-git-2@plane.gmane.org; Tue, 27 May 2014 04:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441AbaE0Cip (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 22:38:45 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:51563 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbaE0Cio (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 22:38:44 -0400
Received: by mail-pa0-f44.google.com with SMTP id ld10so8341648pab.17
        for <git@vger.kernel.org>; Mon, 26 May 2014 19:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Qb3hMP2NHswkaD/XzKfruPGEKdLZCKAmTvSrp4U5DJs=;
        b=Epmy8ivq3ERdbuSG/LlOZb/PKHvfJ2bYptCGhB9MC8B2UVh/R5lXqkuI/EhSNYQZSE
         hhI5G3b/wt575QTdY4C8+khL8vR2P9n+JHnmnIzuO+ZfoUDBW1nB5VWbttwJJOJhxQuq
         /75JDQn038rJbxb4lycIp3K+SybwPBGPsEOYGJECuPBvfRhi4WL9CPdknft5ANAt/88n
         kWi3OMg6ioC9bgrz9/Z08HFoImduA/HIATxmvbUALmwq8s5TXR6WxpVZIoMPTnPtL45F
         OUVmeC5lwwddWjxyAQNJKIFzalx02/ulUNXmqvfRT0qjOCcCVkiLrkO0xq2J+V4w1NBC
         x91g==
X-Received: by 10.69.19.225 with SMTP id gx1mr32418669pbd.34.1401158324097;
        Mon, 26 May 2014 19:38:44 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id wq10sm66142899pac.24.2014.05.26.19.38.40
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 19:38:42 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 26 May 2014 19:38:38 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Brian Gesiak <modocache@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAN7MxmUPH5-qgZQ-Wm0GeenNmqHvtwtx5WkXynNX9zRP3Yr1tQ@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250137>

On Tue, May 27, 2014 at 11:22:00AM +0900, Brian Gesiak wrote:
> My apologies! I based my work off of maint, branching off of eea591.
> 
> My reasoning was that Documentation/SubmittingPatches states that "a
> bugfix should be based on 'maint'". [1] Now that I think about it,
> this is probably not the kind of "bug" that statement had in mind.
> 
> Should I reroll the patch based on master?
> 
> - Brian Gesiak
> 
> [1] https://github.com/git/git/blob/4a28f169ad29ba452e0e7bea2583914c10c58322/Documentation/SubmittingPatches#L9
> 

OK, got it.  I should have read Documentation/SubmittingPatches more
closely like you did :-)  No need to reroll I can just use the maint
branch to test it out.  Thanks!

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
