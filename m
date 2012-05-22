From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about submodules and absolute paths
Date: Tue, 22 May 2012 11:27:22 -0700
Message-ID: <7vk4043wc5.fsf@alter.siamese.dyndns.org>
References: <CAOmKuSoYP9fYORDy5twLpFh7SQ7rc6x2A=F8XjfKMqo-ErCauQ@mail.gmail.com>
 <CAOmKuSpqFrC7G4DbZu=uYDwvU6QqrJUi2aNBnSjy7_PXMMJpjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexey Pelykh <alexey.pelykh@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 20:27:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWtnu-0003aR-Tx
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 20:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759920Ab2EVS1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 14:27:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227Ab2EVS1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 14:27:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35CBE88F6;
	Tue, 22 May 2012 14:27:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UdoqwVuM7BZHoJ3MSJEeR9c1+XA=; b=fZyYBB
	qacbvVCaDXuGvYo3nOpcZl3Hs4ZDzIiKrI+IhidugP3ui686ZzsDYuhUrqLxudxK
	ys4HMo0xdRGmLbxPhtfhm0k2+pEVeY5nEiy26f8jb1Y7s36Op1OjUVVhFyBVA7dj
	nO1Zc5ThzqswPxcqlrDYKeyboqvUpeLZy4DMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oliIIHZajBRnVok/KadR3WMmsLD7bUm5
	kDAc1Z5mJBtM1OeBneAFSPThT+OaPIIvjaBV6sCz9ducfpz+nz4qfdpZs7+hTQH7
	bJJBZcIcv+hUndLNBRx1HGgNvHxePqH/q7YtAxAftO/SnHnYTBBdDyqi3SUYtqCC
	V55pPlwwEhQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C80B88F5;
	Tue, 22 May 2012 14:27:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B887288F4; Tue, 22 May 2012
 14:27:23 -0400 (EDT)
In-Reply-To: <CAOmKuSpqFrC7G4DbZu=uYDwvU6QqrJUi2aNBnSjy7_PXMMJpjQ@mail.gmail.com> (Alexey
 Pelykh's message of "Tue, 22 May 2012 14:36:45 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C678D3DE-A43B-11E1-9857-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198222>

Alexey Pelykh <alexey.pelykh@gmail.com> writes:

> since these paths differ from OS to OS and thus I have to keep two clones of
> each repository.

I am not sure what "absolute path" has with this.  If you are working on
two machines, don't you need two clones, one for each, anyway?
