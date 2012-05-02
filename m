From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull and GIT_DIR
Date: Wed, 02 May 2012 12:11:22 -0700
Message-ID: <7v62ceiejp.fsf@alter.siamese.dyndns.org>
References: <20120502142536.GA2609@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 21:11:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPexV-0006On-Iy
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 21:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756068Ab2EBTLZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 15:11:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61101 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755587Ab2EBTLY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 15:11:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05A976D11;
	Wed,  2 May 2012 15:11:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y0E/6UE/8nWKzh361pBhpCHCCpU=; b=dg/3B+
	kiemDUpjbHaJl1CNetwKF/oNix9JLaTQrxLx/IHr3sQBykp7wPecUX+5a2tSJpp5
	Uc00pCUlFGmlz5ykP3A+/jdFXK2roT//NYAg3UwnxO4NCosDNxiF0r0/CE5XenUO
	7kshFs2PiFmAvjCFJ4nHFRpGHjkH58meQhCfU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wOrd/DH0a8u+QIrwjLuPWzWimMB3B8Ku
	q/HMw/JpwhY8zg8tIjgUTPGMblkxS6iweeNiVJfiXDKcwt5QwdDUDAstqsg8smlJ
	DPdn+IskWIo8kDCPa+B7zkzSV24w2/dpKPftPYGmIw9cyi1aXdXJIQ9rnhkX0g/2
	7mryjZVeAxU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F16806D10;
	Wed,  2 May 2012 15:11:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71A3D6D0F; Wed,  2 May 2012
 15:11:23 -0400 (EDT)
In-Reply-To: <20120502142536.GA2609@debian.b2j> (bill lam's message of "Wed,
 2 May 2012 22:25:36 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B99901A-948A-11E1-BADB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196851>

bill lam <cbill.lam@gmail.com> writes:

> It appeared that
>
> a)
> cd /path/to && git pull git/https://....
>
> will fetch and checkout latest changes to working tree.  This is as
> expected.  On the contrary
>
> b)
> GIT_DIR=/path/to/.git git pull git/https://....
>
> will ...

-ETOOLITTLEINFO.

When you do b)

 - is /path/to the working tree for /path/to/.git?

 - where is your $(pwd)?

 - if your $(pwd) is different from /path/to, how are you telling git
   where the working tree is?  are you using GIT_WORK_TREE or something?
