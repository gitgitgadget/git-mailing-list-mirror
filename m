From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/5] Documentation: add caveats about I/O buffering
 for check-{attr,ignore}
Date: Thu, 11 Apr 2013 19:12:22 -0700
Message-ID: <7vzjx4fqex.fsf@alter.siamese.dyndns.org>
References: <20130411110511.GB24296@pacific.linksys.moosehall>
 <1365681913-7059-1-git-send-email-git@adamspiers.org>
 <1365681913-7059-5-git-send-email-git@adamspiers.org>
 <7vsj2xhrc7.fsf@alter.siamese.dyndns.org>
 <20130411201219.GA21091@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Fri Apr 12 04:12:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQTTm-00080V-6o
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 04:12:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270Ab3DLCM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 22:12:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34134 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372Ab3DLCM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 22:12:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D12DE12E;
	Fri, 12 Apr 2013 02:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=erM5gvF5v4B/zSjPXqMgOZ+A2Tw=; b=RziE/H
	W6+XiiEKtH1nrZUZHatTA5pwpymcFWE3EECegWsY03Ex/WruwppGgH91g6xs6oJH
	3bKNdFB8C9XRQDN/fAGlW8P2AbYxv0kGfe2tMwzloMf13SblF+Bo+aBVzcuHZ7MD
	PU341sV+Ynqr9i+Tjz6AqFUTXqTQc+miNMn74=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lwmy9bOGuQQsrZ623VVBf3RoYzte3NxW
	MYbswUYvuors6bHETjYEqlXNTuLQtldIwqbukYUARc5/Sk02Zw0PUw091z/V6SxU
	yMlMI+AvkfMtqhgGbjMuXA8TcC9OL3KqGLU5qOMlLeq1EI/8mDHyvt1U5Tp5n0mQ
	TSx5cw1Vk8s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80B42E12D;
	Fri, 12 Apr 2013 02:12:24 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A53BBE12B; Fri, 12 Apr 2013
 02:12:23 +0000 (UTC)
In-Reply-To: <20130411201219.GA21091@pacific.linksys.moosehall> (Adam
 Spiers's message of "Thu, 11 Apr 2013 21:12:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 69F6CDE8-A316-11E2-9E04-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220944>

Adam Spiers <git@adamspiers.org> writes:

> On Thu, Apr 11, 2013 at 11:09:28AM -0700, Junio C Hamano wrote:
>> Reflowing of the text is very much unappreciated X-<.  
>
> I very much appreciate the excellent job you do as maintainer; your
> attention to detail results in an incredibly high quality project.
> However I do occasionally find your communication style unnecessarily
> abrasive.  Maybe that's just me.

Sorry for being me X-<.  Yeah, I agree that the above came out to be
more blunt than needed.

It is usually OK to re-flow the text in the paragraph you are
touching. After all, for the purpose of reviewing, people can just
blindly apply and then ask "diff --color-words".  In this case,
however, there was some changes that conflict in the vicinity, and
reflowing made the resolution unnecessarily more cumbersome.

I have briefly looked at this series, but it severely conflicts with
a few topics in flight that touch the infrastructure you are using,
so I haven't merged it to 'pu'. Perhaps after things calm down, we
may want to ask you to reroll on top of updated codebase.

Thanks.
