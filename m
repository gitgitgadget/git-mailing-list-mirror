From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/65] i18n: archive: mark parseopt strings for
 translation
Date: Tue, 29 May 2012 14:08:56 -0700
Message-ID: <7vfwai3dav.fsf@alter.siamese.dyndns.org>
References: <1336314232-21002-3-git-send-email-pclouds@gmail.com>
 <1338203657-26486-1-git-send-email-pclouds@gmail.com>
 <7vr4u23f0i.fsf@alter.siamese.dyndns.org> <20120529203759.GC22151@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 29 23:09:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZTf8-0005PZ-Ss
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 23:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337Ab2E2VJA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 May 2012 17:09:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44361 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754769Ab2E2VI7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 May 2012 17:08:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4E3C84C3;
	Tue, 29 May 2012 17:08:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=SILCHat0FoGW
	O2xcrpHPWuMwHCI=; b=beu4jfxSX4OKFi564VQ82FDhYEixLR7Iv47+ir9G+Nc/
	nzgv1G4ZkOJJ474NZH+0QqDks/B+KlMLcscf3ezbaFS1fq6naLnwiw4loAKssALh
	/tw2wOwP/d4AEbHRv7IUfexHjpchp0EL0b9j8dQVuXDdnOIEwTYHLljN6mJuazo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xf/NeB
	3Btwc3o5Rw123Omo7Oum7fxYoRarXbPRnOM/ncbgdf9cqrnf497p5UR6XGuPfB8D
	oNE5Q4b94X/WsSwVShV3JoWzQPLpQkiq/gvbCmr9senJYsU9VTYvpTM733pL0Rt9
	jP2r66YR375uD5OwRf9TqEkD0ss0ZzjUyXW/g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9BEC884C1;
	Tue, 29 May 2012 17:08:58 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 309E784BF; Tue, 29 May 2012
 17:08:58 -0400 (EDT)
In-Reply-To: <20120529203759.GC22151@burratino> (Jonathan Nieder's message of
 "Tue, 29 May 2012 15:37:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 81B3F890-A9D2-11E1-ACE6-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198762>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>
>>> --- a/archive.c
>>> +++ b/archive.c
>>> @@ -7,10 +7,10 @@
>>>  #include "unpack-trees.h"
>>> =20
>>>  static char const * const archive_usage[] =3D {
>>> -	"git archive [options] <tree-ish> [<path>...]",
>>> -	"git archive --list",
>>> -	"git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> =
[<path>...]",
>>> -	"git archive --remote <repo> [--exec <cmd>] --list",
>>> +	N_("git archive [options] <tree-ish> [<path>...]"),
>>> +	N_("git archive --list"),
>>> +	N_("git archive --remote <repo> [--exec <cmd>] [options] <tree-is=
h> [<path>...]"),
>>> +	N_("git archive --remote <repo> [--exec <cmd>] --list"),
>>>  	NULL
>>>  };
>>
>> I can understand the "help" text member of OPT_BLAH() construct, but
>> do we really want to translate the above?
>
> <repo>, <cmd>, [options], <tree-ish>, and <path> may be spelled
> differently in other languages.

OK, fair enough.
