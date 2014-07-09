From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] makefile: add ability to run specific test files
Date: Wed, 09 Jul 2014 15:59:21 -0700
Message-ID: <xmqq61j69m0m.fsf@gitster.dls.corp.google.com>
References: <1404945412-10197-2-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 00:59:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X50pp-0008LU-06
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 00:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756508AbaGIW73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 18:59:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61905 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756217AbaGIW72 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 18:59:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 040622852C;
	Wed,  9 Jul 2014 18:59:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UPaBGo5QM2xYwbk79z/kSfaez0Y=; b=HPG99u
	Ol+Rx+6XKA1SnbP3fq4Nd84vN/nxa95CtfPuI3FLxEQlWWrnyJfjpSs+YU82gL0X
	IyR/+mQjt3dZ27p1t8Ib0PaT20kbF4TEnvHpbLIvlDm8POH/HAaeJRmjpCUWc6h/
	zO1K0pvgPwt49mlDJl6/OmDax580wRxe10388=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fM2soetQvy1kZj2lZusixXU7RQVIKrYX
	EnCpU2n6Doq8bqijwHSnHVHx3KmoPSF8zz7UJjyVOeIUIHD92KBrmL1+pSCBg5lc
	2pqvy0daBGEUZZUNxJzOnezTJXOlG1MaaKq+yeIVV8IhtBNB0cO9emB2dG/M5YWE
	TLqMbCeCjT8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ED09C2852B;
	Wed,  9 Jul 2014 18:59:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B909928525;
	Wed,  9 Jul 2014 18:59:07 -0400 (EDT)
In-Reply-To: <1404945412-10197-2-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Wed, 9 Jul 2014 15:36:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A1CBCE1A-07BC-11E4-B6DD-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253168>

Jacob Keller <jacob.e.keller@intel.com> writes:

> Running a specific test file manually does not obtain the exact
> environment setup by the Makefile.

What kind of things are missing, exactly?  Perhaps that is something
you need to fix, instead of mucking with the top-level Makefile.

I recall last time when I did a patch like this I was told to look
into "make -C t" ;-)  What is different this round?
