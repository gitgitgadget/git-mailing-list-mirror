From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git bisect/checkout and changes to .gitignore
Date: Fri, 22 Jun 2012 10:42:44 -0700
Message-ID: <7vbokbqm3v.fsf@alter.siamese.dyndns.org>
References: <CAPTjJmq4zv6dBR2Z-HfM7CJoxfprSdJEYYELuyBfahw2PkZ4Lw@mail.gmail.com>
 <4FE44983.30209@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Angelico <rosuav@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jun 22 19:42:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Si7si-00046M-1W
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jun 2012 19:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756246Ab2FVRms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jun 2012 13:42:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39025 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755964Ab2FVRmr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2012 13:42:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 844F174D4;
	Fri, 22 Jun 2012 13:42:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fPscc7pSzLEymo9Xy1mA3ZOU9iI=; b=GNKud4
	fKvHWxr4JG2EavBzakIYf7D3OkCclOW/HhQKVa8L4bFXTKUXBJOxU/wWRy2anY99
	m7e2tnzxghZXlI4rrjWg3mxqUVGsoNMH0BmB9N49T6O6NoMfRT5R8OZy4e21cWz6
	rxQ0UptCgUpG/V1QsD2CgxPSuA/j/5G3aukoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aBRnsqW3g9HX99jZGfCdbILzeuPkgleN
	XE6c2ebJ1mRfemMJDkDFEk/bS+smbq/pNwN945xGDIyTaisVuZjZdPTcMz9MiSE4
	dJ5yHmXHBZeTwtABDbcH6QtDupPVKALde1CfW9D9RI8Mk+2Ce3M8ZmOK37r2uvfZ
	kDIUm1oTlXk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B2FA74D3;
	Fri, 22 Jun 2012 13:42:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0EB8174D2; Fri, 22 Jun 2012
 13:42:45 -0400 (EDT)
In-Reply-To: <4FE44983.30209@viscovery.net> (Johannes Sixt's message of "Fri,
 22 Jun 2012 12:31:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD3F80F2-BC91-11E1-B42E-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200448>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Here is a thread that is worthwhile to read. I posted a patch
>
> http://thread.gmane.org/gmane.comp.version-control.git/185724/focus=185733
>
> but it was dismissed, see
>
> http://thread.gmane.org/gmane.comp.version-control.git/185724/focus=185746

Thanks.

Two thoughts and a half.

 - For people who do not want to read the above, the patch in the
   former was not a change to the code, but was a demonstration to
   exploit a bug in .git/ignore/exclude handling.

 - The latter message above outlined a future direction to properly
   handle "ignored" vs "precious" distinction.

 - There probably are other "here is a way forward" messages in the
   list archive whose visions haven't been materialized. Is anybody
   collecting these? I suspect that such a collection would be far
   more useful than a typical bug tracker that nobody looks at.
