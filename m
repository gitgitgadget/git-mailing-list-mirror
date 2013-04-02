From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Remove definition of refspec and pathspec from
 glossary-content.txt
Date: Tue, 02 Apr 2013 09:08:12 -0700
Message-ID: <7vy5d0gbkj.fsf@alter.siamese.dyndns.org>
References: <1481339149.727628.1364894663266.JavaMail.ngmail@webmail14.arcor-online.net>
 <1622068154.727718.1364894924364.JavaMail.ngmail@webmail14.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Ackermann <th.acker@arcor.de>
X-From: git-owner@vger.kernel.org Tue Apr 02 18:08:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN3lQ-0004Hu-Qz
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 18:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932520Ab3DBQIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 12:08:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50409 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761525Ab3DBQIT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 12:08:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C7F112C6D;
	Tue,  2 Apr 2013 16:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SRIRm+976c6fo1fWzdPhrxmcbYw=; b=kPPUFU
	NUApCOhqh+shlCj+lVdaNc/4NzFJC9bYvnocsUPe2EOVN9iwZuPozM0pM1NsKx2M
	Kn/8WK4urlMg0xrneh1O6ZJRngaQtI9Lck47DZGEVxf87yxbaUzZJcbLC/xbEgaP
	Lr5Uj6vSWJFc+MAeZXObgaWFcjTnE61Ds8TEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JTujHvDc9cV2FtehfSSca1Hi0zv7zoRg
	XEVj1lX+l06T9hpGM/XZhMZbela7GAgaTFWTy07ZNvBn6kzwV8cP8vePAyaftngw
	KLS23Bz/z/SzV/AJbo7A9jgvrFizoaWbJAbu8eNnW+2TbStWSPaLtrgVIVxq8MNs
	543LNKVwmx0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64AD112C6C;
	Tue,  2 Apr 2013 16:08:19 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C84A012C68; Tue,  2 Apr
 2013 16:08:18 +0000 (UTC)
In-Reply-To: <1622068154.727718.1364894924364.JavaMail.ngmail@webmail14.arcor-online.net>
 (Thomas Ackermann's message of "Tue, 2 Apr 2013 11:28:44 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 889F74DE-9BAF-11E2-BC9C-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219787>

Thomas Ackermann <th.acker@arcor.de> writes:

> Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
> ---
>  Documentation/glossary-content.txt | 65 ++------------------------------------
>  1 file changed, 3 insertions(+), 62 deletions(-)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 05bfebc..1c9c522 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -261,59 +261,7 @@ This commit is referred to as a "merge commit", or sometimes just a
>  	pack.
>  
>  [[def_pathspec]]pathspec::
> +       Pattern used to specify paths in Git commands.

Strictly speaking, it is "used to limit", but in the context of this
document it shouldn't matter either way.

>  
>  [[def_parent]]parent::
>  	A <<def_commit_object,commit object>> contains a (possibly empty) list
> @@ -382,15 +330,8 @@ should not be combined with other pathspec.
>  [[def_refspec]]refspec::
>  	A "refspec" is used by <<def_fetch,fetch>> and
>  	<<def_push,push>> to describe the mapping between remote
> +	<<def_ref,ref>> and local ref. 
> +	See linkgit:git-push[1] for details.

I think we can just drop "See ... for details" from here.  Besides,
why just "push" and not "fetch"?
