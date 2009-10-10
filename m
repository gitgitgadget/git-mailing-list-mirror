From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: hide find_parent_branch output in double quiet
 mode
Date: Sat, 10 Oct 2009 00:02:32 -0700
Message-ID: <7vy6njafzr.fsf@alter.siamese.dyndns.org>
References: <b01cac406b93d5c67e3ae2e9a7aaa498a52dd9fc@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid> <20091010010843.GA30258@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Simon Arlott <simon@fire.lp0.eu>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Oct 10 09:05:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwW0i-0005Sz-UV
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 09:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbZJJHDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2009 03:03:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753505AbZJJHDu
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Oct 2009 03:03:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53247 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753461AbZJJHDt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2009 03:03:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D6F997225D;
	Sat, 10 Oct 2009 03:02:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XH0vTOkTN5MNJjn0EzBnPSLaR9Q=; b=Yqo5Tx
	FMpzfNAsaSo4bGbSsmnViBRnw+kajvV+NFh+SvI+TMTNVliLUVWMClPnNuwszXsm
	toGMRLnmi0gnf0RrG3uHdvBqcKRgQQgSNYcMJY0myCYT8wivplO1+hw7JhQCNidv
	fMVYR88w5j5rPjrsVwlr0vDq0LXo8nO7i0Ceo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gdJ+C/4fXOG4rGHKcPLodbrfILzrriEv
	4EoxuuMDQWMov7Gzj6z5nsUhTp606fVY2gfEBo+gshAUdgPg3psrcdEBR4lY3ACX
	oSdD3xF0JZvT6zVnF24HzbBBrAegS78r+rWxW0DT+LUqOZyFCtyoK/rl0M8RQWVb
	WGIpJu2hFWU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ADE1172258;
	Sat, 10 Oct 2009 03:02:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8070C72257; Sat, 10 Oct 2009
 03:02:34 -0400 (EDT)
In-Reply-To: <20091010010843.GA30258@dcvr.yhbt.net> (Eric Wong's message of
 "Fri\, 9 Oct 2009 18\:08\:43 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E5567076-B56A-11DE-9F96-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129871>

Eric Wong <normalperson@yhbt.net> writes:

> Thanks Simon,
>
> Acked-by: Eric Wong <normalperson@yhbt.net>
>
> and pushed out to git://git.bogomips.org/git-svn

Thanks; you seem to have rebased the history in this repository, and
merging from you will duplicate Alexander's "Avoid spurious errors", which
I already pulled, so I'll cherry pick this one from your tree.
