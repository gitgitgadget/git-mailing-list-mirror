From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2011, #06; Wed, 21)
Date: Thu, 22 Sep 2011 16:12:20 -0700
Message-ID: <7v4o04xjcb.fsf@alter.siamese.dyndns.org>
References: <7vaa9xyxpf.fsf@alter.siamese.dyndns.org>
 <m3r538qj0j.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 01:12:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6sRS-0001wV-Rb
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 01:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654Ab1IVXMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 19:12:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56822 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653Ab1IVXMY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 19:12:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E61775CFF;
	Thu, 22 Sep 2011 19:12:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HxbDYVQRDeZBJ4D+72cJqm9tyCs=; b=FS8ni+
	vF5JYREi2zlFgwNq+TsWtOB/fVuhRu7EXDuupGYMlTsnMH2OGvpc+m5/tyET90RA
	+CIAYY7TCTw6uNW1ONrbB+3ccbLPpCSajLD82+fEKOuitavyobwMjIhC5S1a3fd3
	xpLqx8Ak3hrZZjXyPdNJcc/q1RRal+oay2F4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wAJoEueOypHWN2U6p+lKgquHvqc6p6VT
	umW6ZwVHbS0HNSjKdkERuznffh/VLi6/Pagf0M3BhpemXaS2on9duqiSCRCiqaZV
	BLFu7cZg6L0UqWyY3X16zJDlMGw0KdX7NC3VCcY15J4VgOlX9UkTqXqIMFcIAcn2
	uFOphk2qjQk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCAFD5CFE;
	Thu, 22 Sep 2011 19:12:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67AC45CFD; Thu, 22 Sep 2011
 19:12:22 -0400 (EDT)
In-Reply-To: <m3r538qj0j.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Thu, 22 Sep 2011 16:01:51 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 53B16DDC-E570-11E0-9FC5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181934>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> --------------------------------------------------
>> [New Topics]
>  
>> * jc/namespace-doc-with-old-asciidoc (2011-09-16) 1 commit
>>  - Documentation/gitnamespaces.txt: cater to older asciidoc
>
> I'll need this to e.g. test the "rpm" target after adding
> Documentation/gitweb.txt and Documentation/gitweb.conf.txt
>
> But it is not something very urgent...

Now I am confused. If you apply your patch on top of "master" then you
cannot create "rpm" on your platform, not because your patch is busted,
but because "master" lacks the documentation fix from that topic. Is that
what you mean?

If the reason the documentation fix for "master" is needed is because a
new feature scheduled for the upcoming release has broken documentation,
then wouldn't we need the fix before the release, whether you are working
on your patch or not? How can it be not urgent if that is the case?

On my boxes with recent Debian, Ubuntu, and F14, I am not suffering from
the lack of the workaround, but if distros need the workaround, then the
time to apply it is now, not post release.

Hmmm....
