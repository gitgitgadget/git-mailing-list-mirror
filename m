From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/18] Signed push
Date: Fri, 22 Aug 2014 13:03:28 -0700
Message-ID: <xmqqiolknvfz.fsf@gitster.dls.corp.google.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
	<53F7A119.7070704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 22:03:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKv3p-000186-Pv
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 22:03:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbaHVUDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2014 16:03:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64342 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844AbaHVUDl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2014 16:03:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 142E732ABE;
	Fri, 22 Aug 2014 16:03:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UfAPhgnI++/TWukIj0pk8dJ5FCs=; b=XcwRvv
	ydtd7zvhfEtr/vCIHTdoPXIuRObxnSU2eFQUophlUK9JOc+4M6/ndNvO3LcQPgIy
	ibzUJpa0WbcAmpKcMJrg8w323zLLMN+2ouCZBGGvucFg5/yncRDrAk1nmCMyEimo
	C04HYUea+gS30lOzeJj73BDy3pTn4D6qtqQ94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R/dmDxKQzPgzOEl484vmRKh5UmMS4M6a
	eC27CSOAansaXv4lQ7YUifYnqk/9ToC+F8TmzfyUR5H0xhmh3M+k7tjIcZAJ6Ubg
	4FQU991q+3JHeq0Jy6f77D7OyrwBGVLC27bjghs2yRGBqiWoQ2HTucZnYLSFdRfw
	drbzIMXwzLQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0947932ABD;
	Fri, 22 Aug 2014 16:03:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8D63232AB3;
	Fri, 22 Aug 2014 16:03:30 -0400 (EDT)
In-Reply-To: <53F7A119.7070704@gmail.com> (Stefan Beller's message of "Fri, 22
	Aug 2014 21:59:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6353FE26-2A37-11E4-AAC0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255699>

Stefan Beller <stefanbeller@gmail.com> writes:

> So there would be tags like:
> 	master_2014_08_21
> 	master_2014_08_22
> 	...
> 	maint_2014_08_13
> 	maint_2014_08_21
> and so on. Whenever there is no tag at the tip of the branch, we'd
> know there is something wrong.

Who creates that tag?
