From: "Tim Visher" <tim.visher@gmail.com>
Subject: Re: 'Theirs' merge between branches on a binary file.
Date: Tue, 23 Dec 2008 09:05:17 -0500
Message-ID: <c115fd3c0812230605x369af9c0n372db761fa11ce39@mail.gmail.com>
References: <c115fd3c0812221256l494bb824ga8e1640efb07b20c@mail.gmail.com>
	 <7vr63zhq4k.fsf@gitster.siamese.dyndns.org>
	 <c115fd3c0812221316y24ce0c7q29807cd349a99e83@mail.gmail.com>
	 <7vd4fjhlf8.fsf@gitster.siamese.dyndns.org>
	 <c115fd3c0812221458q3444cbcai7ab1716b9195ad08@mail.gmail.com>
	 <7v3agfhk8b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 15:06:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF7uA-0004zs-1W
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 15:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbYLWOFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 09:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbYLWOFT
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 09:05:19 -0500
Received: from mail-gx0-f27.google.com ([209.85.217.27]:46486 "EHLO
	mail-gx0-f27.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089AbYLWOFS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 09:05:18 -0500
Received: by gxk8 with SMTP id 8so2132716gxk.13
        for <git@vger.kernel.org>; Tue, 23 Dec 2008 06:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=qAlTwEuCGcKTXDeQ/GLAyRO5lHn9tnPdphq4Lf3yjNY=;
        b=xRkS8qLrAbksHKhNYVcxNN50497he1aKvZxnL3WYBp74nB+cTGwWQQaI47ge6+LP9w
         MlDITijAccZ59mff5Ot5PEo1HA6dWP/e3RRy3Xq0mkHR+hk/Xy03SzgVFij/99GOlutj
         xs/vqCt9pmmDOzBRkTrVLdd1G9M0nWwgF0ijI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=eFINo4MyJprEhNvcYLmqAnbzfZlDKGD2+ODm/mHntQ9RpcRAEIzNdxK9lHTiOWIcj1
         pcZiSKmu/OOIEbPgwYI5CmLGLfmXFgLf3CQ8/fa4w4c1YRZKYnMCi+oAMKfRNAuNc1V/
         42LS4P9arCSJmgDy57GnwUhYzgIc1foRKulLg=
Received: by 10.100.134.16 with SMTP id h16mr4564388and.42.1230041117210;
        Tue, 23 Dec 2008 06:05:17 -0800 (PST)
Received: by 10.100.198.2 with HTTP; Tue, 23 Dec 2008 06:05:17 -0800 (PST)
In-Reply-To: <7v3agfhk8b.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103819>

On Mon, Dec 22, 2008 at 6:18 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Hmph, I meant to point you at:
>
>    http://www.kernel.org/pub/software/scm/git/docs/git-checkout.html

Ah, yes.  There it is. :)

> I think you can use "git checkout-index --stage=3 path" if your git is
> older than that one with the option.
>
> v1.6.0.1-15-g38901a4 (checkout --ours/--theirs: allow checking out one
> side of a conflicting merge, 2008-08-30) introduced the feature.

Apparently this was added, at least to the docs, only in the latest
release?  That's kind of weird A) because the tag indicates 1.6.0.1,
not 0.6, and B) It's a pretty trivial operation in other VCSes.
Hmm... Maybe I'll try to updated the docs to make this feature a
little more visible.

Anyway, the checkout-index command does indeed work in the older
version.  That's kind of what I was looking for.  I'm now working on
compiling git under cygwin as the latest version cygwin installs for
you is 0.4!

Thanks for your help!

-- 

In Christ,

Timmy V.

http://burningones.com/
http://five.sentenc.es/ - Spend less time on e-mail
