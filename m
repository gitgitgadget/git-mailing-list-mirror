From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] Documentation: reorganize documentation of URLs
 understood by git
Date: Tue, 6 Apr 2010 16:33:41 -0500
Message-ID: <20100406213341.GA8448@progeny.tock>
References: <f3271551003290759g154b149fl7877d9b83e1313e6@mail.gmail.com>
 <20100329191832.GA26842@progeny.tock>
 <f3271551003291224s7fb0d8d3sce75b7c893fabfa8@mail.gmail.com>
 <20100406060606.GA26629@progeny.tock>
 <7v6345jcfq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 23:33:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzGOa-0005yu-IE
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 23:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756973Ab0DFVdK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 17:33:10 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46881 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756918Ab0DFVdG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 17:33:06 -0400
Received: by vws13 with SMTP id 13so173777vws.19
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 14:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Elq+xv2ieiooy9/o+n82/YE7GebIryDEArnL05c71iE=;
        b=tO26KJTAlGDbcG9Z51eYyD8mIyBnbCfe3+gRtfX9NQs6ujVTpuUASFDzPAmSCmW/xo
         Bx7PuDme33NpzNm27eSnTD3jf5M7/txgGAla8ZSURt/KN9D9xlAFJFDCo8ZAaMcZgbd7
         aeWkmL2wU1Z+37X41OVn8BW3Rbtc0eUVNZ/GQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=GwjAy9FbDRztt+fGGbV+njrCChzoF33wPPYE1bYJ4Uew/PelPEEehDtx/QeWE+Wbnl
         Gdqg5DAPt6teeyeqqAocClW1N1qy8jn/2eeaQQxocR8CgQ3HVu3fcEJZ2ctUM7ztDfW8
         z8t2G89QZiLNtwOPdWUFSozx0uAzP68TAP7/k=
Received: by 10.220.62.134 with SMTP id x6mr1569952vch.48.1270589585908;
        Tue, 06 Apr 2010 14:33:05 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm1082721yxe.5.2010.04.06.14.33.03
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Apr 2010 14:33:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v6345jcfq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144173>

Junio C Hamano wrote:

> I am of two minds.  It is frustrating if "git clone" (or "git fetch",=
 or
> "git remote") page didn't list any examples an intelligent person (or=
 at
> least one who thinks he is intelligent enough) to mimic and instead
> referred him with "look there" indirections.

Makes sense.  So it should be self-contained for at least the common ca=
ses.
Something like:

GIT URLS

	One of the following notations can be used to name the remote reposito=
ry:

	=C2=B7   git://host.xz[:port]/path/to/repo.git/
	=C2=B7   git://host.xz[:port]/~user/path/to/repo.git/
	=C2=B7   [user@]host.xz:~user/path/to/repo.git/
	=C2=B7   [user@]host.xz:/path/to/repo.git/
	=C2=B7   [user@]host.xz:path/to/repo.git/
	=C2=B7   ssh://host.xz[:port]/path/to/repo.git/
	=C2=B7   ssh://host.xz[:port]/~user/path/to/repo.git/
	=C2=B7   /path/to/local/repo.git/
	=C2=B7   path/to/local/repo.git/
	=C2=B7   file:///path/to/repo.git/
	=C2=B7   svn::http://host.xz[:port]/path/to/repo/

	Schemas supported include git, ssh, file, rsync, and if HTTP support
	is installed, http, https, ftp, and ftps.

	Git can be taught to support additional schemas by installing a
	'git-remote-<schema>' helper to your $PATH.  See git-remote-helpers(7)
	if you want to write one.

	The url.*.insteadOf and url.*.pushInsteadOf configuration items
	affect URLs supplied to this command.  This can be useful if
	there are a large number of similarly-named remote repositories
	and you want to use a different format for them.  See gitconfig(5)
	for details on setting this up.

Unfortunately, that leaves out any explanation of which transport you w=
ould
want to use; in particular, it doesn=E2=80=99t say

 * Using local paths implies a request for "clone --local" unless the
   louder file:// syntax is used;

 * If you were thinking of using host.xz:port:/path/to/, use ssh://
   instead. [1]

 * The git protocol is very nice, but it does not support authenticatio=
n.
   If that is a problem for you, use ssh instead for pushing.

   The rsync protocol support is bitrotting.

   http and ftp can be used as =E2=80=9Csmart=E2=80=9D or =E2=80=9Cdumb=
=E2=80=9D protocols; the former
   requires that the server administrator install a CGI script to serve
   requests efficiently; the latter is all some hosting services
   provide, and it has some caveats like requiring update-server-info.

Not sure where this should go.

Thanks for the food for thought,
Jonathan

[1] Aside: Is there any reason for git and scp not to learn to support
the two-colon syntax?  I would think directories named 1087: are a rath=
er
rare beast, and they could still be accessed as "host.xz:./1087:/".
