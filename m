From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH 4/5] Overhaul of changeset application
Date: Sun, 13 Nov 2005 01:07:12 +1300
Message-ID: <46a038f90511120407y68031071v15244175f6458c54@mail.gmail.com>
References: <20051112092336.GA16218@Muzzle> <20051112092533.GB16218@Muzzle>
	 <20051112092721.GC16218@Muzzle> <20051112092920.GD16218@Muzzle>
	 <20051112093045.GE16218@Muzzle>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 12 13:08:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EauAA-0004Tw-Pc
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 13:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbVKLMHP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 07:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVKLMHP
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 07:07:15 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:46360 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932361AbVKLMHO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 07:07:14 -0500
Received: by zproxy.gmail.com with SMTP id 40so791519nzk
        for <git@vger.kernel.org>; Sat, 12 Nov 2005 04:07:13 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iUTL4lhsZ9rGoIXnSQhNm+1txW9mHiOx6KfVmUWviKFB60sJEqd1xYqTx/NU1fBqbI3CJKufZHn+oGNVaZn8VaEu9qlDp3NT8sW32ygUJv3lqAiXZKLt3+s0pZQcnMT4cnUSZl20hW2dUi1LbvqNEeLMP52P5ECfjAo0uxD2vgY=
Received: by 10.64.184.13 with SMTP id h13mr645028qbf;
        Sat, 12 Nov 2005 04:07:13 -0800 (PST)
Received: by 10.64.242.4 with HTTP; Sat, 12 Nov 2005 04:07:12 -0800 (PST)
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20051112093045.GE16218@Muzzle>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11673>

Eric,

 I'd actually like to improve the script to handle directory renames
and file modes correctly so we don't need to ever call the glacially
slow `tla get` -- I don't think it's that much work, all I need is a
sample repo. OTOH, if you think (or can convince me) that there are
more serious problems ahead, perhaps we can have this as an
alternative import mechanism?

On 11/12/05, Eric Wong <normalperson@yhbt.net> wrote:
>  - Correctly parse multi-line summary text in patch-logs

Was this broken!? I'm sure I've imported multiline summaries!

cheers,


martin
