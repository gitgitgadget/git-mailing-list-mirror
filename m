From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: only show stat if configured to true
Date: Mon, 29 Nov 2010 14:50:34 -0800
Message-ID: <7veia3zqv9.fsf@alter.siamese.dyndns.org>
References: <1289336340-28337-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 23:50:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNCYa-00079A-2F
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 23:50:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755121Ab0K2Wun (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 17:50:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62930 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752031Ab0K2Wum (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 17:50:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F5393D0F;
	Mon, 29 Nov 2010 17:50:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4JS/phz5PCy8PY3oGkl5vuSp5A4=; b=TDPxIB
	nqe+aDxJ+JQJbuK6ZhZpeBvXijFobQ+FwNI4V2d09NZxn1GB+e94bqpqQPcwFArS
	ocmBXWUlTbCBay81QPbOarG06jCsqQEU8EZ87clw6oJ6Abo6gAvCUqTjuFoBcfoe
	f3MnvByzbkTAXUpL+z0paCkddfaAKieDNtqfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I4UGUi3uPkbWwgS/+Y4sU1GYBYZJJ/en
	9ZQjpWYSio4ur5Nxxb0VfjW1eoSpPdMvrHaDtH/D6k0oQx7QZPoN0Swp2QizqC1M
	GrOTiQlnKe4AOdKleTvK3vhgrJ76WKoD2CY7ososG+TTJPxjiPQtv8r2cVfDV0fj
	m00qz9ITMpo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D2D903D0B;
	Mon, 29 Nov 2010 17:50:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C61563D09; Mon, 29 Nov 2010
 17:50:53 -0500 (EST)
In-Reply-To: <1289336340-28337-1-git-send-email-martin.von.zweigbergk@gmail.com> (Martin
 von Zweigbergk's message of "Tue\,  9 Nov 2010 21\:59\:00 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 20B84562-FC0B-11DF-A25F-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162437>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> If rebase.stat is set to true, a diffstat should be displayed. If it is
> not set, it should default to false. However, if it is explicitly set to
> false (or other value), a diffstat is still displayed, which is probably
> not what most users would expect. Show diffstat only if it is set
> to true.
>
> Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
> ---

Sounds sensible; it would have been nicer if it came with a test, but this
particular change is sort of obvious ;-)

Thanks.
