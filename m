From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC v2 1/6] Add infrastructure for translating Git with gettext
Date: Tue, 01 Jun 2010 10:01:34 -0700 (PDT)
Message-ID: <m3eigqr8hf.fsf@localhost.localdomain>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>
	<1275252857-21593-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff Epler <jepler@unpythonic.net>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 19:02:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJUqx-00050f-4X
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 19:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757032Ab0FARBm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 13:01:42 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32849 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756725Ab0FARBi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 13:01:38 -0400
Received: by fxm8 with SMTP id 8so1156585fxm.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 10:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=u9j4qC7FpFevLyWhij3uZsl3LXl7FLfUHz8JieknsvI=;
        b=Y/d4rw/4aGI4i1GXl34S992vdFqYiuGmx4/3k4mbv82mOb+NNYkv6FUBEK+KDrCK4l
         pLMXvhPg7RA72VGELFWSccWZsHTKgabsguQq3J5eJGSI/7O9X6eUQfqBc1Tsoe3V3FCt
         K8qHyHsMdqZU98UCPOiFExMNs0lwp5/Nk0UQg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=pnJQO9J6YXfZHX+sxpgKHX9EbU7o2yjTPDR/AzX/qdgpXe2mn5JKAcWSfaHMWGYmJt
         SNsjT4rWNcFdRzBhJjDVhQVJqYj6Q++CdkuMzuzlWZ9kj0Qz//u641mCHUyY/oItq/Pj
         v1CdD+IKIEgwGg0VFFUTraP11iuYEC5mpfxIQ=
Received: by 10.204.81.150 with SMTP id x22mr843843bkk.101.1275411695253;
        Tue, 01 Jun 2010 10:01:35 -0700 (PDT)
Received: from localhost.localdomain (abvg224.neoplus.adsl.tpnet.pl [83.8.204.224])
        by mx.google.com with ESMTPS id v2sm3933567bkz.13.2010.06.01.10.01.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 10:01:34 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o51H3O52001722;
	Tue, 1 Jun 2010 19:03:29 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o51H38VK001718;
	Tue, 1 Jun 2010 19:03:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1275252857-21593-2-git-send-email-avarab@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148139>

=C6var Arnfj=F6r=F0 Bjarmason  <avarab@gmail.com> writes:

> From: Jeff Epler <jepler@unpythonic.net>
>=20
> Change the build process to use GNU's libintl if it's available. If
> not we define our own skeleton replacement functions which degrade
> gracefully to English.

Very nice.

>=20
> Signed-off-by: Jeff Epler <jepler@unpythonic.net>
> Signed-off-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
> ---
>  Makefile    |   26 ++++++++++++
>  gettext.c   |   17 ++++++++
>  gettext.h   |   15 +++++++
>  git.c       |    3 +
>  wt-status.c |  129 ++++++++++++++++++++++++++++++-------------------=
----------
>  5 files changed, 126 insertions(+), 64 deletions(-)
>  create mode 100644 gettext.c
>  create mode 100644 gettext.h

Could you also provide change to configure.ac, so that ./configure
would detect if we have gettext installed or not?  Thanks in advance.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
