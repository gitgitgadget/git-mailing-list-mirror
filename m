From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 0/8] gitweb: Highlight interesting parts of diff
Date: Sat, 11 Feb 2012 23:56:37 +0100
Message-ID: <20120211235637.5ae5e9f7@gmail.com>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
	<m31uq1te51.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 23:56:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwLs7-0006YD-00
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 23:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653Ab2BKW4m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 17:56:42 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:33068 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505Ab2BKW4m convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2012 17:56:42 -0500
Received: by eekc14 with SMTP id c14so1389225eek.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 14:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=rOQyTjjjppE7UXbacjOstIkPPBpX/iD3Q7pcghp7PtI=;
        b=A6nQag2ToiYoB5s9jxp75KhLR35Jsuf33CPZkAuw3WlvksPuZjWMaCfAK+FaeR9Ney
         8X8+KeyjFe/I8/jj8TfUuPnIqbfsxrwxniq5wciMRR8uv/XwBXehjpWxXECxMy/7NT4d
         YjtOBgyT4lvzeqYjEcP/JvVh8dj/YJsI6vLKo=
Received: by 10.14.94.200 with SMTP id n48mr3574923eef.48.1329001001072;
        Sat, 11 Feb 2012 14:56:41 -0800 (PST)
Received: from localhost (77-177-78-94.net.stream.pl. [94.78.177.77])
        by mx.google.com with ESMTPS id a58sm40964600eeb.8.2012.02.11.14.56.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 14:56:40 -0800 (PST)
In-Reply-To: <m31uq1te51.fsf@localhost.localdomain>
X-Mailer: Claws Mail 3.7.10 (GTK+ 2.24.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190537>

Jakub Narebski <jnareb@gmail.com> wrote:

> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>=20
>=20
> >   gitweb: Use print_diff_chunk() for both side-by-side and inline d=
iffs
> >   gitweb: Move HTML-formatting diff line back to process_diff_line(=
)
> >   gitweb: Push formatting diff lines to print_diff_chunk()
> >   gitweb: Format diff lines just before printing
>=20
> Those patshes are expected to not change gitweb output. =20

Yes.

> Did you check
> that gitweb after those changes handles incomplete line marker
> correctly?  print_sidebyside_diff_chunk() ealt with 'incomplete' clas=
s
> in slightly hacky way, assuming side-by-side output.
>=20

Yeah, I saw the 'for' loop at the beginning of
print_sidebyside_diff_chunk() but I didn't look at it very closely.
I'll make sure 'incomplete' lines are properly printed.
