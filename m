From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase -f --autosquash
Date: Mon, 14 May 2012 09:35:09 -0700
Message-ID: <7vipfyiuv6.fsf@alter.siamese.dyndns.org>
References: <D7BE2BACB49749DB9FC37D4ACCCD008B@gmail.com>
 <1336820755.3002.11.camel@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andy Kitchen <kitchen.andy@gmail.com>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon May 14 18:35:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STyEx-0002bM-Vs
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 18:35:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131Ab2ENQfN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 May 2012 12:35:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34185 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750992Ab2ENQfM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2012 12:35:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 10BAC9460;
	Mon, 14 May 2012 12:35:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mZKuofLc24ev
	FFbVs09JEzZ43ow=; b=fEvaf3WdN4JxwzKyENKDur5jILhj9jqXlCW2o2rY3Okj
	H/WMc4lr+ZU7572VnNQeHaqLDRryE5O34Ec78oytJt3DWqvWb+voOv7seNdqt6wj
	FwgisbhseLMI0otGiDHqKQeIoXBnqZlhm3rdfRDNaBTYurrmI4zpNm+DUf6iln8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aOBaUq
	l+I07vWk/ataI+0J2OAhrXZoerQQM08JIF9aGmcxgrh8v8W5fPZlASCVM6+0S7HU
	fO8WqktGGMTX/vwsjQ3c5oOIvmk9g7wCOiavWCZn2EhK4OtPDTLUBO+yyX14hdBX
	vPIReEYF5Hm7jk0+mD6QuTv3kRghfrCiXFbIE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07210945F;
	Mon, 14 May 2012 12:35:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 990AC945D; Mon, 14 May 2012
 12:35:10 -0400 (EDT)
In-Reply-To: <1336820755.3002.11.camel@centaur.lab.cmartin.tk> ("Carlos
 =?utf-8?Q?Mart=C3=ADn?= Nieto"'s message of "Sat, 12 May 2012 13:05:55
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C5E8DEF0-9DE2-11E1-ABF2-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197782>

Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:

>     EDITOR=3D: git rebase -i @{u}
>
> and maybe set an alias (I have a 'riu' alias for 'rebase -i @{u}').
>
> I'm not saying an extra option wouldn't be useful, but there's alread=
y
> ways of making git not spawn a text editor which works for all comman=
ds,
> and you can even make an alias that will do precisely that.

Given "EDITOR=3D: git commit args..." and "EDITOR=3D: git merge args...=
" are
equivalent to giving "--no-edit" option to these commands, I would imag=
ine
"git rebase opts... --no-editor args..." would not be such a stretch.
