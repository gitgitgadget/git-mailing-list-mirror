From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] configure: allow user to prevent $PATH "sanitization" on
 Solaris
Date: Fri, 09 Mar 2012 11:46:22 -0800
Message-ID: <7vaa3p5zht.fsf@alter.siamese.dyndns.org>
References: <7vhay6etqc.fsf@alter.siamese.dyndns.org>
 <a706eaa1e1cd5e13a8cd98362fe09bba628789d1.1331296220.git.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 21:26:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S66OR-0006Ys-GM
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 21:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030496Ab2CIU0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Mar 2012 15:26:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45526 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030428Ab2CITqY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2012 14:46:24 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C6BD6EB6;
	Fri,  9 Mar 2012 14:46:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uxP3PeS9jDbjRWRQijiZoxjvSj0=; b=FFplNX
	T+OT4M5PY1vjvKZ8qJhiWM2He5VKhZG9gFPNXnKQv5bEk55zyEDdrES1hH1C6cDV
	PcaNTc763pdA++9KfGLxozuhlVJ+WmSPEQGzg2JZyQjk1A2P0IUFdMylDrmGLFxp
	EvoQxooU/kWELVS5sNG5IIm+Te7jFAubp1y80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PKy6h8QHv9x7cHTu5yyvwbbYFayVddKP
	ui7+WMiJnxLLpp6kH/BnnJN1XKsbkX4U0zuYbotQ+8fPI0o8rqO2kOhEA4C7Zy5H
	LfsfO5BPeT8tBIj0wQ1FTpyze92L4mFTxSql8DpcnUx4gOtXhTjRj4n/8ANuskSr
	8+DoIGknSUs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41DA46EB5;
	Fri,  9 Mar 2012 14:46:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD5BE6EB4; Fri,  9 Mar 2012
 14:46:23 -0500 (EST)
In-Reply-To: <a706eaa1e1cd5e13a8cd98362fe09bba628789d1.1331296220.git.stefano.lattarini@gmail.com> (Stefano Lattarini's message of "Fri, 9 Mar 2012 13:43:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D36FE16-6A20-11E1-8587-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192739>

Stefano Lattarini <stefano.lattarini@gmail.com> writes:

> This change implements the second approach, which is less-ambitious but
> also much less fragile.

I personally think your second one is the only sane option.

> ---

You forgot to sign-off the patch, perhaps?
