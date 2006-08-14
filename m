From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 28/28] makes upload_pack void
Date: Mon, 14 Aug 2006 15:51:01 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141549150.21515@chino.corp.google.com>
References: <Pine.LNX.4.63.0608141340060.19383@chino.corp.google.com>
 <dbfc82860608141545s3e75457eo4be1201395e24354@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 00:51:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GClHB-0006nx-5q
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 00:51:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbWHNWvO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 18:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbWHNWvN
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 18:51:13 -0400
Received: from smtp-out.google.com ([216.239.45.12]:51680 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S965012AbWHNWvN
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 18:51:13 -0400
Received: from zps75.corp.google.com (zps75.corp.google.com [172.25.146.75])
	by smtp-out.google.com with ESMTP id k7EMp9Nl003652;
	Mon, 14 Aug 2006 15:51:09 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:cc:subject:in-reply-to:
	message-id:references:mime-version:content-type;
	b=lgOYwPWYbou8/uIxTdUwvfZecrLaTu4eRqKn+WOhPGWPm/O7o6i0iIS4h8Wo1E9x1
	RsbHvTZsgVfGuVtCL+BkQ==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps75.corp.google.com with ESMTP id k7EMp2dx011421;
	Mon, 14 Aug 2006 15:51:03 -0700
Received: by localhost (Postfix, from userid 24081)
	id DF09F87D71; Mon, 14 Aug 2006 15:51:01 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id 9708E87D70;
	Mon, 14 Aug 2006 15:51:01 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: Nikolai Weibull <now@bitwi.se>
In-Reply-To: <dbfc82860608141545s3e75457eo4be1201395e24354@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25418>

On Tue, 15 Aug 2006, Nikolai Weibull wrote:
> I don't know for sure, but I'm guessing the intention was to be able
> to return a failing code /if/ there ever was a condition where
> upload_pack() would fail, e.g., if send_ref() would return a status
> code instead of die():ing if it can't parse the given sha1.  In a
> future libification, the change of return type may have to be
> reverted.
> 

Of course.

If upload_pack were modified to return an error code based on a specific code 
path, I trust the implementer would know how to change void to int.

		David
