From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v9] Documentation/remote-helpers: Add invocation section
Date: Thu, 8 Apr 2010 20:52:12 +0200
Message-ID: <h2ifabb9a1e1004081152hbca48fbex11134249aef9df14@mail.gmail.com>
References: <g2vf3271551004062257ycbda64d3z3d3004d802a03fc3@mail.gmail.com> 
	<7vsk77e20r.fsf@alter.siamese.dyndns.org> <n2nf3271551004070950ucf314b40g56087d49dfbd29f1@mail.gmail.com> 
	<20100407224942.GA20239@progeny.tock> <7vzl1eamss.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 20:52:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzwqF-0008TN-E2
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 20:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758967Ab0DHSwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 14:52:34 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:35563 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201Ab0DHSwd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 14:52:33 -0400
Received: by qyk9 with SMTP id 9so480771qyk.1
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 11:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=uLDwiE7NzepZd8gPgZOmUtUrbeg7fz8rvp+xItCTwxE=;
        b=Yky0L2ph16pYEXU1qyNTca+O7xyX/eCSuG+xuVx9zSgZL4vMmhqGJlpn7u/jGTNaFq
         wCVD38xEza3SCJIh82hbgpxqqzNYFNtVEb8aexcK/QrqjDCVzuKXvCvZEUdZ0pJRsFoh
         c2PNZpKfDQg/7PuKgrHHyyDUmXA8PzD4W2RsA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Grf9nJQUJYkxNxsvzcQIDE6PXIsvUVx8J88kHa1IdvpYu/CS/ILiAWFd7TqtSMxDjt
         sATf+UZDJINwereClegONCFrgQ37uH+RmorU3rfvLzKgl6/floquCYWc49DPxol+Tm38
         pgirN0G/iQv/BjF4wFl+nzw9loW2YZeRqC7W4=
Received: by 10.224.74.3 with HTTP; Thu, 8 Apr 2010 11:52:12 -0700 (PDT)
In-Reply-To: <7vzl1eamss.fsf@alter.siamese.dyndns.org>
Received: by 10.224.73.17 with SMTP id o17mr210692qaj.301.1270752752069; Thu, 
	08 Apr 2010 11:52:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144370>

Heya,

On Thu, Apr 8, 2010 at 01:02, Junio C Hamano <gitster@pobox.com> wrote:
> It might look unrelated, but I found it the most helpful information in
> your message ;-) I really hate it when people base their patches on 'pu'.
>
> At least it would be helpful for me if people based their follow-up
> patches on top of their own topics.

Hmmm, perhaps we should update SubmittingPatches to say something
about that? The section that talks about what to base your patch
against [0] is not very explicit in that aspect.

[0] http://git.kernel.org/?p=git/git.git;a=blob;f=Documentation/SubmittingPatches#l106

-- 
Cheers,

Sverre Rabbelier
