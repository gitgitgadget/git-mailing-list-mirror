From: "David Rientjes" <rientjes@google.com>
Subject: Re: [PATCH] combine-diff.c remove unused return variable
Date: Sun, 13 Aug 2006 18:27:06 -0700
Message-ID: <9ec263480608131827j1a945016xaa9b7a1c8de41698@mail.google.com>
References: <Pine.LNX.4.63.0608131730470.24283@chino.corp.google.com>
	 <7voduogmfm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 03:27:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCRF2-0006Xd-LN
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 03:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbWHNB1N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 21:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751775AbWHNB1M
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 21:27:12 -0400
Received: from smtp-out.google.com ([216.239.45.12]:60337 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751714AbWHNB1M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 21:27:12 -0400
Received: from zps38.corp.google.com (zps38.corp.google.com [172.25.146.38])
	by smtp-out.google.com with ESMTP id k7E1R81e019483
	for <git@vger.kernel.org>; Sun, 13 Aug 2006 18:27:08 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=we92VXvr5MyEqcwm8isVWT5KmVH7olQaD7j0UruvN/7yoqpVDOuCJxM+bjA89PQkY
	DXOriabuYPGCrP+779r5g==
Received: from smtp-out2.google.com (fpe16.prod.google.com [10.253.5.16])
	by zps38.corp.google.com with ESMTP id k7E1NP7h011292
	for <git@vger.kernel.org>; Sun, 13 Aug 2006 18:27:06 -0700
Received: by smtp-out2.google.com with SMTP id 16so19597fpe
        for <git@vger.kernel.org>; Sun, 13 Aug 2006 18:27:06 -0700 (PDT)
Received: by 10.253.1.18 with SMTP id 18mr155541fpa;
        Sun, 13 Aug 2006 18:27:06 -0700 (PDT)
Received: by 10.253.15.12 with HTTP; Sun, 13 Aug 2006 18:27:06 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7voduogmfm.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25306>

On 8/13/06, Junio C Hamano <junkio@cox.net> wrote:
> dave rientjes <rientjes@google.com> writes:
>
> > Removes unused return variable.
>
> True.  Then making the function void would make more sense, like
> this?
>

Sure, as long as the author was not planning something for it later.

David
