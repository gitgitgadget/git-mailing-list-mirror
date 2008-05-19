From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: bare --init Vs --init bare
Date: Mon, 19 May 2008 21:32:21 +0200
Message-ID: <8aa486160805191232m76bbc7detdcd2d459c8e572cd@mail.gmail.com>
References: <20080519175313.GA17305@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Luciano Rocha" <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Mon May 19 21:33:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyB6t-00045s-Jk
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 21:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758093AbYESTcf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 May 2008 15:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757862AbYESTcf
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 15:32:35 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:16022 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757533AbYESTce convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 May 2008 15:32:34 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1190201ywe.1
        for <git@vger.kernel.org>; Mon, 19 May 2008 12:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=QfH5ZaD1cJhcyIcFSrYQaX4Rsjkf9ENhC+ihlLAI4CM=;
        b=TaRd1z9PKqk9UrZzAUJEpK22/eJHEtHKND8b20+KqfyLNZu3VzI+8vpQId5j9upt84ZCci0p3hMkuwOBRUHTS+PdJf/YdLTozuaZNf4Yu6in0vNN8t/tT9/QMbRhGwO3Go8TWnqeTsEk00v+ybY0govvBWFgGwwb4gfQnkzmJQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AxQhRpuKY1GzbKMMXzP3yeSfzp+Oo+asU77zTBX3fJAA1njeEZhp2NQehiN/FAW35t4FGuyRrXS3RbloCj52mwcdwccO3Mnp34/5PN8DE2Tmk81blggMqj7LPQvzRYfDtt53NvrSZqy94Pn0OgjHIlv3DBKB3p1wdfCjHEKC94g=
Received: by 10.150.84.41 with SMTP id h41mr6732413ybb.220.1211225541881;
        Mon, 19 May 2008 12:32:21 -0700 (PDT)
Received: by 10.150.152.19 with HTTP; Mon, 19 May 2008 12:32:21 -0700 (PDT)
In-Reply-To: <20080519175313.GA17305@bit.office.eurotux.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82442>

On Mon, May 19, 2008 at 7:53 PM, Luciano Rocha <luciano@eurotux.com> wr=
ote:
>
> Hello,
>

> This is odd:
> $ git init --bare
> usage: git-init [-q | --quiet] [--template=3D<template-directory>] [-=
-shared]
> $ git --bare init
> Initialized empty Git repository in /tmp/1/

The first is a flag to the init subcommand (man git-init), and the
other is a flag to git (man git).

See also:

http://www.google.com/search?q=3D%22git+init+--bare%22+%22git+--bare+in=
it%22

or equivalent

http://kerneltrap.org/mailarchive/git/2007/10/15/344050
"should git command and git-command be equivalent?"

Santi

>
> My git version:
> $ git --version
> git version 1.5.5.1.318.gc99b
>
> (Has two patches on top of origin's
> 377d9c409ffe0f0d994b929aeb94716139207b9d, setting default prefix in
> Makefile.)
>
> Regards,
> Luciano Rocha
>
> --
> Luciano Rocha <luciano@eurotux.com>
> Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>
>
