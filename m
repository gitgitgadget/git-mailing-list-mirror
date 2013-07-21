From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Fix generic typos in comments
Date: Sun, 21 Jul 2013 15:29:19 -0700
Message-ID: <7vy58zr1hc.fsf@alter.siamese.dyndns.org>
References: <20130720190707.GA30044@domone>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?T25kxZllaiBCw61sa2E=?= <neleai@seznam.cz>
X-From: git-owner@vger.kernel.org Mon Jul 22 00:29:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V128M-0004Zc-L0
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 00:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942Ab3GUW31 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Jul 2013 18:29:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751253Ab3GUW30 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jul 2013 18:29:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 062D332E5A;
	Sun, 21 Jul 2013 22:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tUV2YQS64fs1
	xF2teUKrOUvUupc=; b=M3XFDL9Fv8ARjQ/Me1VoYtXNp6I214bgxEyCB+jQbzxQ
	rPuX4ifodbjCFxXPMtsPPpdvT/EknSrOymF/44kbFali32SY8mmJ36tnQMaFoCZW
	JdbQ/ZUs9mTKgSYpTknb93TEob16qbFZBqRJ04+2KwCThZR9J3KAgDTKntBnkDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TehNPB
	HDfYDIOret85l9ZqIWGY6nw6zjQ/eBRYSVKJLkOcjUb5LYGqNKEza2kWrule5SSs
	AMlG9/is2DlNzbdoS1cBONko0wLTSlfpYF2DbDU3fhrR7Odj4gaeby0Yl4sx2bVg
	7uXWKM6r/WYerdwFC0G1bHBEt/Af9e5mlJCsk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE07E32E58;
	Sun, 21 Jul 2013 22:29:23 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61DD132E54;
	Sun, 21 Jul 2013 22:29:23 +0000 (UTC)
In-Reply-To: <20130720190707.GA30044@domone> (=?utf-8?Q?=22Ond=C5=99ej_B?=
 =?utf-8?Q?=C3=ADlka=22's?= message of
	"Sat, 20 Jul 2013 21:07:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE6A7F8C-F254-11E2-80BF-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230947>

Ond=C5=99ej B=C3=ADlka <neleai@seznam.cz> writes:

> Hi, I wrote a tool that effectively fixes typos in comments and only =
in
> comments.
> It can be downloaded here:
>
> https://github.com/neleai/stylepp
>
> For typos you need identify them, write replacement dictionary and ru=
n
> STYLEPP/script/stylepp_skeleton stylepp_fix_comment
>
> Here generic dictionary is used that was taken from wikipedia.
> https://github.com/neleai/stylepp/blob/master/maintained/dictionary_w=
iki

Thanks, but sorry we cannot use this patch as-is (even if it were
signed-off and came with a proper log message).

The patch touches phrases somebody may find questionable at many
different levels.

 - "lowercase ok" and "fall thru" are quite acceptable colloquial
   forms; if the person who DID the real work chose to write these
   in such a way, I do not see a reason for us to update it to a
   different preference.

 - There are outright typoes that noboddy would disagree with,
   e.g. s/sinse/since/.
