From: Junio C Hamano <gitster@pobox.com>
Subject: A handful of topics merged to 'next'
Date: Wed, 03 Sep 2014 16:23:43 -0700
Message-ID: <xmqqy4u0uw3k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 01:23:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPJu2-0006gE-Cr
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 01:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935259AbaICXXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 19:23:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50933 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934482AbaICXXq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 19:23:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6D25E3864B;
	Wed,  3 Sep 2014 19:23:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=4
	boZenrIO1zr7NTCHH4ou7ipj7A=; b=IPYgYVvD6A5nY56at0irq2j6pJRhE083s
	7Wb2cqlGMcfWsqO1iRN8vfsOXGFtez0Cwa8LhF2Un7sjl5zO2cg3XE+avalellM/
	RFFFxKaGYbnZNyLYTyaC0yrVFIHV9GMZu+sy+TBqhiGzESK5ljhYuESK0vNw6cSk
	4lzEz71atY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=fca
	38mnNwyaAnzkxF/vR5e4L3TRpjYTRep4AU7Y/hs5Ot+edkOQAdK/ugHJFrjf6hF3
	H9FAaZVxdTdQg+O3hAYHmx1Pxc+eggLgIT2+0ZPMPHeTStliB2qPmpfwWrzafr+y
	M3K6Q53bg05AXnPYGtMiw5nJVkO1KcWEk6gDC0oA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6561F3864A;
	Wed,  3 Sep 2014 19:23:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DF82F38648;
	Wed,  3 Sep 2014 19:23:44 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 596194BC-33C1-11E4-9310-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256431>

Probably the most notable are ta/config-set-{1,2} series that use
the caching config-set API to update git_config() calls and also
many single-variable peekers.  I do not expect too many issues from
the topics merged to 'next' today, but if you found breakages please
holler.

Thanks.
