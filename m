From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 00/10] transport-helper: updates
Date: Thu, 31 Oct 2013 11:10:33 -0700
Message-ID: <xmqq4n7x8g6e.fsf@gitster.dls.corp.google.com>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
	<1383212197-14259-2-git-send-email-felipe.contreras@gmail.com>
	<BBA75EFD-E68A-4E7F-A886-8878650D58A8@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Thu Oct 31 19:10:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbwhd-0004h2-LW
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 19:10:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697Ab3JaSKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 14:10:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43267 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753484Ab3JaSKg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 14:10:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E7D84E3DC;
	Thu, 31 Oct 2013 14:10:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NX7203QsYVZAp5DLwrKKxso+dcQ=; b=edVKW6
	prZdW2lRtaJakFmzKkNrquSyfSL+WPfBLi88w0g1hnkZq3zLQFVT969hQstLeEdy
	fRQRPcS1XMMVDY+sfcajz0kkkaCzbRzBBYZSVB7fKlZvAqZ6OPIlpxhr/mMs424K
	RBd+oLu5ce6d/XocgT493zZtLiXnJWlHRPLkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DpNguhxVCSJGbTj08CP5GP7fODtA848G
	Ses1Xjb6erUoAjn6BXJOhXM1z715BGpbr7Z0sn+fXuJdh0qeTAjVJxxv0YmqqL16
	FEMmQ2dFgfS7DcwjQQVxsDcNS/hcByz1KEqFZoAlJbONFNMqe+Tn4d6AR9MLpHQP
	F3LBTvJYsKM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F8054E3DB;
	Thu, 31 Oct 2013 14:10:36 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6F5764E3D8;
	Thu, 31 Oct 2013 14:10:35 -0400 (EDT)
In-Reply-To: <BBA75EFD-E68A-4E7F-A886-8878650D58A8@quendi.de> (Max Horn's
	message of "Thu, 31 Oct 2013 18:59:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BD2C7EB4-4257-11E3-99BC-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237139>

Max Horn <max@quendi.de> writes:

> On 31.10.2013, at 10:36, Felipe Contreras <felipe.contreras@gmail.com>
> wrote:
>
>> Hi,
>> 
>> Here are the patches that allow transport helpers to be completely
> transparent;
>> renaming branches, deleting them, custom refspecs, --force,
> --dry-run,
>> reporting forced update, everything works.
>
> I looked through this patch series in detail, and it looks fine to
> me. Indeed, it fixes several nuisances when using remote-helpers, and
> as such would be a definite win.

Nice.

> In other words: Would be really nice to see these applied!

The series is sitting on the 'pu' branch, and I think there were
some "fixup" suggestions during the review, so it may need to be
rerolled before advancing to 'next'.
