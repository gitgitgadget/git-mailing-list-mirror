From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Temporary directories getting errantly added into trees
Date: Fri, 23 Nov 2007 15:44:14 +0100
Message-ID: <e5bfff550711230644o3dd069b7r8346b95e79ff5c@mail.gmail.com>
References: <4744FCD9.7020102@vilain.net>
	 <Pine.LNX.4.64.0711221052280.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Sam Vilain" <sam@vilain.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 23 15:44:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvZlh-0004qe-R7
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 15:44:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102AbXKWOoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 09:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756062AbXKWOoQ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 09:44:16 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:53158 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756029AbXKWOoP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 09:44:15 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2658384rvb
        for <git@vger.kernel.org>; Fri, 23 Nov 2007 06:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=+jtALj1LXYFNAdToZirp5dLO5xxaYnEwbVQTfb5Oafw=;
        b=ha9KQyOMvlpWVzyFZWIO2w+BmzqIhwxSyY/tvi4VxqBG0shTA0dnNvXFM0BXfPfdANmymUqeu8EaNpyFhOhBToLFMEbXTLwnWuET52GE2lfG1zhf+uNN5dT9Tkrfev4nhMjea2heaNLf2rRqd3DPiMRNzJobl3DVWMV9xHC/W1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=te0C9ILv2Ny5IRksIonznp7YNlk9tzbNK9QGSyCenymBeR+adIOz3koCFSJIc07RLDtY82ATt1JKoWrUMvnR5MC60AFf22mOIg/9ood6dUD6AROKJQQ+E2VMipeVK3YehnTX/nGgcorv9khfjt120vT/B9yksfsJFadNhxHH7MU=
Received: by 10.141.116.16 with SMTP id t16mr3970407rvm.1195829054574;
        Fri, 23 Nov 2007 06:44:14 -0800 (PST)
Received: by 10.140.185.19 with HTTP; Fri, 23 Nov 2007 06:44:14 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711221052280.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65901>

On Nov 22, 2007 11:55 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> But I don't know about QGit, StGit, etc...
>

QGit does not rely on .dotest or any other temporary file produced by git

Interface with git is only through git commands.

Thanks
Marco
