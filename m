From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/7] i18n: merge-recursive: mark strings for
 translation
Date: Sun, 22 Jul 2012 12:37:54 -0700
Message-ID: <7vboj7r31p.fsf@alter.siamese.dyndns.org>
References: <cover.1342920089.git.worldhello.net@gmail.com>
 <e488b5e8f40859a842f80855a3dd4861a4ced6d0.1342920089.git.worldhello.net@gmail.com> <724ca3989123159c9970b3276b4764dcbd5fd56e.1342920089.git.worldhello.net@gmail.com> <b3d82ce0b35597c90bf8280f38a5b336066cea18.1342920089.git.worldhello.net@gmail.com> <16d740e2d6e38e1ce8f3770f506623068b1cf309.1342920089.git.worldhello.net@gmail.com> <247c407ce218c77a603eb6cf93228d94adc48f04.1342920089.git.worldhello.net@gmail.com> <4cf7af65d3f14f61d165fa971e3784d4553d030b.1342920089.git.worldhello.net@gmail.com> <11b679b77fb9e30b8ea29c3e8a76e711d969377a.1342920089.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Stefano Lattarini <stefano.lattarini@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 21:47:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1St27s-0006AH-OG
	for gcvg-git-2@plane.gmane.org; Sun, 22 Jul 2012 21:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582Ab2GVTre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jul 2012 15:47:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58189 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752429Ab2GVTrd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2012 15:47:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F36208AF5;
	Sun, 22 Jul 2012 15:47:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=jNN8It62bT0IQCUKIYGOShAayjs=; b=CEjtzSKwys2kfFPXJUsP
	woxKIk6pIp8ptiX0mRDmLT8AGcwJJEO4F7H8AQxphgB7CsRozcO5OpXXfBD6FmDO
	H9TWalqXk3htxhtH9oRJ5F3pa97Qhzodd3vai0MWLYmu+W19LdezPA0091cAqcPZ
	AtvXAWXFFbct4ZFAxYM/vck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=pn97TW7CJhgv95hOtnB0vB//UXEcqAQZqWGU8hqek9YQpd
	ZLqdDx1WuD1i5b3D3NxSD4ulqq2SUcgZVxkr6dVYiGaRicXqEP18FcwGhdEyx7uj
	zxf/GnOPHLZrvFi9XeYw/He2HWkmJMd8Lw0Zl4DMhFz1dySFzz/F97jF5CWzU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E20C78AF4;
	Sun, 22 Jul 2012 15:47:32 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 345978AF3; Sun, 22 Jul 2012
 15:47:32 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 13BBC3C0-D436-11E1-9568-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201860>

Jiang Xin <worldhello.net@gmail.com> writes:

> @@ -249,14 +249,14 @@ struct tree *write_tree_from_memory(struct merge_options *o)
>  
>  	if (unmerged_cache()) {
>  		int i;
> -		fprintf(stderr, "BUG: There are unmerged index entries:\n");
> +		fprintf(stderr, _("BUG: There are unmerged index entries:\n"));

Micronit. "BUG:" entries are only to help Git developers to locate
the exact codepath that is buggy, and I think it is better left
untranslated.

> +		if (NULL == renamed) {

Better written as "if (!renamed)".
