From: Arun Raghavan <ford_prefect@gentoo.org>
Subject: Re: Removal of post-upload-hook
Date: Fri, 15 Jan 2010 11:42:19 +0530
Message-ID: <6f8b45101001142212i4151c625k54b450cd5978f158@mail.gmail.com>
References: <6f8b45101001141001q40d8b746v8385bc6ae37a6af4@mail.gmail.com> 
	<20100114193607.GB25863@coredump.intra.peff.net> <20100114194107.GA20033@spearce.org> 
	<20100114204305.GC26883@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 15 07:14:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVfSK-0000UM-Lj
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 07:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293Ab0AOGMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 01:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200Ab0AOGMl
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 01:12:41 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:24328 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128Ab0AOGMk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 01:12:40 -0500
Received: by qw-out-2122.google.com with SMTP id 3so80788qwe.37
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 22:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type;
        bh=9trw6xvjNt5EX4aM42LyNK/BDDtiAVvEtPp8vvJvhbA=;
        b=EmCu8ZC9qapvD5YLWJgvlOd6kj7G6JifCIHSuZXcisBWSiS57MStpOTv94BfC5rVcG
         cid5iEuHS1n14PH4mR7mXvbZH1zqjCBwn1aWQaZGDUDxUzgvz8tJJmYq900KIswgGlYS
         4+LwDS11z8RkOFAgCeR9qTLy7a1/D43NyyBKo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=ZHsxjM9Z0q+6QqJYgDmlHxjdyrekY8v2u7+E43H3Jv2xNTyQmqotb+Ib1PPQc8lYi1
         dn84f7z/R12Lg3ccjb10roqXgV6EECVAS45af42+v7CunX4LIaV5RzOxaIkoS9ZqZZ/A
         NqlxRH8tEwpqZL6S8lYgqZxE1wZmwjTdIMCck=
Received: by 10.229.69.84 with SMTP id y20mr1798457qci.18.1263535959600; Thu, 
	14 Jan 2010 22:12:39 -0800 (PST)
In-Reply-To: <20100114204305.GC26883@coredump.intra.peff.net>
X-Google-Sender-Auth: 5482d597265b4bad
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137051>

2010/1/15 Jeff King <peff@peff.net>:
> On Thu, Jan 14, 2010 at 11:41:07AM -0800, Shawn O. Pearce wrote:
>
>> > Because receive-pack runs as the user who is pushing, not as the
>> > repository owner. So by convincing you to push to my repository in a
>> > multi-user environment, I convince you to run some arbitrary code of
>> > mine.
>>
>> Uhhh, this was in fetch/upload-pack Peff, not push/receive-pack.
>>
>> Same issue though.
>
> Errr...yeah. Sorry for the confusion. But yes, it's the same mechanism,
> except that it is even easier to get people to pull from you (to get
> them to push, you first have to get them to write a worthwhile code
> contribution. ;) ).

:)

Another thought - would it be acceptable to have a config option to
enable/disable these types of hooks, so that people who are not
affected by the problem or explicitly don't care can use them? Perhaps
a core.allowInsecureHooks ?

Cheers,
-- 
Arun Raghavan
http://arunraghavan.net/
(Ford_Prefect | Gentoo) & (arunsr | GNOME)
