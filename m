From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/6] Add string comparison functions that respect the
 ignore_case variable.
Date: Wed, 18 Aug 2010 12:52:39 +0000
Message-ID: <AANLkTi=mH9WPbJMKXRrgvdcuqZfHj1kC49M0jKUhaYeS@mail.gmail.com>
References: <cover.1281985411.git.j6t@kdbg.org>
	<513deaf9e8915473f7fc7f32401b17e383cb7d3a.1281985411.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Joshua Jensen <jjensen@workspacewhiz.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Aug 18 14:52:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oli8M-0008DR-9p
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 14:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635Ab0HRMwm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 08:52:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43501 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331Ab0HRMwk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 08:52:40 -0400
Received: by iwn7 with SMTP id 7so661405iwn.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 05:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wafXQ8gkMC98h7m0zfrBXOxVBChO3fjBrPT7st4nGlg=;
        b=BnGbG+yHY2glGyjfllSKL5M6glLzmHqFQy74rXMARRp0pFr7fkECUGCZjsvRuvmzAs
         Pu0rO1+biHSBd3p4UrqvbpYILlRUuYQrlm5zDYAUUJvdYi1ZdE5NASxuyRLhuziccVr6
         SJFxJJziAKHQwIklujHY/yuDI6i5h9DO6DRL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qDmz+lB5uq6kiJ9JlWWd4GCSqYaVeP+r6sW++NNp174ht6HcwqCTj4SIhSOaMJJYGA
         vYYcGl4iRH8M0ea7HAh3IrBOdya1MMYzzKb4cyCYQNj31s2Nawwsj65XEFrWP9GFVOkw
         XrKAANvRjetdxlVLWCin1RGeuP/jRiMwf50Jg=
Received: by 10.231.36.13 with SMTP id r13mr9164009ibd.75.1282135959915; Wed,
 18 Aug 2010 05:52:39 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Wed, 18 Aug 2010 05:52:39 -0700 (PDT)
In-Reply-To: <513deaf9e8915473f7fc7f32401b17e383cb7d3a.1281985411.git.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153833>

On Mon, Aug 16, 2010 at 19:38, Johannes Sixt <j6t@kdbg.org> wrote:

> + =C2=A0 =C2=A0 =C2=A0 return fnmatch(pattern, string, flags | (ignor=
e_case ? FNM_CASEFOLD : 0));

On Solaris 10:

dir.c: In function `fnmatch_icase':
dir.c:34: error: `FNM_CASEFOLD' undeclared (first use in this function)
dir.c:34: error: (Each undeclared identifier is reported only once
dir.c:34: error: for each function it appears in.)
