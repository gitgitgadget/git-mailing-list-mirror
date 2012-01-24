From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.9.rc2
Date: Tue, 24 Jan 2012 10:11:27 -0800
Message-ID: <7v39b53r8w.fsf@alter.siamese.dyndns.org>
References: <7vpqegjxu3.fsf@alter.siamese.dyndns.org>
 <CADVrmKT2RAOC-n_-h4pGJw91imj28h0-HqwGH-NOu-m3XtqiJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: fREW Schmidt <frioux@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 24 19:11:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpkqG-0002Ut-9x
	for gcvg-git-2@lo.gmane.org; Tue, 24 Jan 2012 19:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757269Ab2AXSLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 13:11:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49900 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755876Ab2AXSLa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jan 2012 13:11:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D834665D5;
	Tue, 24 Jan 2012 13:11:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B/De3VxCMqnNhP2wHJUXXW3KZww=; b=ZMb5Y1
	0282Tdhm7EXBkpYhgVHt8Z8xiXSO17GpBVSHtCz3wWtFkssmyWGxDUZlj98lin5g
	ITSjzW+MaG+VEo6d8yqhx3cxar2ziM6aekCCXfvrfdcWOxJHYUg84l+QmwuzL6Wb
	NC0cexRMJkNjrxT/5qdNZhsQ/R/d1oKqFAIdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZodIAjAls4NaEjTRH8hrUk/cH8Jw55a5
	GYaDwIe0OFGBlHaqxCGc0QjnmQTbV5a1f4JgBd1NlhB66iwXMIuyuLWe9iigv4mw
	reclhfgxmRCAN3Tr80VZlVqJYHKnFqiOnIVh/8mdFMDuzu/EO2LhcZc+ws9/8kVk
	gj6Ug/gHAYE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9ADD65D4;
	Tue, 24 Jan 2012 13:11:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 617CE65D2; Tue, 24 Jan 2012
 13:11:29 -0500 (EST)
In-Reply-To: <CADVrmKT2RAOC-n_-h4pGJw91imj28h0-HqwGH-NOu-m3XtqiJg@mail.gmail.com> (fREW
 Schmidt's message of "Tue, 24 Jan 2012 10:16:54 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D67984B4-46B6-11E1-9BB5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189053>

fREW Schmidt <frioux@gmail.com> writes:

> On Wed, Jan 18, 2012 at 7:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>  * gitk updates accumulated since early 2011.
>
> Where might one go to find more detail on this one?

Hmm, http://git.kernel.org/?p=git/git.git;a=shortlog, perhaps?
