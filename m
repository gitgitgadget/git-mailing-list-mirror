From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: tar-tree.c dereferencing pointer to incomplete type
Date: Sat, 19 Jan 2013 20:37:04 +0700
Message-ID: <CACsJy8DfOYRmF6FqTLCAYgXGpECX-VhpXGK5CfcmVvKXQ+DpuA@mail.gmail.com>
References: <CAPy7p-45-E-vWcjBTXSLpjoQLic54JdAoKqB3jz4RA6GzAkw8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?55m944GE54aK?= <ShiroiKuma@shiroikuma.org>
X-From: git-owner@vger.kernel.org Sat Jan 19 14:38:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwYcO-0007Zd-BT
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 14:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265Ab3ASNhf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2013 08:37:35 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:35595 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157Ab3ASNhf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2013 08:37:35 -0500
Received: by mail-ob0-f179.google.com with SMTP id x4so4582049obh.38
        for <git@vger.kernel.org>; Sat, 19 Jan 2013 05:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=xWuV7Hord+odITuqIu13N5w7EbGmYD7+n+PGZ7ICqno=;
        b=u3d3jkgICOIaB52Cx3O8zrCWV1QX0W+sKajPwXM1BZJixwJQ3YmGZRl5bZD4/t/fjh
         ZFduWiOh9cAKNVXwAhTA55xfpFMXMqphAOCnwn58oCeuW9H9HkTGH/6cbHvyDxWHD0hE
         14Kli2DhIm/C817gmMMudtpcNDuvX5n28Vvv9F5xwsR/MNbTb9BfmMgbxLG89bsK0LWJ
         8KkzmFq5MQBhUXYS7zcAMruWFqExeYN8od19hK5gRmvictg2izjN8O2hX7PoHnf93ZmY
         D1M+vZWKKaHeW/SIRGcbQMeXtwPll8cfTvhumRajj27KR3gRdSk4YFwXz1RuF3mzZeKf
         3eKg==
X-Received: by 10.60.3.1 with SMTP id 1mr9500509oey.138.1358602654516; Sat, 19
 Jan 2013 05:37:34 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Sat, 19 Jan 2013 05:37:04 -0800 (PST)
In-Reply-To: <CAPy7p-45-E-vWcjBTXSLpjoQLic54JdAoKqB3jz4RA6GzAkw8w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213976>

On Sat, Jan 19, 2013 at 8:31 PM, =E7=99=BD=E3=81=84=E7=86=8A <ShiroiKum=
a@shiroikuma.org> wrote:
> Hello:
>
> I'm building v 1.8.1.1 on Android. The build chokes on the builtins
> phase on tar-tree.c with:
>
>     CC builtin/tar-tree.o
> builtin/tar-tree.c: In function 'cmd_get_tar_commit_id':
> builtin/tar-tree.c:93:12: error: dereferencing pointer to incomplete =
type
> make: *** [builtin/tar-tree.o] Error 1
>
> The line that's causing this in tar-tree.c is:
>
> if (header->typeflag[0] !=3D 'g')

There is another tar.h somewhere in your system? Stopping the
compilation after proprocessing should show if it includes the correct
tar.h.
--=20
Duy
