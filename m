From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [ENHANCEMENT] Allow '**' pattern in .gitignore
Date: Thu, 4 Oct 2012 08:34:02 +0700
Message-ID: <CACsJy8C2QcNPte+C9aFHOD1oTqopqdX2=6KG13s4dPrPoONYVg@mail.gmail.com>
References: <CALkWK0nXfeAnFfdFtdDNdEwtk0mMPtpYbg8sPzfrEXUpXsGQOA@mail.gmail.com>
 <506A9EA6.9010303@gmail.com> <CALkWK0=X5nJ6Shwa0+6Jk2cgvvo25j=mKLRs4v=eQY7x9+XvFw@mail.gmail.com>
 <CACsJy8CUK0g4FhuJxzJqN7qS2apoO2zYdg_SGvWzEN5dGcHhaA@mail.gmail.com>
 <506C3F23.9000009@web.de> <CACsJy8DRxbjcRpbO30vOCo9D+TK_dDX_oiocZSOtnGAR2jAOFw@mail.gmail.com>
 <506C7B37.3080804@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>,
	Git List <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:58:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtN4-0001DP-H1
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756748Ab2JDBef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 21:34:35 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:63636 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756276Ab2JDBee (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 21:34:34 -0400
Received: by ieak13 with SMTP id k13so18745009iea.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 18:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Z/QslT9y4oUDsXajkSfInIMhZnrQjCXEuIkAm3vlsxU=;
        b=wnHr7CKw1ocZe2okS7Af0gtTS82YKrLENP+A/mNz/4xbBoDPWYEEK+gSYwIS9x6BHw
         DqNOXYNd5EIuqDv6BtQRz+wnlAfwQu7tG5ym10DR8R5rFtD0QeIRtraVvWtdB2+6HsMm
         r22L+bpMCgykApn9Mj1labofw+i09KrSnkz5Rm/p7P9QpvdUp7ObyPw4GbIQtnGqwUbc
         ZQzmni8/dSzkv275s3oh51vBfC5rTYIMxqYlSyfe5bqgR4Si8krK80ygiUNe1kAshlzN
         ljxa4Bd1bQ1TcRh3yHeCVMkyfsaELJqazHjXSfLXjJ1EfkeeGJmV02uOxGt9HDeFtPTu
         pSag==
Received: by 10.50.158.194 with SMTP id ww2mr14095557igb.40.1349314473628;
 Wed, 03 Oct 2012 18:34:33 -0700 (PDT)
Received: by 10.64.23.197 with HTTP; Wed, 3 Oct 2012 18:34:02 -0700 (PDT)
In-Reply-To: <506C7B37.3080804@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206945>

On Thu, Oct 4, 2012 at 12:51 AM, Joshua Jensen
<jjensen@workspacewhiz.com> wrote:
> FWIW, I would like to see this in .gitattributes as well.  I have a version
> of .gitattributes that supports recursive wildcards that I use for
> specifying filters.

.gitattributes also learns about "**" in nd/wildmatch topic.
-- 
Duy
