From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git documentation at kernel.org
Date: Fri, 10 Feb 2012 11:51:54 -0800
Message-ID: <7vobt6piud.fsf@alter.siamese.dyndns.org>
References: <CAPyqok3USqMxm0gNf_T9vnCoicp9XSwpWUCYJ8jh79h=V_UuOA@mail.gmail.com>
 <20120208213410.GA5768@ecki> <7vmx8rtu3e.fsf@alter.siamese.dyndns.org>
 <vpqbop6tyj6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, ftpadmin@kernel.org,
	Petr Onderka <gsvick@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Feb 10 20:52:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvwVr-00069P-Mx
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 20:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760029Ab2BJTv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 14:51:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56225 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759958Ab2BJTv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 14:51:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 331FF64C8;
	Fri, 10 Feb 2012 14:51:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G+sT2IYnG0JBhGjqM/IPOA1z+Dk=; b=eLu3WD
	cqbZfNwhRkOjZpN70dOAIg5wO6fpXSppc3NQkH7myXn1EwI/cUhVTt0NT0/IwbV4
	D7YThyehdRcWtvt0E0UTb3tvPHdi6jdo7Qq+BduaY2JoumWekPFDJNlIqEMf9apD
	pFZoVH3xRKTk+pgSgqJb4uKDJCgpgzXTAxI7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L90Qoo+QBTBKv9Dow91q65L5V8NnhUkf
	Tr7alj+lugiyB9ygj9DhxWBEMbLqOIoyCgFOw8WZvk+S6DZn3IxG7cg0VuvtXbi4
	E6faHe7cdz1vCt0r6kfcpxhkHCxMldR5nHTrArgJpvLME5zpgeb14RHrK4Fe9Vld
	WMTkf+FfTs0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B50C64C7;
	Fri, 10 Feb 2012 14:51:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B41FD64C6; Fri, 10 Feb 2012
 14:51:55 -0500 (EST)
In-Reply-To: <vpqbop6tyj6.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri, 10 Feb 2012 17:59:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AF7994AE-5420-11E1-8058-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190441>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Clemens Buchacher <drizzd@aon.at> writes:
>>
>>> Please restore access to the following files when possible. Some sites
>>> are referencing those, including kernel.org itself:
>>>
>>>  http://www.kernel.org/pub/software/scm/git/docs/git.html
>>
>> The pages reachable from this used to be living documents in that every
>> time the 'master' branch was updated at k.org, automatically a server side
>> hook script generated a new set of HTML pages and updated them.
>
> Is it possible to have the static HTML uploaded from another machine,
> not necessarily for each push, but e.g. for every release?

It would probably be possible, but I do not have that much time and
patience to sign 600+ files in the preformatted HTML tree one-by-one and
upload them using kup.
