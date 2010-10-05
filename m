From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Useful tracking branches and auto merging
Date: Tue, 05 Oct 2010 09:35:45 -0700
Message-ID: <7vk4lw7g2m.fsf@alter.siamese.dyndns.org>
References: <AANLkTimq0sKUavKiXepDOz+DvrymuRAVUyAyV+FzbCBD@mail.gmail.com>
 <20101004204625.GH6466@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 18:36:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3AUo-0005HE-14
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 18:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752452Ab0JEQf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 12:35:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51159 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822Ab0JEQf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 12:35:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C4E8DC209;
	Tue,  5 Oct 2010 12:35:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zuBAYW5GO30r2vOWbD6BblXCT8U=; b=AW/dLH
	FCC7XVeFLIQoBcQ48aoVjZecJLw80FUN4+9X75wU+GDeMG43cuxiHWMc+vrsiKCY
	yPaBZtlmOqYOziYSqzp0//zCkb2//mHEqvhsBBvMRdoczsiyjvxPHNyeDRZBRAcR
	C652Sh/8jExGIbY4+hgHDl+sijjgPS6TmhlNA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jrDPA//6azZWWwvqjXyYO90SeKEhfGRO
	iNchD2yujBJDjdJcMhHQ6E6tnH6+TSX4cajb7xBLexIyhEA8kW80a4RW6U1I17fo
	2sLo72Qbf0eE8L9DJaL0Kb1rijArNK2wArCwqiO7a4wAWQniP95d+KoRXvIe/6Xj
	pnYxRCZVtTY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EC618DC207;
	Tue,  5 Oct 2010 12:35:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E55ADC206; Tue,  5 Oct
 2010 12:35:46 -0400 (EDT)
In-Reply-To: <20101004204625.GH6466@burratino> (Jonathan Nieder's message of
 "Mon\, 4 Oct 2010 15\:46\:25 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9D71E1A0-D09E-11DF-907F-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158213>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Maybe 'git pull --all' could be taught to eventually do this?  That
> would be incompatible with its current behavior of fetching everything
> and merging some random branch, but I don't think anyone is relying
> on that.

I vaguely recall that we had discussions to disable "git pull --all",
which most likely is a mistake?
