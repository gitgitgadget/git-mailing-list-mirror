From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cover letter and cc list
Date: Fri, 20 Mar 2015 11:08:52 -0700
Message-ID: <xmqqpp83ee2z.fsf@gitster.dls.corp.google.com>
References: <20150320173504.GA6162@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 19:09:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ1Lx-0005Jq-BV
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 19:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbbCTSI4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 14:08:56 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60034 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750967AbbCTSI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 14:08:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 87FC840F90;
	Fri, 20 Mar 2015 14:08:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N9qhL3A9uCGYHhZvdWQD1MRn8rI=; b=OQ9jnx
	9Nclaf/XnYZxqupIgFF/SUZETdxA2+vjNIF0nTACvms8xOYJbFR1YfKUdTDMbzPb
	0ytsTA5F/00pZhvoWgptmQOZqwNzKClcGGB8q0qrPMbm2s1pfojLIkPDn6utKA2y
	dKckV9Oxx63iULyjVOe4UhpcfQ5zBdhkg1etg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HJ4LfkGJYXZVIKqeYvr4RBOwUtLnLqkl
	a6Tz8zjXp2KvU1Ns12Pu4CXdi7Ms2gwJnYsPD0tlfdRCy6mEwVFPks9agKUT1Ve9
	eZNzotUbx/ZV/kMFoCP7O400zF87khLsyfj5IEzCb6MJ8uD4L0BFqUsbqCSctYiM
	bjHEnu92WSI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 809AB40F8F;
	Fri, 20 Mar 2015 14:08:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A728240F8B;
	Fri, 20 Mar 2015 14:08:53 -0400 (EDT)
In-Reply-To: <20150320173504.GA6162@aepfle.de> (Olaf Hering's message of "Fri,
	20 Mar 2015 18:35:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2B2177D2-CF2C-11E4-9CEA-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265929>

Olaf Hering <olaf@aepfle.de> writes:

> What does it take to send the cover letter to all people which are
> listed in the Cc: list of the following patches? Each patch has a
> different Cc: list. The "git send-email --help" command suggests that
> this cmdline should do it. But the cover letter goes just to the address
> listed in --to=:
>
> env TMPDIR=/dev/shm LC_ALL=C git send-email -M --stat --annotate \
>         --cover-letter --cc-cover --to=$address \
>         $base..$head

First step is not to drive format-patch from within send-email I
would think.  Instead prepare them in files in a directory (with
format-patch -o $dir).  You can edit Cc: header in 0000-*.patch
message while you proof-read what you are going to send out.
