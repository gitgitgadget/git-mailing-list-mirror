From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v4 1/5] fmt-merge-msg: Make the number of log entries
 in commit message configurable
Date: Sun, 22 Aug 2010 12:23:34 +0530
Message-ID: <20100822065331.GA15561@kytes>
References: <1282384699-16477-1-git-send-email-artagnon@gmail.com>
 <1282384699-16477-2-git-send-email-artagnon@gmail.com>
 <20100822033330.GA12380@belmont.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Yaroslav Halchenko <debian@onerussian.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 22 09:16:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1On4mp-0001b7-8B
	for gcvg-git-2@lo.gmane.org; Sun, 22 Aug 2010 09:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353Ab0HVGz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Aug 2010 02:55:28 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57355 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290Ab0HVGz0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Aug 2010 02:55:26 -0400
Received: by pzk26 with SMTP id 26so1874186pzk.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 23:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=S1UXHVaio4L2xUWEmoI5W51sGa0dWEbsFdbeJ5JmLD8=;
        b=e+YHmDF/1dbLQpQxrKPbisHfgke5M4Y5ZyBpwItV/vakCZ30vgUcIoTlT1+RsSvRli
         T3OUfj7ci6ZVg+I8WJNCTR4K7+c+4wV1hXS3CWvJC2/2+csAE2IdOXRjp/YFVHlgLzho
         wxoUm04b/2Ey1d01htWzq6BggFPL8gscZzPd4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=B1R9EkoUOgZxk4VVgsy6+StIqjbvhjkn5cL5ccjyx/7NMoy/N03O2EbtBhdqZLBr2H
         C49g25wcDaO0D6LHHUOlsQ/cpXfhd1usdvCCr8slxPC86/2CPSwS1OZ9zNKXTpmgGLz/
         0jhBMt+UewJ6C3qTeK6DGiHGVYXNISL7ffhlc=
Received: by 10.114.39.2 with SMTP id m2mr4069457wam.45.1282460126076;
        Sat, 21 Aug 2010 23:55:26 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id c10sm9315661wam.13.2010.08.21.23.55.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 23:55:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100822033330.GA12380@belmont.cs.uchicago.edu>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154169>

Hi Jonathan,

Jonathan Nieder writes:
> Hi again,
> 
> Thanks for working on this.
> 
> Ramkumar Ramachandra wrote:
> 
> > Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> > Reported-by: Yaroslav Halchenko <debian <at> onerussian.com>
> 
> Looks like some of the @ signs have been corrupted somehow.

My stupidity- I copied the additional lines off the GMane interface.

[...]
> FWIW if I were writing it, I would make changes in something like this
> order:
> 
>  - Change fmt_merge_msg API to
> 
> 	int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
> 				int shortlog_len);
> 
>    where shortlog_len is 0 for no shortlog, 20 for a shortlog
>    with 20 items.  Update all callers (the changed function
>    signature makes it easy to find them).
> 
>  - Update merge --log and fmt-merge-msg --log options to take
>    an optional "size of shortlog" argument.
> 
>  - update [merge] log configuration to accept an integer
>    "size of shortlog" value.
> 
> The first step might look like this.
[...]

Thanks for being so patient! It looks like there's no end to my
mistakes :p

I'll rewrite this and try to follow the guidelines you've outlined in
future- hopefully, I'll become more experienced someday :)

-- Ram
