From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v2 02/21] path.c: rename vsnpath() to git_vsnpath()
Date: Sun, 15 Dec 2013 21:13:02 +0000
Message-ID: <52AE1B5E.6020506@ramsay1.demon.co.uk>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com> <1387018507-21999-1-git-send-email-pclouds@gmail.com> <1387018507-21999-3-git-send-email-pclouds@gmail.com> <52ACBE2B.3040909@ramsay1.demon.co.uk> <CACsJy8BdLt8ZUU2z4LAgTcfXUjruFaOFsvrv6dSziZVizAopGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 15 22:13:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsIzy-00045s-GM
	for gcvg-git-2@plane.gmane.org; Sun, 15 Dec 2013 22:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865Ab3LOVNI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Dec 2013 16:13:08 -0500
Received: from mdfmta010.mxout.tch.inty.net ([91.221.169.51]:35007 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750831Ab3LOVNH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Dec 2013 16:13:07 -0500
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id A6B2C400CB2;
	Sun, 15 Dec 2013 21:13:04 +0000 (GMT)
Received: from mdfmta010.tch.inty.net (unknown [127.0.0.1])
	by mdfmta010.tch.inty.net (Postfix) with ESMTP id 6F094400CB1;
	Sun, 15 Dec 2013 21:13:04 +0000 (GMT)
Received: from [192.168.254.18] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta010.tch.inty.net (Postfix) with ESMTP;
	Sun, 15 Dec 2013 21:13:03 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <CACsJy8BdLt8ZUU2z4LAgTcfXUjruFaOFsvrv6dSziZVizAopGA@mail.gmail.com>
X-MDF-HostID: 19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239328>

On 15/12/13 02:25, Duy Nguyen wrote:
> On Sun, Dec 15, 2013 at 3:23 AM, Ramsay Jones
> <ramsay@ramsay1.demon.co.uk> wrote:
>> On 14/12/13 10:54, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>>> This is the underlying implementation of git_path(), git_pathdup() =
and
>>> git_snpath() which will prefix $GIT_DIR in the result string. Put g=
it_
>>> prefix in front of it to avoid the confusion that this is a generic
>>> path handling function.#
>>>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>> ---
>>>  path.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/path.c b/path.c
>>> index 4c1c144..06863b7 100644
>>> --- a/path.c
>>> +++ b/path.c
>>> @@ -50,7 +50,7 @@ char *mksnpath(char *buf, size_t n, const char *f=
mt, ...)
>>>       return cleanup_path(buf);
>>>  }
>>>
>>> -static char *vsnpath(char *buf, size_t n, const char *fmt, va_list=
 args)
>>> +static char *git_vsnpath(char *buf, size_t n, const char *fmt, va_=
list args)
>>
>> :-D I renamed this _from_ git_vsnpath() in commit 5b3b8fa2 ("path.c:=
 Remove the
>> 'git_' prefix from a file scope function", 04-09-2012), because ... =
well it's a
>> file scope function! (i.e. the git_ prefix implies greater than file=
 scope).
>> I'm not very good at naming things, so ...
>=20
> maybe gitdir_vsnpath() then to avoid the global scope prefix git_?

Sounds fine to me (but then so does vsnpath ;-) ).

ATB,
Ramsay Jones
