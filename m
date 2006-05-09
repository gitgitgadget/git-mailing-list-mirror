From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: [PATCH 1/6] gitopt: a new command-line option parser for git
Date: Wed, 10 May 2006 00:31:41 +0300
Message-ID: <20060510003141.0d0820ed.tihirvon@gmail.com>
References: <1147151209168-git-send-email-normalperson@yhbt.net>
	<11471512103526-git-send-email-normalperson@yhbt.net>
	<20060509120809.4d9494b9.tihirvon@gmail.com>
	<20060509191803.GA3676@localdomain>
	<20060509231031.b62576da.tihirvon@gmail.com>
	<7vlktb2ayy.fsf@assigned-by-dhcp.cox.net>
	<20060510000826.1a708c03.tihirvon@gmail.com>
	<7v7j4u3nv8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 23:31:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdZnG-0002GT-Fp
	for gcvg-git@gmane.org; Tue, 09 May 2006 23:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWEIVaz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 17:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWEIVaz
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 17:30:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:53000 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751103AbWEIVaz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 17:30:55 -0400
Received: by nf-out-0910.google.com with SMTP id b2so1286473nfe
        for <git@vger.kernel.org>; Tue, 09 May 2006 14:30:53 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=V05YNCOyQ43De5lCUFJHUlN+Fzt2vD91L9qT2LD1hXHdzejSOUDo2arNO7iz7v7BVVeYs8wtl4R6E0JwWF2LWI2FsTwrSfRzkvmb9wEUj/OeWIX+Fhb/g3ETK48GRbMBgfeTjXhuvZrEfa7nAsRQtoSLYp/qkNPdp/fj/Shvzac=
Received: by 10.48.3.15 with SMTP id 15mr2433352nfc;
        Tue, 09 May 2006 14:30:53 -0700 (PDT)
Received: from garlic.home.net ( [82.128.200.31])
        by mx.gmail.com with ESMTP id d2sm3750899nfe.2006.05.09.14.30.52;
        Tue, 09 May 2006 14:30:53 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j4u3nv8.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19853>

Junio C Hamano <junkio@cox.net> wrote:

> Timo Hirvonen <tihirvon@gmail.com> writes:
> 
> > Better to support only -x=y or -x y, not both.
> 
> Didn't I just say -x=y where x is a single letter _is_ odd?
> It is either -xy or -x y, not -x=y.

Oh, I thought parameters would use same syntax for short and long
options.  For optional args -C2 would make sense but -C 2 would be
ambiguous ("-C -- 2" or "-C2"?).  Maybe I'm just too drunk to
understand.

-- 
http://onion.dynserv.net/~timo/
