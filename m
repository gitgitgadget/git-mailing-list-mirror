From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: Add Japanese translation
Date: Mon, 26 Oct 2009 16:59:13 -0700
Message-ID: <7vtyxld7vy.fsf@alter.siamese.dyndns.org>
References: <d092a4360910260649l9a13e5ep9387b4f8feb9a22c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: Mizar <mizar.jp@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 00:59:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2ZTC-0007XO-KN
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 00:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107AbZJZX7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 19:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754552AbZJZX7Q
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 19:59:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48151 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808AbZJZX7P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 19:59:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 456F1863FD;
	Mon, 26 Oct 2009 19:59:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=sumtj7UsXq4rKFhfe8dYWLap1To=; b=BxkK9zcAy+NHp6LcFuDcV1A
	z+hYj8d3RmLsMxxWfKgZZQ6gSiWQP3BhpWuC9EEJ7xK5UJOM68N9i/atgoWSU+2u
	54rMChd5mE1Aa20igJ2DBqOwrbVCFVWJZaZjTx2Cnuk6zpDk2+pM/EOgpwc9k/B8
	x1puHUTbLasae6PLrN1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=P32T4PL947fzps1Gs8+E2KWsQ6UWhpf0KTbMRnRFUWBbsIvDf
	ZiMoYEWMkC6KguT1L3L5sgbxm7F1H9YIsf/0r2BOKVWVcIFHV3Cbc3/fdh3NiJuz
	JpUfA+9mYTqUQdygDvlWLqRoFahGE5zUyYHG93LeRfyhCq6nJ43eOzxmZo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 26F89863FA;
	Mon, 26 Oct 2009 19:59:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 272BA863F8; Mon, 26 Oct 2009
 19:59:14 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 92766AB8-C28B-11DE-AF88-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131286>

Mizar <mizar.jp@gmail.com> writes:

> I tried to Japanese translation of gitk. Attached to its translation.
> Some messages are not translated yet.
> And, you may find some strange translations.
> People have a better idea of Japanese translation, please let us know.

Wow, thanks.

Having an empty msgstr "" for yet-to-be-translated entries is slightly
misleading.  People who work on PO files can spot them, but those who try
your wip translation files cannot spot them in the UI.

I am not sure if I am happy with the word used as the translation of
"reference".

Comments on just a few items I noticed (I didn't read everything that
deeply, though).

> +#: gitk:2099 gitk:2101
> +msgid "Exact"
> +msgstr "A-Z/a-zを区別"

git-gui seems to say "大文字小文字を区別" for this.

> +
> +#: gitk:2101 gitk:4447 gitk:6248
> +msgid "IgnCase"
> +msgstr "A-Z/a-zを区別しない"

Similar...

> +#: gitk:2397
> +msgid "Blame parent commit"
> +msgstr ""

Perhaps 「親コミットから blame をかける」

> +#: gitk:2404
> +msgid "Show origin of this line"
> +msgstr ""

Perhaps「この行の出自を表示する」

> +#: gitk:2405
> +msgid "Run git gui blame on this line"
> +msgstr ""

Perhaps「この行に git gui で blame をかける」

> +#: gitk:11137
> +msgid "Cannot find a git repository here."
> +msgstr "ここでgitリポジトリを見つけられません。"

「ここにはリポジトリがありません」。

> +#: gitk:11285
> +msgid "Command line"
> +msgstr "コマンドライン"

「コマンド行」would be equally common and shorter.
