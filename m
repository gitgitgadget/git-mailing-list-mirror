From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Q: "git diff" using tag names
Date: Fri, 28 Oct 2011 06:21:51 -0700 (PDT)
Message-ID: <m3aa8l5k1y.fsf@localhost.localdomain>
References: <4EAABC15020000A100007D9D@gwsmtp1.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Fri Oct 28 15:22:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJmNj-0004Ew-3o
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 15:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755777Ab1J1NVy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Oct 2011 09:21:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64825 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755369Ab1J1NVx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2011 09:21:53 -0400
Received: by faan17 with SMTP id n17so3606460faa.19
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 06:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=0JzUDFa9cxwfHWTgQKEoB8GDkMKvvFzmGGVeCknuvAM=;
        b=VIH7CilFBJUzjegWi+QOWoKA8gYhuFU2IIZJUM73iqcb8s5IzlwRZy0bnsuTnt4LZi
         H/UgoV70GJwWsjcrqEBq0CN9mmwfMoffGTSeSorUNHXvpX2ojXIY9ZRXhhu4ln2XHyDT
         bRoxIHVouMmb6KpRDGoTnFjs6DzDNVAXNtr1g=
Received: by 10.223.15.10 with SMTP id i10mr6101079faa.17.1319808112466;
        Fri, 28 Oct 2011 06:21:52 -0700 (PDT)
Received: from localhost.localdomain (abvy192.neoplus.adsl.tpnet.pl. [83.8.222.192])
        by mx.google.com with ESMTPS id y17sm17430118faf.1.2011.10.28.06.21.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Oct 2011 06:21:51 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p9SDLI07032122;
	Fri, 28 Oct 2011 15:21:28 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p9SDKvZ0032118;
	Fri, 28 Oct 2011 15:20:57 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4EAABC15020000A100007D9D@gwsmtp1.uni-regensburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184406>

"Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de> writes:

> When using a somewhat older git (of SLES11 SP1 SDK),

Nb. you can check version of git with "git --version".

>                                                      I could not
> find a way to "git diff" between two tag names; I can only diff
> between two commit numbers. I can display a changeset using "git
> show", but that's not what I wanted.
>
> Is it possible to get the diff I want using older versions, and is
> such a feature implemented in the current version? If so, since
> when?

=46rom the very beginning in Git you can use tag name where you need
commit identifier; Git would use commit that tag points to (will
dereference or peel a tag).

That is not possible in some [censored] version control systems; I am
looking at you, Subversion!


So if you can do

  $ git show v0.9
  $ git show v1.0

you can also do

  $ git diff v0.9 v1.0

and

  $ git log v0.9..v1.0

--=20
Jakub Nar=EAbski
