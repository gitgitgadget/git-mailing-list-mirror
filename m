From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] Documentation: update-index: -z applies also to --index-info
Date: Thu, 7 Oct 2010 20:55:24 +0200
Message-ID: <AANLkTikiOmM0q=XoAJ0nOnr6SChj7PZZJfmXzaihGZMu@mail.gmail.com>
References: <d3f7e6795adeccbf7746547842d6b65732d568eb.1286457739.git.bert.wesarg@googlemail.com>
	<87wrptua21.fsf@gmail.com>
	<AANLkTimsJ+uG7KhiBMii8szFYmbXo5OjAkYgs99_Hjzr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 21:07:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3vnv-0004Gi-Ay
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 21:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541Ab0JGTGy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 15:06:54 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40597 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab0JGTGx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 15:06:53 -0400
Received: by iwn9 with SMTP id 9so183695iwn.19
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 12:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=uTIL67ihKjboTVuacmqQ0hgn2NTHGr/rqlg4XVZIfP4=;
        b=T1vUcBYzoaB181E6gB+qTXcffTuBzc1nTyEWI+46sfeXrghhM6U5CHg5lmjfLbNdZC
         hppuVrN0aQS3aCO2JjgjNw0HevHuqsQvOkiy5XFOHyceYrP1WaZXStjI58o8p9egipSl
         E/QpnioeIOdm7rXCFxsorz+/GDZiNpE8xcPUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=S9g/VucNp8aTN2sMwrbma3D26XaB6r+zc097mUmb3V8x0VrfWHkME+9Xfq19IWhetP
         3OLyYIQ4dFZtz1L+A1sN7STgw0Y8Fx4LaXZbx6xdDMrzlRVXoBScG7vK4bB+g5aE0zCu
         j4Ah7crkSegy7pJvdPM1/VSyFK+jW75XmnIJY=
Received: by 10.231.11.9 with SMTP id r9mr1193374ibr.47.1286477724832; Thu, 07
 Oct 2010 11:55:24 -0700 (PDT)
Received: by 10.231.147.80 with HTTP; Thu, 7 Oct 2010 11:55:24 -0700 (PDT)
In-Reply-To: <AANLkTimsJ+uG7KhiBMii8szFYmbXo5OjAkYgs99_Hjzr@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158434>

On Thu, Oct 7, 2010 at 20:52, Bert Wesarg <bert.wesarg@googlemail.com> =
wrote:
> On Thu, Oct 7, 2010 at 20:33, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <stepn=
em@gmail.com> wrote:
>>
>> Also the usage string in builtin/update-index.c should be updated to=
 the
>> same effect.
>>
>> There is actually at least one more problem with the current SYNOPSI=
S of
>> `update-index'. Obviously the `*' on the third line of the Asciidoc
>> source makes the whole `--cacheinfo' line disappear and the rest bol=
d
>> (cf. e.g. the result at
>> <http://www.kernel.org/pub/software/scm/git/docs/git-update-index.ht=
ml>).

ls-files too:
http://www.kernel.org/pub/software/scm/git/docs/git-ls-files.html

So it deserve more attention and its own patch.
