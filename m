From: =?UTF-8?B?55m944GE54aK?= <ShiroiKuma@ShiroiKuma.org>
Subject: Re: tar-tree.c dereferencing pointer to incomplete type
Date: Sat, 19 Jan 2013 17:37:41 +0300
Message-ID: <CAPy7p-5vZKzznSny97BZMWHxHPJupO3in7tvjyFOTxBYzw5D4Q@mail.gmail.com>
References: <CAPy7p-45-E-vWcjBTXSLpjoQLic54JdAoKqB3jz4RA6GzAkw8w@mail.gmail.com>
	<CACsJy8DfOYRmF6FqTLCAYgXGpECX-VhpXGK5CfcmVvKXQ+DpuA@mail.gmail.com>
	<CAPy7p-7V6y4hfLrYYi_3zGkzGTw2BeF5wh3zPYzumrp+Pbqr+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 19 15:38:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwZYe-00041N-Pn
	for gcvg-git-2@plane.gmane.org; Sat, 19 Jan 2013 15:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250Ab3ASOhm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2013 09:37:42 -0500
Received: from mail-qa0-f50.google.com ([209.85.216.50]:63159 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198Ab3ASOhl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jan 2013 09:37:41 -0500
Received: by mail-qa0-f50.google.com with SMTP id cr7so3709520qab.2
        for <git@vger.kernel.org>; Sat, 19 Jan 2013 06:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=o81Oc3Pq4fiWKcmQJSEdfJGG0XQJAgsA4B43VL/f57g=;
        b=Xy3eU/ddmYTxTjeLko0d/8OSXmabtGodGugfCFjVQfR7tBB+f9KGHvUfqplVNLntHW
         S3cDu/BvLkPwezOQkqH86mpCyt2xYxV4YzK7S9kzVJhc0ODOZlt8Jf0b+92Bt3ePoH8o
         Wumg8NGTE0Huzxj70AX+CiCl/mT+FVFJzay4OVu4it2v+Jfo8OQEQOy1EZE/TcBjDwWk
         zbcOozeQxvGGQCa2Ih9IxYxg/bASbjKGHxya2Tv1RIsYjdo+z/Xb51b4x6e8R5viii/2
         hDIYhCDeFSegmaz/cQOIaYrO2FHf8N52fZc903QsjaXsYaHOvlBRu+E70Iwxvqryp+Z8
         Zi1w==
X-Received: by 10.224.70.205 with SMTP id e13mr13332453qaj.77.1358606261047;
 Sat, 19 Jan 2013 06:37:41 -0800 (PST)
Received: by 10.229.130.163 with HTTP; Sat, 19 Jan 2013 06:37:41 -0800 (PST)
In-Reply-To: <CAPy7p-7V6y4hfLrYYi_3zGkzGTw2BeF5wh3zPYzumrp+Pbqr+Q@mail.gmail.com>
X-Google-Sender-Auth: WYTQ4UI8AiRdr6xeeCo-eQ0K8FM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213980>

On Sat, Jan 19, 2013 at 6:26 PM, =E7=99=BD=E3=81=84=E7=86=8A <ShiroiKum=
a@shiroikuma.org> wrote:
> Thank you, this must've been it, as it was finding tar.h from glibc.
>
> Moved it and compiles fine. In fact I moved it back now, so it should
> be finding it again and it still builds fine, no trace of the prior
> error. I'm dumbfounded! But at least it compiles...

OK, figured it out. It was indeed the wrong tar.h, the one that was
making it bomb was the kernel headers tar.h from the Android source.
That explains it quite well.

All's good now. Thank you :@)
--=20
=E7=99=BD=E3=81=84=E7=86=8A
