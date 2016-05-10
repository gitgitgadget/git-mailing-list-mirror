From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2016, #02; Fri, 6)
Date: Tue, 10 May 2016 00:16:29 -0700
Message-ID: <xmqq37pqs7qq.fsf@gitster.mtv.corp.google.com>
References: <xmqqeg9e24ay.fsf@gitster.mtv.corp.google.com>
	<B50A244E-05FE-48FF-9C9B-ED7AE35C5C7C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 09:16:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b01uH-00044Q-MM
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 09:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbcEJHQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 03:16:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64898 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751049AbcEJHQd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 03:16:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 31E96ED17;
	Tue, 10 May 2016 03:16:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KxAEgfZukYPbQis+vVZMm0o3Knw=; b=s+WOaq
	tApecWv1XrxRGe7htHhzz7UKYcNK6RySReZVNYSc/Tf+xRgfIEAUlsCo/WggEM4X
	WIgRSBJkVF/woyBx5/Q5Z+pO4mzlNE+lXo/hyPQewhmztDOBPmsyJI4qymBtXdMC
	5GquK2/tWG5nxeutkZumd2nzY+AuQZu6D9Q84=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ITYl0XuiAphD+QC2G/3zPoOAdPEGEH2q
	S46XTQz0APRgLQGCwRNw2VptNSGmtWNX9sX8dLK+UHLOiPZpwG/ej2gnc730lCsR
	oHfzZNGXBqeFF24wVjVKbUZUDHIe85jToefcJNg7sPRrado8EbaTmtFyvgdagQVp
	fIUOSisY8bA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 29D2DED16;
	Tue, 10 May 2016 03:16:32 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2646ED15;
	Tue, 10 May 2016 03:16:31 -0400 (EDT)
In-Reply-To: <B50A244E-05FE-48FF-9C9B-ED7AE35C5C7C@gmail.com> (Lars
	Schneider's message of "Tue, 10 May 2016 08:27:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1EEB2652-167F-11E6-BE57-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294110>

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 07 May 2016, at 00:46, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> [...]
>> 
>> 
>> * jc/doc-lint (2016-05-04) 2 commits
>> - Documentation: fix linkgit references
>> - ci: validate "gitlink:" in documentation
>
> The first patch "Documentation: fix linkgit references" seems not
> to be on the jc/doc-lint branch?

* jc/linkgit-fix (2016-05-09) 1 commit
 - Documentation: fix linkgit references

 Many 'linkgit:<git documentation page>' references were broken,
 which are all fixed with this.

I didn't want to keep the documentation fix hostage of the linter
improvements.  The linter implementation I am not entirely happy
with, but it did its job well enough that the broken references have
been (hopefully all) identified, and I queued the fix separately.
