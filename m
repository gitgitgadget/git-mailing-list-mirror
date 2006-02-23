From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: PATCH: simplify calls to git programs in git-fmt-merge-msg
Date: Thu, 23 Feb 2006 11:57:24 +0100
Message-ID: <81b0412b0602230257h3713e6e8ud11c6aa9547b0d37@mail.gmail.com>
References: <81b0412b0602230226j12e88682h303d466a273bec09@mail.gmail.com>
	 <7vslqaicqj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 11:57:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCEA7-00057N-FY
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 11:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWBWK51 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 05:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbWBWK51
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 05:57:27 -0500
Received: from nproxy.gmail.com ([64.233.182.205]:61977 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751157AbWBWK50 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 05:57:26 -0500
Received: by nproxy.gmail.com with SMTP id o63so13203nfa
        for <git@vger.kernel.org>; Thu, 23 Feb 2006 02:57:25 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uvf+5BOobb1e4vqbxVlr+rvVzjGbx3qh3t0S8yKDmCFJamRASVcAZcq9qg3qlHjpLs05ut61cSM3/Z7+BuTCYFntcYXjQWqKAJnaNv2U9qXaHjUJdh5q2GwPC5Pn7EdbB+uChd/g/bxzhHmXKaWQQBMSIxJ+yp8oQJmW7KFopT4=
Received: by 10.48.238.20 with SMTP id l20mr2308230nfh;
        Thu, 23 Feb 2006 02:57:24 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 23 Feb 2006 02:57:24 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vslqaicqj.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16641>

On 2/23/06, Junio C Hamano <junkio@cox.net> wrote:
>
> > It also makes it work on ActiveState Perl.
> >
> > ---
>
> ActiveState or not, this simplification is pretty much welcomed.
> The only problem I _might_ have later is with shortlog, though I
> have not looked at it closely yet.

I tested it a bit.
I suppose you can have two following concerns there:
- $tip - it seem to be always an sha1
- perl can decide to fetch whole output of git-log into memory.
  I heard it optimizes such cases into reading only when needed...
