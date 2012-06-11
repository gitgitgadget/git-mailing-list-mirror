From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2012, #01; Sun, 3)
Date: Mon, 11 Jun 2012 07:54:28 -0700
Message-ID: <7v7gvdaogr.fsf@alter.siamese.dyndns.org>
References: <7vr4twudqm.fsf@alter.siamese.dyndns.org>
 <CAMP44s0cQe3jdfzbJmFVoFS50Ho5hVPg9dpZx0KhG3sP_J8=_g@mail.gmail.com>
 <7vbokwmifp.fsf@alter.siamese.dyndns.org>
 <CAMP44s2VGLj8kRih-95A0VDq86WKWHF3EhLvz0etyHHtP27qLA@mail.gmail.com>
 <7vmx4baaqc.fsf@alter.siamese.dyndns.org>
 <CAMP44s2US+PoxfboZSML84GEvUwiHV4eQBOQSp6zhruT8xrKdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 16:54:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se60u-0007Oh-Gk
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 16:54:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754949Ab2FKOyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 10:54:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62570 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369Ab2FKOyb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 10:54:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95A0585AC;
	Mon, 11 Jun 2012 10:54:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=thBWe3u60hwc7JAYgO2FSlLXBZM=; b=BZmmWV
	/gwZN1rfSwreEcgPrGBFpHl6ejwrDiofS8WqlfaIXjM2reNKwZMLz9zEASxSpifW
	WD2+qGxjMPSj9SEXt1cQFWcLpEosiIava40kgLYYGa5ifL+vVkFXUO2oxFyumjpV
	Y+bupY2oEFJnhwcC4q6mK2fmlpKdUpHZ31yv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BVMZDRsPOds3VVgUnE17y4LYSfXls50c
	N5MukW3fWPnqzZfA0xflm5i8pOx5y61IfjqreGV7+YEk10HoypUejJtkaXsjfAWn
	qp/woV3hm4vTge6DaHF6URmBHyc4wqbTCvEwYfPqC2DyFIQki07h/IR9Pp11s6ZI
	ogyn0SvcWZo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C06085AA;
	Mon, 11 Jun 2012 10:54:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 139FA859D; Mon, 11 Jun 2012
 10:54:29 -0400 (EDT)
In-Reply-To: <CAMP44s2US+PoxfboZSML84GEvUwiHV4eQBOQSp6zhruT8xrKdg@mail.gmail.com> (Felipe
 Contreras's message of "Sun, 10 Jun 2012 17:09:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5907C072-B3D5-11E1-A5EC-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199655>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> You say I'm being irresponsible, I say you are being preoccupied by a
> theoretical problem that will not occur, and would not cause any
> problems if it does.

See how the two implementations are different and think what happens
when a user dot sources these two scripts in different order. Callers
of __gitdir in one expects it to pay attention to GIT_DIR, callers in
the other don't, but you can't have both at the same time in the
same shell, can you?

It is not theoretical, as you yourself already made it happen.

Get over it.
