From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: A flaw in dep generation with gcc -MMD?
Date: Fri, 18 Nov 2011 10:56:11 +0700
Message-ID: <CACsJy8A44PFtYrm8NQU+48sVkOe8mjJyO9opO5-TwRtAd-TKsQ@mail.gmail.com>
References: <CACsJy8BZMDyf4MCiKxPJ5Z+XS+C-MC82SpMFyWgiXmb9xCnScw@mail.gmail.com>
 <20111118034142.GA25228@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 04:56:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRFZI-0008F7-CD
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 04:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756149Ab1KRD4o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 22:56:44 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62430 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756106Ab1KRD4n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2011 22:56:43 -0500
Received: by bke11 with SMTP id 11so2916607bke.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 19:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=DgT8uFBho4flNg1u3dfKcfNd606NwPIpsLeby1OW4PQ=;
        b=B9uzEj6qfBxqVzH7hsBZQHRlu49U8k07aEhOyoXsruP+bgtICeOS6YtNZcm+Iz33hl
         MvwgbAUqY8GTn1FIdFRtkWxqaqJM7XfXcZQ/0qqotQNyg3AbDJnt62xXPZgXByLCsQn8
         k/iB5YotlwZaj6Gfor4qjvis7xWpXOUXq403E=
Received: by 10.204.9.209 with SMTP id m17mr1297947bkm.101.1321588602133; Thu,
 17 Nov 2011 19:56:42 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Thu, 17 Nov 2011 19:56:11 -0800 (PST)
In-Reply-To: <20111118034142.GA25228@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185628>

On Fri, Nov 18, 2011 at 10:41 AM, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> Nguyen Thai Ngoc Duy wrote:
>
>> My builtin/.depend/add.o.d says
>>
>> add.o: .... cache.h ...
>
> Interesting. =C2=A0What compiler do you use?

$ gcc --version
gcc (Gentoo 4.4.4-r2 p1.2, pie-0.4.5) 4.4.4

> =C2=A0$ head -1 builtin/.depend/add.o.d
> =C2=A0builtin/add.o: builtin/add.c cache.h git-compat-util.h compat/b=
swap.h \
> =C2=A0$ gcc --version | head -1
> =C2=A0gcc (Debian 4.6.2-4) 4.6.2

Hmm.. I guess it's my compiler's fault then. Next question, how can I
disable this feature?
--=20
Duy
