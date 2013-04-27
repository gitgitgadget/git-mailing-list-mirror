From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add support for -i/--interactive to git-clean
Date: Sat, 27 Apr 2013 16:11:47 -0700
Message-ID: <7vhairsh58.fsf@alter.siamese.dyndns.org>
References: <7vmwslw1py.fsf@alter.siamese.dyndns.org>
	<2a68239bfd3e6b9ea1842dd8e468ee3d3217af5b.1367079089.git.worldhello.net@gmail.com>
	<vpqip37abyq.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Apr 28 01:12:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWEHj-000650-KQ
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 01:12:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367Ab3D0XLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 19:11:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57007 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753694Ab3D0XLu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 19:11:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA6A61A98F;
	Sat, 27 Apr 2013 23:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iQdxJLsxZGRAoxzNntxeXOo9Jjw=; b=HBMvYh
	0rYYLxYZbZuURBkDduy3GhuBU2cX2SgVNBvPr1hPijzOoic9vaCyu/vw0K5pigKy
	rFnTT1skiYWwJwEWLDSiz+FXFHCXSwkpKxp+ae7r74DlwxL8e5ePaaE+tHtC9Tcp
	ZfV/CM25vqoy7DLfLp32Re/0b576whVvaY+rk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jsr0U3esMfS6JxHIx9ckh+8avORgfmfE
	yiarVOKUqDiYgfPlrAOhs5aNlN47ahef38wWnYfvWTWUxz5qidqtNstjfvq9pDwd
	yNak9c2BjsvzfbyLkPe26+fE9o3juUsiIqLCo8KEblxLTSgwnERBJY9nD9UrwWdg
	NwaSwx/pdCA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A10C81A98E;
	Sat, 27 Apr 2013 23:11:49 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 201A71A98B;
	Sat, 27 Apr 2013 23:11:49 +0000 (UTC)
In-Reply-To: <vpqip37abyq.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Sat, 27 Apr 2013 23:41:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6AD3294-AF8F-11E2-81E5-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222714>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> Reviewed-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
>
> Err, no: I commented on the intention of the first patch, but did not
> _review_ it, and didn't read this version yet.

Yeah I suspected as such.

And thanks for saying it loud in public, so that other contributors
can learn from this.
