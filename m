From: "Bert Wesarg" <bert.wesarg@googlemail.com>
Subject: Re: [ANNOUNCE] TopGit v0.3
Date: Wed, 10 Sep 2008 10:18:08 +0200
Message-ID: <36ca99e90809100118m4c2c0904q5f3effb301b0d779@mail.gmail.com>
References: <20080909231009.GD10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Sep 10 10:19:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdKvD-0003rz-Dp
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 10:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbYIJISL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 04:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbYIJISL
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 04:18:11 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:10450 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbYIJISK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 04:18:10 -0400
Received: by wx-out-0506.google.com with SMTP id h27so796873wxd.4
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 01:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=3TBknndubYVoPXuZajtbx0ght7TA1WP3ytdJonx4zYQ=;
        b=vkrc63akERVxLaCF9rlQkIAVD+4D8KgBPjCEiiV6f1i5ynbDTg8cKdS82iJ6plZjb6
         dPKYdKk7oC4V728eoDeWVPlzh1UklBkdAGwIHNaq55MIhlCXEl+2UwrmXJGbePEORMCc
         A2XghfMws+q0LN4WGwUhRoD/INKgOqoXkLyK0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=yBosmUyFUAihIAKBHVuZFrOcEammorSkwkgLCunQnBBt7B1TsNVbJThjXvm1bxPuRa
         ckPOV0DG8owlKPX6GzcRpPSAT6K92YXXKgbtRzFI1Zz4/5h4HgsPeeIvkPJ3w2ZRvpqC
         e7fS6mGiAHwLZA+bQH6zDqlTjNMN9U1A2kppQ=
Received: by 10.70.118.11 with SMTP id q11mr924193wxc.58.1221034688878;
        Wed, 10 Sep 2008 01:18:08 -0700 (PDT)
Received: by 10.70.49.12 with HTTP; Wed, 10 Sep 2008 01:18:08 -0700 (PDT)
In-Reply-To: <20080909231009.GD10544@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95496>

On Wed, Sep 10, 2008 at 01:10, Petr Baudis <pasky@suse.cz> wrote:
>  Hi!
Hi,

Thanks for the release.  I have some notes:

1. .gitignore is not up-to-date
2. tg tells me v0.2

What do I need to publish my TopGit controlled branches, is it enough
to push with:

	push = refs/heads/t/*:refs/heads/t/*
	push = refs/top-bases/t/*:refs/top-bases/t/*

Thanks.

> I decided not to consider the 'tg depend' work by Jan Nieuwenhuiz for
> this release yet, since it will probably take me a bit of time yet to
> fully understand his approach; so far, I have an uneasy feel about it.
You may have noticed my problem with this patch, and it seems that he
is working on a new approach/implementation

Regards
Bert
