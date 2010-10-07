From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation: update-index: -z applies also to
 --index-info
Date: Thu, 7 Oct 2010 14:15:48 -0500
Message-ID: <20101007191548.GA11955@burratino>
References: <d3f7e6795adeccbf7746547842d6b65732d568eb.1286457739.git.bert.wesarg@googlemail.com>
 <87wrptua21.fsf@gmail.com>
 <AANLkTimsJ+uG7KhiBMii8szFYmbXo5OjAkYgs99_Hjzr@mail.gmail.com>
 <AANLkTikiOmM0q=XoAJ0nOnr6SChj7PZZJfmXzaihGZMu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 21:19:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3vzk-0008Ao-3h
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 21:19:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754189Ab0JGTTG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 15:19:06 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49934 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142Ab0JGTTF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 15:19:05 -0400
Received: by wwj40 with SMTP id 40so262574wwj.1
        for <git@vger.kernel.org>; Thu, 07 Oct 2010 12:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=GDprno3Vjz9oWPDU4uV7l0/w8sOPXh1df304US9DEpg=;
        b=E3VEoTfgfI4XM4/+SJtCmfa280jYAtIOG0LktJaBIZPP3+J/OP8jCIq4N44XwPXXKM
         Shcy8FjBqlvc4gBy8htSWv1Bp20fhHG0BISn6wDsBqwvx0cnzjgZOusyo2YtRd4fQzr5
         oer/Qovbkyjtj9U2k923LGoHIGodid8whBYp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=iCjqSj+BTP8WA9FWti1EAoaj4osfEErbK00/2Wi6h4tceDQPSse8Rv5rxFqmYhd2G2
         YO+wlOZAOL/pMjjd3FYYnCkcGTWsz7ecOc6RIW2ghEQy8NTUU8vuO6hf6GfpumY2GOUB
         0GBeGVhP1nzuXmQ+UrtqoEJZtmb4WoqQbEnNg=
Received: by 10.216.71.206 with SMTP id r56mr2711307wed.29.1286479142516;
        Thu, 07 Oct 2010 12:19:02 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id p42sm1683132weq.36.2010.10.07.12.18.59
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 07 Oct 2010 12:19:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikiOmM0q=XoAJ0nOnr6SChj7PZZJfmXzaihGZMu@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158444>

Bert Wesarg wrote:
> On Thu, Oct 7, 2010 at 20:52, Bert Wesarg <bert.wesarg@googlemail.com=
> wrote:
>> On Thu, Oct 7, 2010 at 20:33, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec <step=
nem@gmail.com> wrote:

>>> There is actually at least one more problem with the current SYNOPS=
IS of
>>> `update-index'. Obviously the `*' on the third line of the Asciidoc
>>> source makes the whole `--cacheinfo' line disappear and the rest bo=
ld
>>> (cf. e.g. the result at
>>> <http://www.kernel.org/pub/software/scm/git/docs/git-update-index.h=
tml>).
>
> ls-files too:
> http://www.kernel.org/pub/software/scm/git/docs/git-ls-files.html

Hmph, this is from v1.7.3-rc0~15^2~9 (Documentation: remove backslashes
in manpage synopses, 2010-08-20).  And it still works for me locally
(for both manpage and HTML generation). :(

Anyway, the "..." fix sounds good to me (or {asterisk} if the stars are
still wanted).
