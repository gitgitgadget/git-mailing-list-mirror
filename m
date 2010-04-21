From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] test-lib: tests can have multiple prerequisites
Date: Wed, 21 Apr 2010 09:57:21 -0500
Message-ID: <20100421145721.GA8726@progeny.tock>
References: <20100421131255.GA2750@progeny.tock>
 <20100421133806.GA5595@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	Don Slutz <Don.Slutz@SierraAtlantic.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 21 16:58:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4bN3-0007yI-Qo
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 16:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498Ab0DUO5W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 10:57:22 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33203 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755494Ab0DUO5U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 10:57:20 -0400
Received: by pwj9 with SMTP id 9so5148747pwj.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 07:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=thRcH/4a1Yu5J/JWZ4FNd1VMui+Kz8mHUsNFbLEXGog=;
        b=MAFGa+LklfLJodrMKkcTXsIBhT3I/lj6+Oi6myjKuU5oEgBere8ncLviXcElXTHlPH
         dBhjRt2zdj45NAAqk21CyBp6uc5/5T2chxg0+PaGYNS5H9Rob6mP6u9oWsGDYlYLO+TE
         Xj3uJ5+DClWBgKOxgaJJ4O/jziT3VOUhIlKKA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=AgAplH43uDVjOwgUuxMdPKiBWkKhHwknmcDWuX9JrOVzLtBR9SGqr3ZcXY3dgSZIL1
         9ll9D47jPoZ9UtsjF7izyKeccVTwLHY7g1c5DlZXCNXdzXsU65xV64YPXnfpmX440Ijy
         y8LJqYBh9ZeWTtwVdlcWOUsyPpM6S0EAxrdCE=
Received: by 10.115.85.21 with SMTP id n21mr6529309wal.111.1271861839823;
        Wed, 21 Apr 2010 07:57:19 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 20sm2235280iwn.9.2010.04.21.07.57.18
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 21 Apr 2010 07:57:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100421133806.GA5595@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145437>

Jonathan Nieder wrote:

> Treat the prereq argument to test_expect_success and
> test_expect_failure as a space-separated list of prerequisites.
>=20
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Alas, I didn=E2=80=99t notice the thread with the almost identical pa=
tch [1]
> before writing this one.
>=20
> Since I am painting it, I prefer this way.  I find it intuitive and
> can=E2=80=99t really see where the fuss about using some other coding=
 style
> came from.

Whoops, forgot to link.  Maybe this would be a good entry point:

[1] http://thread.gmane.org/gmane.comp.version-control.git/116729/focus=
=3D118595

Sorry about that.
Jonathan
