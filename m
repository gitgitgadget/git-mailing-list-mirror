From: =?UTF-8?B?55m944GE54aK?= <ShiroiKuma@ShiroiKuma.org>
Subject: Re: tar-tree.c dereferencing pointer to incomplete type
Date: Sat, 19 Jan 2013 17:26:59 +0300
Message-ID: <CAPy7p-7V6y4hfLrYYi_3zGkzGTw2BeF5wh3zPYzumrp+Pbqr+Q@mail.gmail.com>
References: <CAPy7p-45-E-vWcjBTXSLpjoQLic54JdAoKqB3jz4RA6GzAkw8w@mail.gmail.com>
	<CACsJy8DfOYRmF6FqTLCAYgXGpECX-VhpXGK5CfcmVvKXQ+DpuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 15:27:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwZOF-0000z2-6R
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 15:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198Ab3ASO1B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2013 09:27:01 -0500
Received: from mail-qa0-f50.google.com ([209.85.216.50]:62391 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862Ab3ASO1A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2013 09:27:00 -0500
Received: by mail-qa0-f50.google.com with SMTP id cr7so3705685qab.2
        for <git@vger.kernel.org>; Sat, 19 Jan 2013 06:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=8UUlIjPXoBi+briiEtx6QUVIZafL1aVyltt8qQBPmPg=;
        b=a/vhFke5egj6z1FMbgBrgxnxZ3+5+5AVyhQmj1L3YRd2O2hd+I1TvGZiK1E4TPcnUc
         i+0T5IH5H4FB+KhnU4voOKFPNqXMzkchaIq44r94HIE9mPSkBU2jidMi6kzQNW6W6cn2
         +5MrtDjt9m6AEcRw5nYWVCjnSZ22OD4BuuSpIR//l1hz+UvVKY9FHN5G7rx60j9CgKZG
         P9qxVua2pqIx6liptdPZYv9NycpSmCxSzME70gnW2zjISkcq7d13vSZ0JN+qcqcgZNjr
         VqNmebYaGgH7vb3PNItDb1hNc/1guBLCQ9XmqIMSL8yVoaArlOxRCcA6rYtqy0I+jMxq
         3SmA==
X-Received: by 10.49.130.167 with SMTP id of7mr15185334qeb.22.1358605619903;
 Sat, 19 Jan 2013 06:26:59 -0800 (PST)
Received: by 10.229.130.163 with HTTP; Sat, 19 Jan 2013 06:26:59 -0800 (PST)
In-Reply-To: <CACsJy8DfOYRmF6FqTLCAYgXGpECX-VhpXGK5CfcmVvKXQ+DpuA@mail.gmail.com>
X-Google-Sender-Auth: b63YcY9gpIK7nRa6-4-SSV0A2BE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213979>

On Sat, Jan 19, 2013 at 5:37 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> There is another tar.h somewhere in your system? Stopping the
> compilation after proprocessing should show if it includes the correc=
t
> tar.h.

Thank you, this must've been it, as it was finding tar.h from glibc.

Moved it and compiles fine. In fact I moved it back now, so it should
be finding it again and it still builds fine, no trace of the prior
error. I'm dumbfounded! But at least it compiles...
--=20
=E7=99=BD=E3=81=84=E7=86=8A
