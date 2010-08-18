From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 1/6] Add string comparison functions that respect the
 ignore_case variable.
Date: Wed, 18 Aug 2010 18:58:00 +0000
Message-ID: <AANLkTimWtdobYk-a8zz1dLS6xPMhOBX-y4v6jxrH-cQK@mail.gmail.com>
References: <cover.1281985411.git.j6t@kdbg.org>
	<4C6C01A9.4080306@workspacewhiz.com>
	<AANLkTinwQqwjmeNfiUE6LiZtbBhEEFyisZXUgF9_b+2Q@mail.gmail.com>
	<201008182032.40375.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Aug 18 20:58:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olnpw-00005G-Fb
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 20:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703Ab0HRS6D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Aug 2010 14:58:03 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40957 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617Ab0HRS6C convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Aug 2010 14:58:02 -0400
Received: by fxm13 with SMTP id 13so527952fxm.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 11:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fAF4vmicaJnxG/sx7tO2GB6Y9FIElodoI8fRwbffTEI=;
        b=LXFia7Dy9Lb6e2o7IZK9TiH4fQ1hmBrTLLz2EtVye/hoOtod/31yUCJGOEEnwVPpZ+
         s8nfqtX9B4i6Y0YvEvVTBbMTcK7agyfJ4gsBr4xBBJBrOTRE+dNZHbhsmh6rREoLoQm1
         e6Jc/iYmaW7jXNFY7Le9sZex1FN0zTSs85EjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=X8uUK8n+XNA4+ghe+650MkerEEyPx76r9MDHSvZvvQNP2Y35qYqGbZtuKmQw6hDL/I
         MaWLEYUjMQfThr+5lcxBQW7ALxL1HkeilYozQvEt6cxXkXmCJwXpFBjkD0XkY7Rh6Ns2
         n1ZV+Nem+fxx2f98hsT2IxFjEOYzzdrZ0shEE=
Received: by 10.223.117.20 with SMTP id o20mr8278106faq.55.1282157880556; Wed,
 18 Aug 2010 11:58:00 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Wed, 18 Aug 2010 11:58:00 -0700 (PDT)
In-Reply-To: <201008182032.40375.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153875>

On Wed, Aug 18, 2010 at 18:32, Johannes Sixt <j6t@kdbg.org> wrote:
> On Mittwoch, 18. August 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
wrote:
>> According to some further research at least FreeBSD and NetBSD have
>> copied this GNU extension. You may find their versions easier to
>> integrate.
>
> We already have a GNU fnmatch in compat/fnmatch.

I didn't spot that. But until now it's only been used for Windows,
there isn't a NO_* flag you can set to compile it in.
