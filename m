From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit] Import file(s) problem
Date: Thu, 27 Nov 2008 22:06:01 +0000
Message-ID: <b0943d9e0811271406u6768f45csdb5ae775436404b8@mail.gmail.com>
References: <492EC5F5.2050807@ruby.dti.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: kha@treskal.com, git@vger.kernel.org
To: "Shinya Kuribayashi" <skuribay@ruby.dti.ne.jp>
X-From: git-owner@vger.kernel.org Thu Nov 27 23:07:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5p1F-00056n-FH
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 23:07:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753359AbYK0WGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 17:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753342AbYK0WGF
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 17:06:05 -0500
Received: from mu-out-0910.google.com ([209.85.134.185]:27298 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbYK0WGC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 17:06:02 -0500
Received: by mu-out-0910.google.com with SMTP id g7so970253muf.1
        for <git@vger.kernel.org>; Thu, 27 Nov 2008 14:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=C3IyfwYXke6GnfoZfy9jmI08chm9ozShJ7VkWFlOkGY=;
        b=J2NiEB/fnhNJ8DKUdbYPpPJzu76j7p1h/aGURhfp5X25JOcXjY3XhieZcJoKeuaPnS
         P7Vdm3hfgH3S5+OVDy0pgsbycfqbcokHEFglUT9a43Hlu2sawMCUnAD4dNRCWXhZggrW
         1tt3SPMLako82xio9EPG5LBFs2Yb7OI88ldSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IBhTGT6Fm6TkB7CRFtksGeAPrxyMC/ElSyMUPUao5337PV2fjccwgDHSe8tcFE1237
         LmQBwKOqIYDzInSJD7MT79uCekkRlj/l0Q69qkoJ9yzubYjOi7ogmUgTiWTW7c1xaPb2
         cO07IHOwfwXEUgc0YQ4/bavBksw1oaFnIeCkI=
Received: by 10.187.173.6 with SMTP id a6mr1693066fap.83.1227823561189;
        Thu, 27 Nov 2008 14:06:01 -0800 (PST)
Received: by 10.187.191.12 with HTTP; Thu, 27 Nov 2008 14:06:01 -0800 (PST)
In-Reply-To: <492EC5F5.2050807@ruby.dti.ne.jp>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101842>

2008/11/27 Shinya Kuribayashi <skuribay@ruby.dti.ne.jp>:
> Today I encountered a problem when importing a patch.  I don't know this
> is a known issue or not. If there are good workarounds for this, I'd
> like to know that.  Any comments are appreciated.
>
>
> Steps to reproduce
> -------------------
>
> 1. Prepare a patch, say stg-test.patch
>
> 2. Rename it to have '..' extension

The '..' construct has special meaning in both Git and StGit meaning
an interval of commits or patches. We'll need to reject patch names
with '..' to avoid such errors.

-- 
Catalin
