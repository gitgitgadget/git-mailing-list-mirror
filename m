From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git-svn does not seems to work with crlf convertion enabled.
Date: Wed, 23 Jul 2008 11:49:04 -0400
Message-ID: <32541b130807230849t42b491b9jf1d6f31bcdd50dac@mail.gmail.com>
References: <200807231544.23472.litvinov2004@gmail.com>
	 <alpine.DEB.1.00.0807231117290.2830@eeepc-johanness>
	 <200807231852.10206.litvinov2004@gmail.com>
	 <alpine.DEB.1.00.0807231356540.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Alexander Litvinov" <litvinov2004@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 17:50:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLgbP-0003O4-Jv
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 17:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbYGWPtH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 11:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbYGWPtG
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 11:49:06 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:19268 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbYGWPtF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 11:49:05 -0400
Received: by yx-out-2324.google.com with SMTP id 8so427548yxm.1
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 08:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=NFKN+rlRNzNMR/3ouAGs9TJ84pbLCqPxmURaendWdAk=;
        b=m2IYmZJZ/eVAcpduuuJp/ZSGJdthrE+X5gsz7E52DLJ2SuRZG78tUG/2ZD8WDd0sW8
         nMMj/f8bGy83Mq/pnAdBFDyMBV68hX8oYJkxf76gsrb5CBElMeq5cXAq9peOiqrwEp3H
         4SpnORZQJSN38Zs4PB9HwyNefCFsAR4/JU5yU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=j2Jyb8ghg44qUePc0CHURk+gMu8MjMmw9szkDjvn7datsjJwGz+Zutz29mQmBon6zJ
         IoAlzKyLLfjE+eFI0wbtiiy3eY3lKd5FJECLkxuDJb8MTULLK4/ndLupNDL6Q5UYtbvf
         R71b4QgiSkN+nIwQgMUJPgWYP50d0MsN7CpAw=
Received: by 10.151.145.11 with SMTP id x11mr311350ybn.182.1216828144900;
        Wed, 23 Jul 2008 08:49:04 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Wed, 23 Jul 2008 08:49:04 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807231356540.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89689>

On 7/23/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  On Wed, 23 Jul 2008, Alexander Litvinov wrote:
>  > > On Wed, 23 Jul 2008, Alexander Litvinov wrote:
>  > > > In short: I can't clone svn repo into git when crlf convertion is
>  > > > activated.
>  > >
>  > > This is a known issue, but since nobody with that itch seems to care
>  > > enough to fix it, I doubt it will ever be fixed.
>  >
>  > That is a bad news for me. Anyway I will spend some time at holidays
>  > during digging this bug.
>
> Note that you will have to do your digging using msysGit (i.e. the
>  developer's pack, not the installer for plain Git), since git-svn will be
>  removed from the next official "Windows Git" release, due to lack of
>  fixers.

Presumably cygwin git will work too, right?

Does this known issue apply only to msysGit, or both msys and Cygwin,
or all versions?  ie. could it be debugged on Linux?

Thanks,

Avery
