From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: Problems Cloning an SVN repo.
Date: Tue, 9 Dec 2008 13:09:34 -0500
Message-ID: <eaa105840812091009k292ced25vcd638808c913b76@mail.gmail.com>
References: <c115fd3c0812090954n6e5e527anadf04936e1ca01f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Tim Visher" <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 19:10:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA72t-0001U8-D3
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 19:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686AbYLISJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 13:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753706AbYLISJh
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 13:09:37 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:46383 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573AbYLISJg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 13:09:36 -0500
Received: by qyk4 with SMTP id 4so211029qyk.13
        for <git@vger.kernel.org>; Tue, 09 Dec 2008 10:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=DLZ7yByIxWxBY0foyd1OM6V+tfaZqpzBD9ifjg/j8Uc=;
        b=nCzwqiAoTITWy7sgXiqcR/H2Md2TJF1h3sYYROluAWC5nZUV4TBfvPvZbkpYG+qVwa
         Wwx3O84zHO/u897tIjyuMpg0crC7rXJFpvl2I8g10HeDCvHoILPlS7uGjd6rx3TMuzE0
         OgxqZU1v8imoVdTjqzl2I1BfxSw4jSxwMRY4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=b3H5HuO2wvV7rynKyJ8UwjVt+WL0pzLIIBJOFEeyCWHY+V47BhH8wipY/3qg2HvTbt
         xPhC/BVNWwgcakAzWcq+9Fsrs1owqdAxGk47LeQjpDyCiW3XMhNsublpXuR+6t8Ixfkd
         f+xCSh18N/ci40SQhw1LT4kZRpVFo3hNH+ptw=
Received: by 10.65.119.14 with SMTP id w14mr341641qbm.18.1228846174966;
        Tue, 09 Dec 2008 10:09:34 -0800 (PST)
Received: by 10.65.230.19 with HTTP; Tue, 9 Dec 2008 10:09:34 -0800 (PST)
In-Reply-To: <c115fd3c0812090954n6e5e527anadf04936e1ca01f@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: ce18b7cd173fe8fa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102644>

On Tue, Dec 9, 2008 at 12:54 PM, Tim Visher wrote:
> Hello everyone,
>
> I'm trying to use `git svn clone` to begin to work with a project
> stored in subversion through git for the work I do on the project
> locally.  I installed git through cygwin and I'm getting the following
> error when executing the command.
>
>    Can't locate SVN/Core.pm in @INC (@INC contains:
> /usr/lib/perl5/site_perl/5.10 /usr/lib/perl5/5.10/i686-cygwin
> /usr/lib/perl5/5.10 /usr/lib/perl5/site_perl/5.10/i686-cygwin
> /usr/lib/perl5/vendor_perl/5.10/i686-cygwin
> /usr/lib/perl5/vendor_perl/5.10 /usr/lib/perl5/site_perl/5.8
> /usr/lib/perl5/vendor_perl/5.8 .) at /usr/sbin/git-core//git-svn line
> 29.
>
> Any help?

Did you install the subversion-perl cygwin package?

Peter Harris
