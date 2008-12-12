From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/3 (edit v2)] gitweb: Cache $parent_commit info in git_blame()
Date: Fri, 12 Dec 2008 18:20:33 +0100
Message-ID: <200812121820.34695.jnareb@gmail.com>
References: <20081209224622.28106.89325.stgit@localhost.localdomain> <200812110133.33124.jnareb@gmail.com> <7vr64e9jq6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Luben Tuikov <ltuikov@yahoo.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 18:22:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBBiD-0000Q0-4N
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 18:22:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756929AbYLLRUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 12:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756817AbYLLRUn
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 12:20:43 -0500
Received: from ik-out-1112.google.com ([66.249.90.179]:59989 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756799AbYLLRUm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 12:20:42 -0500
Received: by ik-out-1112.google.com with SMTP id c29so393875ika.5
        for <git@vger.kernel.org>; Fri, 12 Dec 2008 09:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=k16QAZkpSwVktLeS3K34si4NV8KYMGXUBdLZBaAeWM0=;
        b=F0rnOkIN4oXBiCuOzMHBpIHvjDOIkKeAO4f2rdYtNjVdWSFpletgxuifMJ9QfaY083
         gNVIuUYbwG7YsUNH6tG/msIORhVTX7f0Wm+IqDcRBEKSfBU/j4JnaeW3xuidTicoAWIU
         m8+1X2ozu8xF1z67rMRtChRbJGNlr3ZOcI4Bc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=A2wY+3ERW2DQDLL9CiZ5d2TXZG6Wattey6qnHZejwd6R7n3l2CNthhlpShnD8Js1Fv
         6TpWeApCYBqM+P5sYXkWXh1FKCfiWu8auMzFgYDAexy0jE44Rk1R+w5Fc6kjpajH970O
         jncyOQRZPOspQuY4DXzN8kponDUtondlyhJAU=
Received: by 10.67.119.20 with SMTP id w20mr5934625ugm.78.1229102439757;
        Fri, 12 Dec 2008 09:20:39 -0800 (PST)
Received: from ?192.168.1.11? (abvt119.neoplus.adsl.tpnet.pl [83.8.217.119])
        by mx.google.com with ESMTPS id y6sm11882814uge.28.2008.12.12.09.20.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Dec 2008 09:20:38 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vr64e9jq6.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102918>

On Fri, 12 Dec 2008, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:

> > Only commit message has changed.
> 
> Which is a bit unnice, because it will conflict with the original [3/3]
> that I queued already (with a pair of fixes, including but not limited to
> the one you sent "Oops, it should have been like this" for).
> 
> I can hand wiggle the patch to make it apply, but I'd prefer if I did not
> have to do this every time I receive a patch.

I'm sorry about that; I have forgot to change order of patches to have
original 1/3, 3/3, 2/3 (I should have used 'stg float' for that).

> I think the conflict was trivial (just a single s/rev/short_rev/) and I
> did not make a silly mistake when I fixed it up, but please check the
> result on 'pu' after I push the results out.

I did the reordering, and gitweb on compared top of reordered stack
of patches with gitweb from top of 'pu' branch, and the only
difference in the area touched by git_blame improvements series is
one comment I have added in v2 of 3/3.

Thank you for your work.
-- 
Jakub Narebski
Poland
