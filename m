From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [RFC/PATCH] branch: show me the hot branches
Date: Wed, 15 May 2013 08:54:14 -0400
Message-ID: <CABURp0oH-n59hbUzUefztf6DjJWR26Tu6zUX6VNQ292icwxh4w@mail.gmail.com>
References: <1368475365-18680-1-git-send-email-artagnon@gmail.com>
 <CABURp0rVoRwWUBXP5ZdsPByd47hDj7w9y5eddNQfiDfkttAKvg@mail.gmail.com> <7vip2ldtlg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 15 14:54:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcbEF-0001n7-B2
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 14:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932636Ab3EOMyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 08:54:39 -0400
Received: from mail-vb0-f48.google.com ([209.85.212.48]:38530 "EHLO
	mail-vb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932490Ab3EOMyg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 08:54:36 -0400
Received: by mail-vb0-f48.google.com with SMTP id q16so400431vbe.35
        for <git@vger.kernel.org>; Wed, 15 May 2013 05:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=t5u18ZU6neAMdFhQXmKpyVUH1v70g8/E2nKZJsgXPKU=;
        b=igIcmgtWZXVzi8Hi5MIaHFh5eDna+iHBSV52n0ZBbIKrRtAw7xkH6OoqPgw0iGFyzP
         H+TKIGjvr+qkQLJtwpAhLBOzYb/tfLhU1GheeQwIGCVSph1yNCVZyFoagb34ruVDf9EX
         Sj7wBsQmb5oaFiOfuasq6kFJgDdjzyU0KBNJRya/byBR4MDnS0h2Qf1DiTd8xUG4ic9g
         SD8k6Ju4ZVdn0xznDGurukXWvgimHVCxNzvMaXgGV57XOKdqEe//BoFkt5uXCE0qIkLx
         BORS+mZTqYcf8kbyQSEIqeRCSQWAsNuysIHTotZ2LBNsZwHjFpfph6MYIxj5uQVQOSnm
         jZoQ==
X-Received: by 10.58.255.229 with SMTP id at5mr23341397ved.44.1368622475833;
 Wed, 15 May 2013 05:54:35 -0700 (PDT)
Received: by 10.58.135.1 with HTTP; Wed, 15 May 2013 05:54:14 -0700 (PDT)
In-Reply-To: <7vip2ldtlg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224402>

On Tue, May 14, 2013 at 7:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Phil Hord <phil.hord@gmail.com> writes:
>
>> I imagine it with --date-order and whatnot.
>
> Perhaps modeled after this one.
>
>     git for-each-ref \
>         --format='%(refname:short) %(subject)'
>         --sort='-committerdate' refs/heads/
>

Nice.  I had no idea about for-each-ref.  I knew it was out there, but
not what it could do.  Another tool in the swiss army knife that is
git.

I think Duy was right about his patch's merits.

Phil
