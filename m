From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 6/6] commit: add a commit.verbose config variable
Date: Tue, 12 Apr 2016 14:24:22 -0700
Message-ID: <xmqqa8kyplkp.fsf@gitster.mtv.corp.google.com>
References: <01020153faf9fc14-e6ad18fa-c892-4601-bab7-e2cc4cd9e100-000000@eu-west-1.amazonses.com>
	<01020153faf9fcd0-879c8263-6143-4ad2-a3b3-deb78c93246a-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 23:24:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq5nR-0003Wn-7k
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 23:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965356AbcDLVY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 17:24:27 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53461 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966398AbcDLVY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 17:24:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 07D04550EF;
	Tue, 12 Apr 2016 17:24:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6ZvLLfVWQc20aNJo5PNpYrawgVA=; b=thdNi+
	e+kmgKVQbqfNKcjW+YpexXlNcwavRT2MoDYi3YZVGUXy61s5PLY3s1I8H75ZuS+n
	BNGfSwxnjTCq3GSIvUtFL3iQsSJu/MvxhXTomeuNfHQ13Z/U/2Nd7rzw57eIkQ0D
	JA4XZXkRXFc7JTEmpk8W9s645zhui5aME1t48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AYpxhmazO38TyXY7meo8YlBBF1lUHILp
	/ztGBQhFuqW81bfPNg45JBqnYRClGMbdEm7EIQOiYLCJdF9pL317Hqb2HJ8GD+k2
	tU+mCqQT+7EMY0wnDFX4qUoCy4OuxSoEN95UFXwoZmMUUS/CsJmczae03DlMWzDy
	523OhyJ4TgM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EFC5F550EE;
	Tue, 12 Apr 2016 17:24:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6FAE2550ED;
	Tue, 12 Apr 2016 17:24:23 -0400 (EDT)
In-Reply-To: <01020153faf9fcd0-879c8263-6143-4ad2-a3b3-deb78c93246a-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Sat, 9 Apr 2016 12:23:20 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ED4DC0D6-00F4-11E6-BEE6-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291297>

Hmph, isn't this already in 'next', hence we cannot accept a
replacement patch?
