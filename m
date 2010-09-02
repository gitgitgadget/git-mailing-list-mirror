From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 05/13] gettextize: git-add refresh_index message
Date: Wed, 1 Sep 2010 23:21:55 -0500
Message-ID: <20100902042155.GE29713@burratino>
References: <1283373845-2022-1-git-send-email-avarab@gmail.com>
 <1283373845-2022-6-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 02 06:23:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or1LA-0001Lo-5D
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 06:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884Ab0IBEXu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 00:23:50 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:49680 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729Ab0IBEXu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 00:23:50 -0400
Received: by gxk23 with SMTP id 23so29290gxk.19
        for <git@vger.kernel.org>; Wed, 01 Sep 2010 21:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=oKXnznms438cwOmXlZAUyZoUch0BILO41Kvs/4emSiQ=;
        b=YvVTMuYMgK1IAe27wWXSjN7Qi8JP9w6vlTOg4zY5xgN3gMPfj4/Wn3RytHbGek7Fvt
         VmSqUc7DXnvmChAf7xz8WfrAh9XlSl4wReph+MUrZqnMdghTKfYujr70RxZ0C/uGFL4w
         FPi18to0t/tEJi2tfRVVjNgnfkbnSPHkXXWgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=P8OX/hIkovrMR6ezGOy160FRBa05peYhpfasX4LPDSS7qerMCRbw8aP20b2jhLPNiy
         ZrJqmpuEhN2XT00Lmw1sdSzmt2zGzVCCDZfSoJRQZ4UvXDy0Y9QKuNpfwbT5FF2wXI+f
         hxTteqXi84xBJLu+PVuQmb0ZL3e2hILCDWM1k=
Received: by 10.150.228.1 with SMTP id a1mr4788003ybh.441.1283401422421;
        Wed, 01 Sep 2010 21:23:42 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u42sm469337yba.12.2010.09.01.21.23.41
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Sep 2010 21:23:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283373845-2022-6-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155102>

On Wed, Sep 01, 2010 at 08:43:57PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---
>=20
> I can't find the command that makes this message appear

$ git reset HEAD^ 2>/dev/null
$ git add -v --refresh .
Unstaged changes after refreshing the index:
M	builtin/apply.c
M	builtin/bundle.c
M	builtin/config.c
M	builtin/grep.c
M	builtin/index-pack.c
M	builtin/ls-remote.c
M	builtin/merge-file.c
M	builtin/shortlog.c
M	builtin/var.c
M	cache.h
M	environment.c
M	git.c
M	setup.c
M	t/t1501-worktree.sh
M	t/t7006-pager.sh

Definitely porcelain.
