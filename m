From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCHv6 1/4] Read (but not write) from $XDG_CONFIG_HOME/git/config
 file
Date: Sun, 10 Jun 2012 22:27:26 +0200
Message-ID: <CABPQNSZzErckfN8JjiSExUyVa+uGRJT0aut3gvtbGObnhQeowA@mail.gmail.com>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <7vpq9aenl0.fsf@alter.siamese.dyndns.org> <20120608142601.Horde.Tq7UO3wdC4BP0e9ZGAy1EwA@webmail.minatec.grenoble-inp.fr>
 <7vvcj1dep7.fsf@alter.siamese.dyndns.org> <20120609125336.Horde.iUq0R3wdC4BP0yswpGlGBZA@webmail.minatec.grenoble-inp.fr>
 <7v4nqjbrdo.fsf@alter.siamese.dyndns.org> <20120610154850.Horde.gYrJO3wdC4BP1KXCOvLEiCA@webmail.minatec.grenoble-inp.fr>
 <CABPQNSYd0hCU8nrfKJJjR+T_jQn4WC6jEaSCJPjKsuPdumEdtw@mail.gmail.com> <20120610220239.Horde.UcGZQnwdC4BP1P1fPg1GEMA@webmail.minatec.grenoble-inp.fr>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu.Moy@grenoble-inp.fr,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
To: nguyenhu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Sun Jun 10 22:28:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdokB-00024X-Qv
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 22:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977Ab2FJU2I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Jun 2012 16:28:08 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51599 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586Ab2FJU2H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Jun 2012 16:28:07 -0400
Received: by pbbrp8 with SMTP id rp8so4696034pbb.19
        for <git@vger.kernel.org>; Sun, 10 Jun 2012 13:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=38HiQw763J62rrhp8XcuWUhfQPUmFiRbDCNkjoWu3U0=;
        b=CXrGWK7BxnKknCJTW3Za2lUCp+emhW5op0WuJ50/IxuPv5bgcKErFnpu+NjLlhrjS+
         v1hC8Rbt/4UOn6YSZQ662P3IBWB1g14Um7mqbb9ZVrvaBsfj59O6BIKhu0oPINJ9/nA7
         MkQAuINqW7pURqc977czMJuFTeYxWo5tCYoEBjm+pUrZpTizIY0AGfp9i9S0pqCCiAiD
         sTfqe6Sk3oWVfW9nC4GB4fOMrX4/8vHDc7ktlCtdEGaRWytAjGLPJiEu8qKgbVnXGodp
         pNEAEI4KsqzZiKoIWaYmjVuFIz7ZWWjc76i5dtZVkYRpspvVkgE13s5UEfnw3HO+AZXu
         JWgQ==
Received: by 10.68.217.166 with SMTP id oz6mr19022231pbc.136.1339360086552;
 Sun, 10 Jun 2012 13:28:06 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Sun, 10 Jun 2012 13:27:26 -0700 (PDT)
In-Reply-To: <20120610220239.Horde.UcGZQnwdC4BP1P1fPg1GEMA@webmail.minatec.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199623>

On Sun, Jun 10, 2012 at 10:02 PM,  <nguyenhu@minatec.inpg.fr> wrote:
>
> Erik Faye-Lund <kusmabite@gmail.com> a =E9crit=A0:
>
>>> char *mkpathdup(const char *fmt, ...)
>>> {
>>> =A0 =A0 =A0 =A0struct strbuf sb =3D STRBUF_INIT;
>>> =A0 =A0 =A0 =A0va_list args;
>>>
>>> =A0 =A0 =A0 =A0va_start(args, fmt);
>>> =A0 =A0 =A0 =A0strbuf_vaddf(&sb, fmt, args);
>>> =A0 =A0 =A0 =A0va_end(args);
>>>
>>> =A0 =A0 =A0 =A0return cleanup_path(strbuf_detach(&sb, NULL));
>>>
>>> }
>>
>>
>> The awkward thing about doing this, is that the memory allocated by
>> the strbuf cannot be reclaimed if you go with this. A pointer that h=
as
>> been adjusted (like cleanup_path can do) cannot be successfully fed =
to
>> free.
>
>
> Do you mean that the previous version is preferable in keeping clean-=
up-path
> function ?
>

No, that wasn't my intention. Since this is only used for a few config
files, I don't think leaking the memory is a big deal. But it's
probably worth putting a comment in the code about it, to warn
potential future users.
