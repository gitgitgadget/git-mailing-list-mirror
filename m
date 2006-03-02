From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Thu, 2 Mar 2006 15:18:44 +0100
Message-ID: <81b0412b0603020618q3b205cdeuabc7e204044cca5b@mail.gmail.com>
References: <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com>
	 <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com>
	 <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com>
	 <43FD84EB.3040704@op5.se>
	 <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com>
	 <43FDB8CC.5000503@op5.se>
	 <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com>
	 <20060226195552.GA30735@trixie.casa.cgf.cx>
	 <Pine.LNX.4.64.0602261217080.22647@g5.osdl.org>
	 <20060226204027.GC30735@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 15:19:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEodl-0002Fa-Qq
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 15:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWCBOSq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 09:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWCBOSq
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 09:18:46 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:8117 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751349AbWCBOSp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Mar 2006 09:18:45 -0500
Received: by nproxy.gmail.com with SMTP id a27so282556nfc
        for <git@vger.kernel.org>; Thu, 02 Mar 2006 06:18:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pJb0HMcdByD4YZboTeK1ZUkb+z1E3ExjZn8tWUEjC5B7/IRYjmEmEsHqcdkCseZJFJNIxDvvb813NydKaGb4JefFojmUq6ZLNZfFx2P7VGUd2coSnkDVWKO0odj6rWNS+wdbcAkbpPais8JwMwod6V1S89ocH9usaBFsXdibHwQ=
Received: by 10.48.244.5 with SMTP id r5mr203803nfh;
        Thu, 02 Mar 2006 06:18:44 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 2 Mar 2006 06:18:44 -0800 (PST)
To: "Christopher Faylor" <me@cgf.cx>
In-Reply-To: <20060226204027.GC30735@trixie.casa.cgf.cx>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17073>

On 2/26/06, Christopher Faylor <me@cgf.cx> wrote:
> The cygwin/windows version of spawn is basically like an extended version
> of exec*():
>
> pid = spawnlp (P_NOWAIT, "/bin/ls", "ls", "-l", NULL);
>

By the way, is argv worked around?
AFAIK, windows has only one argument, returned by GetCommandLine?
