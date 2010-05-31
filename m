From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Migrate from svn to git
Date: Mon, 31 May 2010 07:01:44 -0500
Message-ID: <AANLkTinKsGPo0-ETmVOSH6fY64GLLwVm2dNBGyjAvrin@mail.gmail.com>
References: <4BFD3AAF.4080403@fechner.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Matthias Fechner <idefix@fechner.net>
X-From: git-owner@vger.kernel.org Mon May 31 14:02:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJ3hI-0001Cc-MJ
	for gcvg-git-2@lo.gmane.org; Mon, 31 May 2010 14:02:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753799Ab0EaMCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 May 2010 08:02:19 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57721 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447Ab0EaMCS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 May 2010 08:02:18 -0400
Received: by fxm10 with SMTP id 10so2384592fxm.19
        for <git@vger.kernel.org>; Mon, 31 May 2010 05:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=VUz4xcABvHNGYWWz7M3BkOFvdaGXm7SKYEnHn4C9rgE=;
        b=NaggF+1hywUcEm+bB0OeVm8jtKROI9auEMasRFCcfzBd19kzptUk40HcBqSPPsD2fc
         ltqPTsOpSZlkkv9g+FayEJP+7CFegqElCx6QoyPqLhJAPq+OMHx/W4NV0uROLBe1bw5J
         8gXZ14vztjAAZI+Vqs3Ds71fB77MnvyOlD+GY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=BKYMsQIrBhrSASckh0DrwCpr7StQ/NIX2ZnqlQI6LGe0S9PDFxENSLSc5NHjYFBzzX
         M0x2YXg+9eYCAhwyvjlGiSluE7XOLaKiNk33dBMYX2ML7BoRjmA5qDN7YBMD7TrwPST6
         vL2uIjaVL1VF/ZF/tbra0dQv4f5u0n/RSezAg=
Received: by 10.239.188.65 with SMTP id o1mr363306hbh.83.1275307334546; Mon, 
	31 May 2010 05:02:14 -0700 (PDT)
Received: by 10.239.189.143 with HTTP; Mon, 31 May 2010 05:01:44 -0700 (PDT)
In-Reply-To: <4BFD3AAF.4080403@fechner.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148038>

On Wed, May 26, 2010 at 10:13, Matthias Fechner <idefix@fechner.net> wrote:
> The second question is, I someone commits
> some files with svn an email is sent to a
> svn-commit mailinglist so changes can easily
> be discussed.

Shouldn't the discussion happen before the commit?

> The current mail is sent in html format with
> a colored diff, so it is easier to read.

I would rather receive the raw diff and let my own preferred tools
display the information in way that I personally like.

Keep in mind that `git diff' is capable of displaying the diff with color.

Michael Witten
