From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 04/11] tests: introduce test_ln_s and test_ln_s_add
Date: Sat, 1 Jun 2013 22:40:12 +0530
Message-ID: <CALkWK0k3KG2657BJLOyGSaRF8teaigpRLwiq=-ppQWOCO7w0tA@mail.gmail.com>
References: <cover.1370076477.git.j6t@kdbg.org> <c7be5891891d1eeba540a5a24f07d58514345b2b.1370076477.git.j6t@kdbg.org>
 <CALkWK0nN2V3Cwi3n+DV7Bcme7jE=B+COFioqPFfHQgxGTWEtiA@mail.gmail.com> <51AA0DD9.9030704@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jun 01 19:11:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UipKi-0004uq-8j
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 19:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751568Ab3FARKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 13:10:54 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:37514 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856Ab3FARKx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 13:10:53 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so965277ieb.38
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 10:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xlEIaNu4REB7sn4ekdkPh7VyEwXHHf5VH7vMoJaCOIk=;
        b=DehR6tEskrwL427oHegs+Pi6E8AmiCpf/5lvL01s+63q8YsyHqoAZE3X3aNqN8mJ0O
         NQjtfILEQbvkdALJj5ey5Ktij3M7GAYXi4p3RIQdTaLIEEgPdN/IBnxKLU5G9OXrNv1/
         pfqBX/NfU1z4Hkm+Z9N0fY+stMH2yfuhDPJPgQmc/qbWRgTUdMCoI8u/2g9a06wQmpbf
         hodlTpwWu7/J2hpTX3DBWTNhM/FqNwWRXmU13NrYoh/ulTTLeIOYwMlBsl+IbA4f3BXG
         ssukJ/mDnGAkwbnRaAWIdyZ5mP6KMpSoA/Ff5DgSrYvJwvZDYug5zYWsTU6tE5jOwP/h
         8LIw==
X-Received: by 10.42.76.132 with SMTP id e4mr7192647ick.11.1370106652457; Sat,
 01 Jun 2013 10:10:52 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Sat, 1 Jun 2013 10:10:12 -0700 (PDT)
In-Reply-To: <51AA0DD9.9030704@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226140>

Johannes Sixt wrote:
> # - Use test_ln_s instead of "ln -s x y" when y has been added as a
> #   symbolic link entry earlier.

Ah, sorry I skipped over the comments.
