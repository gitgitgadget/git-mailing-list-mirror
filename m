From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/3] Make 'git help everyday' work
Date: Fri, 10 Oct 2014 16:15:30 -0700
Message-ID: <xmqqtx3b4iul.fsf@gitster.dls.corp.google.com>
References: <1412976337-2476-1-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: GitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Sat Oct 11 01:15:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcjPW-0001gH-Mv
	for gcvg-git-2@plane.gmane.org; Sat, 11 Oct 2014 01:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751850AbaJJXPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2014 19:15:34 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61809 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750810AbaJJXPe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2014 19:15:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1AE6715BC0;
	Fri, 10 Oct 2014 19:15:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/+AI3Le6VgUo/ZE+o0vkqYEL1lo=; b=qKGz/R
	XX/aS3YNPBr4+Gzs1HzgxsBXA13dLuo+pTpGihw2yUzhwBBnUNoosmlEuynk8NJV
	XHx0kpHyXwzrlQx/ws++3u+Bm/xtHShGd4p2hbBH3jfsMt/GvkIXV6kUktRGPGs1
	7cpw2lxuK/B6S5c8G93qEqI7qnbtAYAO3WWsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R9lYo4BozHv4wYWrWycXM8wRR3iLdPix
	byOqacKEiL6ZF50VdkxKWgKjr2wUr3aJtF41LF3zDIi76Cnl7oZPSrQoiGOzwzTO
	KVVaHFnDJ5gJM9o1bEfe9PdcXts9FvhA4EGO7FxqCbPBw/3U+eP0aK8DhGMYzmXY
	pczywmGLgeY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CF8515BBF;
	Fri, 10 Oct 2014 19:15:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8C7CD15BBE;
	Fri, 10 Oct 2014 19:15:31 -0400 (EDT)
In-Reply-To: <1412976337-2476-1-git-send-email-philipoakley@iee.org> (Philip
	Oakley's message of "Fri, 10 Oct 2014 22:25:34 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 549CDAA2-50D3-11E4-B1D3-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.

Looked alright from a cursory read; I tweaked s/10/-10/ where you
gave examples of limiting output from "git log" before queuing.
