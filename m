From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Change error messages in ident.c Make error messages
 caused by failed reads of the /etc/passwd file easier to understand.
 Signed-off-by: Angus Hammond <angusgh@gmail.com>
Date: Thu, 10 May 2012 12:43:42 -0700
Message-ID: <7vpqabn7o1.fsf@alter.siamese.dyndns.org>
References: <1336676770-17965-1-git-send-email-angusgh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Angus Hammond <angusgh@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 21:44:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSZHM-0004hH-Rx
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 21:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760590Ab2EJTnv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 15:43:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59280 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761349Ab2EJTnp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 15:43:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 840678773;
	Thu, 10 May 2012 15:43:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=a4qg9T6+4ew8sEtpOBkFaWcCpkg=; b=oOLnDu
	actBZRvv8R3Zsue9jpVCmtoxs5ojZK3oKfoW/hGNd8rVdSioWQncyMnkx5NABlqM
	QtajUWCp5jeX5nIZs+lEkVJ/sQDGdBjTCHRUCr4qk+o+y8AE1FBv/sYi7m/rIMR8
	bhq96WbMSEeeBk8adOGloDPPvqIL9wFgkLw0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q9joiwxhMLPAa9mG8wwGBuSsSrQVX5L/
	XDlXybsDzkDjwtB9zrCzjp0QZTAfq4LxIYi11nysvJj1zeQ0cB3z/+RhbEhYuTW1
	V3tWVT1DyNrlHlvTy07dt7lKgUKncx3uf3JKSBp5BhUyfZskkX54YMqyNKD6ldS7
	VzOqerL+xOA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C18A8772;
	Thu, 10 May 2012 15:43:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5EEC8771; Thu, 10 May 2012
 15:43:43 -0400 (EDT)
In-Reply-To: <1336676770-17965-1-git-send-email-angusgh@gmail.com> (Angus
 Hammond's message of "Thu, 10 May 2012 20:06:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7370DC98-9AD8-11E1-ABE8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197621>

They are one of the oldest and humorous messages we have in the system,
and more importantly, users will see them only once on a badly configured
system.  If there is no real-life reason (e.g. "if we do not change this
message, Nuclear reactors will start misbehaving"), I would rather keep
them as they are for hysterical raisins.

But that is just my preference to keep Linus's twisted sense of humor.
