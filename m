From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] update git-stage.po
Date: Fri, 13 May 2011 09:53:28 -0700
Message-ID: <7vtycy7d9z.fsf@alter.siamese.dyndns.org>
References: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
 <1305292458-3920-7-git-send-email-okano.osamu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: Osamu OKANO <okano.osamu@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 18:53:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKvcS-0002KB-Gp
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 18:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759607Ab1EMQxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 12:53:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44303 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666Ab1EMQxf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 12:53:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1105F4B8D;
	Fri, 13 May 2011 12:55:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WUuCVActG+Z/BjbZ0MZdQExwl7M=; b=B0J5Cy
	Nb+2RNeAC2rZ/HnTEXeJoTo0E18gtfeHTSLC1jOw5B/x/5g75/zgHEB22CrK07Rc
	gkqjSgKgWgHr/bc0ZJ0ccYTvpXCPmdUihNDKo2sup5diJounBncZzLD7TXfWw09D
	QjusyeTIbioiDU4r/4fX0EQfPQqNgcBGzgAhM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wO4k67rAMrBRoHZbXlFhqw7Q0qk5UKpN
	/fvtndS7GNOAo2TIXot1jPgGEmpF9Gq7VLivOAEHHsuMjiDRYVdtpF/j1jRVrzFZ
	R78VVofF6K34kDB8qzL6rGoTQHS+oI4X9MxXoZjviE2XkqCwmIcYPmhBTQUSHDdi
	zoeiOf7+fdY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DF6CF4B89;
	Fri, 13 May 2011 12:55:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 12A0E4B86; Fri, 13 May 2011
 12:55:34 -0400 (EDT)
In-Reply-To: <1305292458-3920-7-git-send-email-okano.osamu@gmail.com> (Osamu
 OKANO's message of "Fri, 13 May 2011 22:14:17 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3C4AE1E-7D81-11E0-B249-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173550>

Osamu OKANO <okano.osamu@gmail.com> writes:

> @@ -53,7 +55,9 @@ msgstr "DESCRIPTION\n"
>  msgid ""
>  "This is a synonym for linkgit:git-add[1].  Please refer to the documentation "
>  "of that command."
> -msgstr "これは linkgit:git-add[1] の同義語です.  git-add のドキュメントを参照してください."
> +msgstr ""
> +"これは linkgit:git-add[1] の同義語です.  git-add のドキュメントを参照してくだ"
> +"さい."

Isn't this a no-op?  Translators need to be careful about these.
