From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Advice on choosing git
Date: Tue, 18 May 2010 21:12:50 -0400
Message-ID: <AANLkTimymNnHHXnN3dsFfis30FBsuboXc0ILXExB5IkU@mail.gmail.com>
References: <4BEA4B46.6010009@smartmediacorp.com> <201005130018.o4D0I7iI079145@kzsu.stanford.edu> 
	<AANLkTikc6_jZoMzF1VhfJBSk1DRHCNNP3puPT0Z2Usk5@mail.gmail.com> 
	<aCSPCSKYLz8LFwlq@thewolery.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: "Anthony W. Youngman" <wol@thewolery.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed May 19 03:13:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEXqX-00089S-2z
	for gcvg-git-2@lo.gmane.org; Wed, 19 May 2010 03:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755428Ab0ESBNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 21:13:12 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52463 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754725Ab0ESBNL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 21:13:11 -0400
Received: by gwaa20 with SMTP id a20so1505259gwa.19
        for <git@vger.kernel.org>; Tue, 18 May 2010 18:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=XW//Pc6sksttjgyZgRYz8Tf0HgUKhfSWOBzy2ZTIMU0=;
        b=EQHf7DoWondKvdLQW+i/Ea8ANl4M9QXf7mRwr+mwEge/Yp9jmmQVk7+Iyry52Nouis
         f8zsnvRr+AYbfBfr7VJLf6h5K6E3jDDZjimyYsf4saTVYUH+G8xoCwzKQrpqQ0FR3OCV
         ToJ9EkHzMg/C8EMxmG0Vozxkitv7i+IUzsGyY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Q/dol+mou54hE3HbUw121zSF0zLRzdoGb7/AHDYuYYNoU3jaGcz2IZ7U95wHEOxbkR
         4EWeQlrYXpF3/5954U3MKtPmU6nB7wMaolO0dNRmKvJx2UTHeiaJwJKi3Ca4HHlSPAU4
         i6TqTIwo8319LhkU35N0XX4dy5tEhQenh5Q4A=
Received: by 10.151.89.35 with SMTP id r35mr8560881ybl.52.1274231590076; Tue, 
	18 May 2010 18:13:10 -0700 (PDT)
Received: by 10.150.217.12 with HTTP; Tue, 18 May 2010 18:12:50 -0700 (PDT)
In-Reply-To: <aCSPCSKYLz8LFwlq@thewolery.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147315>

On Tue, May 18, 2010 at 8:37 PM, Anthony W. Youngman
<wol@thewolery.demon.co.uk> wrote:
> Just because YOUR computer is modern and is happy being fed a new bigger
> hard drive doesn't mean they all are. This computer here has 3/4gig ram.
> Tiny by modern standards but I can't put any more in - it only has three
> slots at 256Mb maximum each. And it's got a 250Gb drive but it can only use
> the first 128Gb (I'm being economical with the truth here, but hey...)
>
> Anyways. Why should hundreds of people have to throw out thousands of
> serviceable machines just because a few programmers can't be assed to at
> least TRY to be economical with their usage of resources?

It's a tradeoff.  There are a bunch of programs that can sync files
back and forth *without* keeping a history - and those tools are
mostly not used.  IMHO that's because they're too complicated and
dangerous; if something goes wrong with your sync, the
mistakenly-deleted-or-modified files are gone for good.  If I care
enough about my files to want to replicate them for safety, then I
care too much about them to trust them to an unpredictable sync
algorithm.

A version control system like git, on the other hand, makes a
different tradeoff: you can be reasonably sure that it'll *never*
permanently lose data, but to get that assurance, you're going to pay
for it in disk space.

If you want to use yesterday's computers, you're probably going to
have to be satisfied with yesterday's solutions.  AFAIK, home
directory replication has never been adequately solved.  Of course,
someone could still come along and invent an elegant, fast, reliable,
space-efficient, trustworthy solution to this problem.  But I don't
think that person has been along yet.

Have fun,

Avery
