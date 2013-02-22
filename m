From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add: allow users to silence Git 2.0 warnings about "add
 -u"
Date: Fri, 22 Feb 2013 09:18:22 -0800
Message-ID: <7va9qws1wh.fsf@alter.siamese.dyndns.org>
References: <1361513224-34550-1-git-send-email-davvid@gmail.com>
 <7vtxp4sw8e.fsf@alter.siamese.dyndns.org>
 <CAJDDKr4dCJ3p9QBGr09kW4_0BsVJcpE7s83=eNxKE15pMznWCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 18:18:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8wGq-0008Np-SF
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 18:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758556Ab3BVRS1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 12:18:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33796 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757899Ab3BVRSZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 12:18:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDCC2AFAE;
	Fri, 22 Feb 2013 12:18:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IBmxAPLlrtFR4EQQ3byBoCN6vq8=; b=qU+P7x
	7kfwX+4nUPOQ/3GT5jHKYSDgRtsnd5YIQ2X6cbTbY9jLvCK+WpvKf4p7bBQTm8kA
	Yprxfev7Zarb7AQQcaz7Rc7hVo6DoIlF7EtGWr8EIRwRyD0i1GIzTU9ybwN2kyoR
	Zfypq3btwjXgBD7rcVh3N+s+EoXe2+cpFfwcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KkMsfzKi53376kWCApCszwKl99xJrPFu
	kExOP7TjwZj+YYLJhe0lLeZ27NMTeKBs0XyMM+cgnJASFU8sb7SD1aAxERethTV0
	1J9b8ZU74tzj7342CShei0Sfr79wVZgwIL9GrJ9yYVAEj/ojGcgGWN0F3mjeyR5u
	XuF9PBt/0TU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D00F1AFAD;
	Fri, 22 Feb 2013 12:18:24 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 533AAAFAC; Fri, 22 Feb 2013
 12:18:24 -0500 (EST)
In-Reply-To: <CAJDDKr4dCJ3p9QBGr09kW4_0BsVJcpE7s83=eNxKE15pMznWCw@mail.gmail.com> (David
 Aguilar's message of "Thu, 21 Feb 2013 23:12:42 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DD32F74C-7D13-11E2-A36F-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216843>

David Aguilar <davvid@gmail.com> writes:

> Please enlighten me.

As you lack the knowledge of previous discussion, I think you will
be the best person to proofread the paragraph on this issue in the
"backward compatibilty notes" section of the draft release notes to
v1.8.2 to see if that is understandable to the end users and point
out what are missing or confusing.
