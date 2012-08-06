From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: use overridable $(FIND) instead of hard-coded
 'find'
Date: Mon, 06 Aug 2012 14:25:12 -0700
Message-ID: <7vfw7zyapz.fsf@alter.siamese.dyndns.org>
References: <502031C6.7040908@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Wong <normalperson@yhbt.net>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Aug 06 23:25:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyUni-0001uC-7T
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 23:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755623Ab2HFVZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 17:25:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42712 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752340Ab2HFVZO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 17:25:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 138DE7DB6;
	Mon,  6 Aug 2012 17:25:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=uMvk4j
	08k+itz4bUfCkpEDv6rtj7SIYQ6tbDSmNEQcwp2MHB3/pjoPvQAUk7ZL3Omy/+aD
	Hh+yw1r3Ow9tzI44+KQElFOgoj61xzEQlptf7ZnOD2xTmzSjqygS/Bv3DV1ogfJG
	2sme9r5SXmIxkYg+IK2w2eR1DCt+VUY5XiY1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nbFd3cWPZLtQuzID36KVTVHUCI89Y0rB
	DXIzFvpO0JjkU8wvoHnEZvnAUm7c4riXGjV76KljUtycUykXCE37AzKqQazu+Amg
	ay1bNqHrIA5o74QZYSRKGUwDOGCPabEe6gvFwj7pDF6/oQk9yt7fXWDQpl1AqPY0
	Df8hQ9YO6uE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 016D57DB5;
	Mon,  6 Aug 2012 17:25:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6EDBA7DB2; Mon,  6 Aug 2012
 17:25:13 -0400 (EDT)
In-Reply-To: <502031C6.7040908@kdbg.org> (Johannes Sixt's message of "Mon, 06
 Aug 2012 23:06:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 358043CC-E00D-11E1-AF79-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202989>

Thanks.
