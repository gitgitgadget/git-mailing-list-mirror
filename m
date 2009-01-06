From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: BUG?? INSTALL MAKEFILE
Date: Tue, 6 Jan 2009 15:22:26 +0000
Message-ID: <e2b179460901060722t32a1cb0o15af1a2084cc72f9@mail.gmail.com>
References: <49635BF8.1010700@sadau-online.de> <vpqiqosa3fc.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Matthieu Moy" <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: "Lars Sadau" <lars@sadau-online.de>
X-From: git-owner@vger.kernel.org Tue Jan 06 16:23:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKDma-0000QV-1k
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 16:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbZAFPW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 10:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752188AbZAFPW2
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 10:22:28 -0500
Received: from qw-out-2122.google.com ([74.125.92.26]:34594 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbZAFPW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 10:22:27 -0500
Received: by qw-out-2122.google.com with SMTP id 3so6921620qwe.37
        for <git@vger.kernel.org>; Tue, 06 Jan 2009 07:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=YsLuRWAgF+v5hwmbwQHMdeCFcFnnJvj7Tq8obnQYl3c=;
        b=v8VtuxElfn+35NPx59AQOnAxUA/zVDPjqQkp6oIiCenBu0QzjrjiwEyZLVQ0xfkVoQ
         P1iusp9PPsGkKJDMDok/m5rXJrD4tY4b1B2arSP44eukYCbnrGglIP4QAUOoMyhahhb9
         5SSYfepCajhWkt6Hl5pTi7FpuZKEUn2uUonBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MHUkf2EYC4EsbDgcQ2aa0pV9KtTs59ZRpxDksBHjgWaKaNqDA+s329pckP3B/pBsi1
         yiNRNsxoF5q10JrHajRJ+oGaYvIPOiRexZ9O3l51U0ywQ5u+TIa/9fwZKSWH6ypx20kb
         p1oV3AGcC8yOFj1sda7Ijt5YX4x9Fz16HG3E4=
Received: by 10.214.11.17 with SMTP id 17mr18176516qak.77.1231255346100;
        Tue, 06 Jan 2009 07:22:26 -0800 (PST)
Received: by 10.214.26.15 with HTTP; Tue, 6 Jan 2009 07:22:26 -0800 (PST)
In-Reply-To: <vpqiqosa3fc.fsf@bauges.imag.fr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104693>

2009/1/6 Matthieu Moy <Matthieu.Moy@imag.fr>
> Lars Sadau <lars@sadau-online.de> writes:
> > i'm a brand-new git user. Just one minute ago I wanted to install git in
> > my home directory. The INSTALL file says type simply "make install", but
> > the makefile does a global installation.
>
> I was going to write:
>
>  Either run ./configure --prefix=$HOME/wherever/you/want or edit the
>  prefix variable in config.mak.
>
> but then realized that prefix is set to $(HOME) by default. Are you
> sure you didn't edit the Makefile or run any sort of ./configure
> before "make install" ?

Or run 'make' as root, as well as 'make install'?

Mike
