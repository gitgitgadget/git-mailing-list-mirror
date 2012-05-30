From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git merge tag' not working as before
Date: Wed, 30 May 2012 15:18:08 -0700
Message-ID: <7vfwahxqhr.fsf@alter.siamese.dyndns.org>
References: <CAMP44s1bry3=W8hJPP9mJLzHmXFZug58aimGHhCSzwS9+Q-yWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 00:18:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZrDb-0005Ez-J9
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 00:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756243Ab2E3WSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 18:18:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62137 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753833Ab2E3WSL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 18:18:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C4168A40;
	Wed, 30 May 2012 18:18:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CDlhCa/lTZ6OWqpb+vaET19Gyzo=; b=ndHKi6
	CDhqv6d1nRYZ1H5uRTexB58oayjbKKwWcUj4K+lQNu1bbdmW+JGczZ3N9T6ccJlU
	9Z005B+j4rHrVFOI1XGPQAdO9MgVMLTaJvf71TfI5HdkzuMwq6ENzpolXCXm0qTb
	5SCXIZGYySVhH4gfzm+yj9MrNN+79DvcwPH2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aYAxSCBKuIHemqNhLDcuBRThzT6YRzQF
	D6DdJ/icEno43hVoufDM5mZ6RhEwp7i51hEViRgskUeBFAHlvsGM7eXuFgAhVXCD
	/irslleQmRyjtPSfe4a7LyvJ2kmc0d0JVnLg6VWNSELjUUZzHhdXS68mMxGDdEUg
	0+T+3lVMzHE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 905A18A3F;
	Wed, 30 May 2012 18:18:10 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27C178A3C; Wed, 30 May 2012
 18:18:10 -0400 (EDT)
In-Reply-To: <CAMP44s1bry3=W8hJPP9mJLzHmXFZug58aimGHhCSzwS9+Q-yWw@mail.gmail.com> (Felipe
 Contreras's message of "Wed, 30 May 2012 20:06:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 56E0E2F8-AAA5-11E1-8B88-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198847>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> I used to do things like 'git merge v1.7.10.3' (from v1.7.10.2) but
> even though it's ff it tries to create a merge commit.
>
> Seems like now I have to run 'git merge v1.7.10.3^0', I don't see why
> that would be desirable.
>
> I think this is a bug and a regression.

It was a deliberate feature enhancement a few releases back, IIRC.

You should be able to say "git merge --ff-only v1.7.10.3" as well.
