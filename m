From: Junio C Hamano <gitster@pobox.com>
Subject: Re: .gitignore not
Date: Mon, 30 Apr 2012 21:28:18 -0700
Message-ID: <7vd36ocyot.fsf@alter.siamese.dyndns.org>
References: <29965-1335837520-563867@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "John M. Dlugosz" <ngnr63q02@sneakemail.com>
X-From: git-owner@vger.kernel.org Tue May 01 06:28:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP4hO-0007KN-5Z
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 06:28:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185Ab2EAE2W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 00:28:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38946 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091Ab2EAE2V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 00:28:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F3F77C67;
	Tue,  1 May 2012 00:28:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+Gd+xKahIJG+2tXdm9kyrxFvK8w=; b=ViFXkp
	XZdsBjLGqORo5fQgkFX8t6oCzl0FpsdIhcX2VU7cU4oK3mzA2HjdjgRm4oxgwkKu
	2EWSZaxWeVzp2awS1LTJuEv5BVXbdd6BbW85BEqPwzSBfAwHISuXQd9e2+9mIfZ3
	lrkROgx1AF7Ws/JWZwD6vzuwsDkGz8Qe5WfUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PimuD52SWDzSQCNr6oh7N65KBtQB2iIA
	zza6eonC1OXzJz0VjGI6h+R+epmn4rCFVY06URh9w8J+NIF5uQh7CaBaYydhaNJ2
	+9D3KtVHVUu3xgeEXH0FZwlwP3wlUfywvu27UmcM3llWrkIb6o5r1tMJrV7cMlDy
	W3nN76URXUg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06CC17C66;
	Tue,  1 May 2012 00:28:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 730DA7C65; Tue,  1 May 2012
 00:28:20 -0400 (EDT)
In-Reply-To: <29965-1335837520-563867@sneakemail.com> (John M. Dlugosz's
 message of "Mon, 30 Apr 2012 20:58:16 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14DC6F38-9346-11E1-8F35-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196655>

"John M. Dlugosz" <ngnr63q02@sneakemail.com> writes:

> I'm running on Windows, using msysgit.  I have some files that were
> supposed to be symbolic links, but don't come out that way.  I see
> them as plain files containing a relative name of another file.  To
> make things work, I copied the actual file over the would-be link.  I
> don't want to check in that change.
>
> I set up a .gitignore, and it works for the directory in general, but
> three files that were symbolic links it keeps finding anyway: deleted
> symlink (for those that were directories) and binary files don't match
> (for a file).  Even though those are under the directory I excluded
> with the .gitignore, it reports those anyway.
>
> How do I tell my local copy of git to really ignore those?  I don't
> want to stage it by accident.

Perhaps --assume-unchanged?
