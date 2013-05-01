From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/18] remote-bzr: massive changes
Date: Wed, 01 May 2013 09:39:57 -0700
Message-ID: <7vli7y8xia.fsf@alter.siamese.dyndns.org>
References: <1367370610-14250-1-git-send-email-felipe.contreras@gmail.com>
	<7vppxb8d9k.fsf@alter.siamese.dyndns.org>
	<CAMP44s3zf0Hbx4-KHVH7+wCm_czTigJo2y=wqD5Ai-9cKxZcug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 18:40:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXa4d-0007aI-HA
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 18:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908Ab3EAQkC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 12:40:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59027 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751966Ab3EAQkB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 12:40:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 673691AF53;
	Wed,  1 May 2013 16:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w32BY/rVmnvMUKg9TH2iAmaAZvo=; b=uNRPRQ
	rf/GzQDYZbDxahUf2VtZofFSlhkAfhbTBbf3AYT6e815pyJ6YZifNcSeXA/JwRRa
	NQIYCyYTm0MIC8OK7osubcB8sjpkuMjvL8mA4sNe+SuPpa7I+j7w7AZlRdIJxARa
	2hrf8jYlBE5jzuHsnGRKN9MegDYCnqSHxc/3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mau/oXLfJ7tB069n14jaNTCLkyvlt0mG
	kT+NlD7oT38B22c+jqRnKCMYhJgtpvTXE4/RKjRXlA21a+Voq2uFOd7+lr1sUOlU
	k1C52O2RcxqiynKQlqFbjhhJrry8oS2H2tM6hFbmrwMw0Wa7j+/sz9L6DuUQfOXE
	rwgWVsLu6ZU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FF921AF4D;
	Wed,  1 May 2013 16:40:00 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD9351AF4A;
	Wed,  1 May 2013 16:39:59 +0000 (UTC)
In-Reply-To: <CAMP44s3zf0Hbx4-KHVH7+wCm_czTigJo2y=wqD5Ai-9cKxZcug@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 1 May 2013 01:36:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3B32ACC-B27D-11E2-9D0A-A3355732AFBB-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223100>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> So let's go ahead and apply these directly on top of 'master', once
>> we hear from Emacs folks and they are happy with it.  I'll queue it
>> on 'pu' so that I do not have to go back to the list archive when it
>> happens.
>
> I already heard that everything seems to be working correctly, except
> one feature, the biggest change, which I screwed up with a one-liner
> commit. That's why I added a test. Anyway, I've fixed it in my github
> branch and in this patch series, and I've told them to try the fix.

Let us know when they make progress on that front.

If Emacs decides to switch to Git and decides to use this version of
remote-bzr for their conversion, or at least a nontrivial group of
developers favor to do so, without seeing concrete technical points
that say remote-bzr is not yet ready (e.g. "the conversion is still
wrong and X, Y and Z needs to be fixed"), that would be a very
welcome solid vote of confidence in favor of us going ahead with
this.

Thanks.
