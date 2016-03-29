From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] worktree: add: introduce --checkout option
Date: Tue, 29 Mar 2016 13:28:11 -0700
Message-ID: <xmqqegatvxk4.fsf@gitster.mtv.corp.google.com>
References: <01020153bcda5e6c-2bae9b68-6669-4f29-a512-136c42722001-000000@eu-west-1.amazonses.com>
	<01020153c1dae323-b918e73f-f116-4760-9747-9aa8cafb2db5-000000@eu-west-1.amazonses.com>
	<20160329105402.GB1578@serenity.lan>
	<CAPig+cSUr1FK68qhHOf+M_tHqELW_ocJFU4-4kpjGVFV0R+F2g@mail.gmail.com>
	<20160329201501.GE1578@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ray Zhang <zhanglei002@gmail.com>,
	Git List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:28:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al0FQ-00053x-Lq
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 22:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758065AbcC2U2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 16:28:16 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:51529 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758029AbcC2U2P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 16:28:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 855D8503D1;
	Tue, 29 Mar 2016 16:28:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w774aluxQmT4aSnJy9xvVaaTldk=; b=U9FLCr
	+bc8aehLxkoaK1whjO5dNaM3AFKEeISPdoFtQIxrw/e404ziFn1Cl7NskvXeblZ2
	J18F19kfvrpTCxgPXW7P75eOlZqqwlHShB6hcfOkp2fSho5+kf7AbVH+QmFclGQM
	U0Cj5TSI99eAM9FvpCLSYZhJvjJwgMORjZlk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j5qPAKWZKddZRElIddtBBBrXs9cp/2rK
	fX0sayTFHV1M7kK9ClhFhomOX4zoZNA/nhmXGQhBFQed9VbdKlR8ZeWsxRu+2YPc
	4dm/qiV+6Hrt6lOifJ7uQuAb4PL7llayNnNQZioOkgWSbpEKeD0GukOLVcmpNjel
	22uAR1GO3H4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7CE82503D0;
	Tue, 29 Mar 2016 16:28:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D7CFF503CE;
	Tue, 29 Mar 2016 16:28:12 -0400 (EDT)
In-Reply-To: <20160329201501.GE1578@serenity.lan> (John Keeping's message of
	"Tue, 29 Mar 2016 21:15:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C280AE12-F5EC-11E5-8488-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290190>

John Keeping <john@keeping.me.uk> writes:

> Having gone looking, I can't find a reference but I for some reason I
> was convinced the separate version was preferred in the option
> descriptions. 

The one that is similar that came back to my mind while reading your
response was that we used to have these:

	--foo, --bar::
		Description...

and corrected them to:

	--foo::
        --bar::
		Description...
