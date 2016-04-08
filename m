From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] set_worktree_head_symref(): fix error message
Date: Fri, 08 Apr 2016 10:26:54 -0700
Message-ID: <xmqqvb3svwo1.fsf@gitster.mtv.corp.google.com>
References: <1460102587-22297-1-git-send-email-k@rhe.jp>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: Kazuki Yamaguchi <k@rhe.jp>
X-From: git-owner@vger.kernel.org Fri Apr 08 19:27:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoaBX-00006O-DA
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 19:27:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758210AbcDHR06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2016 13:26:58 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58649 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754202AbcDHR05 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2016 13:26:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1F80C51EB4;
	Fri,  8 Apr 2016 13:26:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lLaB+c161pVK+ljIlQrgO+2ZQvQ=; b=tJS62d
	IpEolwNYEhOOdT7DOBQlgmltm9qf2gXPVvCIgwTEpGs4dy2UfCFlwMfkpwfaBkJJ
	+oFQnrjPIdqI0CBVjXpp06vp2sbbpILRHVE0A9t43Ox13eFujFOxTmZW9k/N0LPe
	frByYfle0yQsU+9HX5QdTZ0T+bM2Mt6pMkteg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lqYCrD1twjK9sM1tcYRODwrIi1OrMa3b
	+FJRNKQ1/urEH4ZL8wEpaVosQWkobCvqFqmbLaNIFyDKUEELcvExjgdFzp0y1/Me
	hlH9W8d6c1TGOWBAo56YvhjfZXicqUyZnEdn3qln744Akv0vinytFPs7YhCY1snr
	2oKfF/HpR9E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 16A7451EB3;
	Fri,  8 Apr 2016 13:26:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8FB8351EB2;
	Fri,  8 Apr 2016 13:26:55 -0400 (EDT)
In-Reply-To: <1460102587-22297-1-git-send-email-k@rhe.jp> (Kazuki Yamaguchi's
	message of "Fri, 8 Apr 2016 17:03:07 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1742841A-FDAF-11E5-9C9F-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291046>

Thanks.  Will queue.
