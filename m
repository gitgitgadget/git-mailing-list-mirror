From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add completion for git-svn mkdirs,reset,and gc
Date: Tue, 29 Dec 2009 23:43:36 -0800
Message-ID: <7v7hs46h5j.fsf@alter.siamese.dyndns.org>
References: <C065517F-C829-46D1-8D1A-88C18EE2112F@gmail.com>
 <20091230005950.GC6914@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Zeh <robert.a.zeh@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 30 08:43:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPtDk-00014f-1S
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 08:43:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbZL3Hnr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 02:43:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbZL3Hnr
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 02:43:47 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:54098 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbZL3Hnq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 02:43:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A3878CB0A;
	Wed, 30 Dec 2009 02:43:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2OWBo/2v4xcbQ93ZlxGwL0UT0a8=; b=U+gMl6
	HlLtXSKgCPwQaWLvouDYeEq3bRZ5DeU2sLRGzRnIluFHhEtyY6wpNlJvbvZH3e0O
	3LVSE62uNqfq6hKEq1Cqyvteq0tJqJHfk+VhSJ5Pt88BS79azLaOc1c5gE5VqFKA
	dBS7z6pY9yAtVxryUjjp7KR59dgBQlz375XxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nB+iKz0u0m/g9n5nDT5zOfM6GFqQ+hNj
	dExWwxEMnQatdnfR2Mvq1tN3TTEgDxmadUK+8KA2ULf9g8z/JOkurmO9VKnI3FSR
	wcJ71j+vDMOdt8lYR0NMgRPUsD0GnAm9LFLzdR8RQUwGWsEWQCEWQzAubUoGpr9j
	MCSSeUWDjYk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 335818CB09;
	Wed, 30 Dec 2009 02:43:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 746DE8CB08; Wed, 30 Dec
 2009 02:43:38 -0500 (EST)
In-Reply-To: <20091230005950.GC6914@spearce.org> (Shawn O. Pearce's message
 of "Tue\, 29 Dec 2009 16\:59\:50 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0D2C1286-F517-11DE-8A60-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135864>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Robert Zeh <robert.a.zeh@gmail.com> wrote:
>> 
>> Signed-off-by: Robert Zeh <robert.a.zeh@gmail.com>
>> ---
>> contrib/completion/git-completion.bash |    7 +++++--
>> 1 files changed, 5 insertions(+), 2 deletions(-)
>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>
>  
> -- 
> Shawn.

Thanks.

Robert, if you are planning to be a regular contributor, please check your
MUA settings, and next time, please first send a patch to yourself and try
running "git am" on it to make sure it applies.  Your patch was seriously
whitespace damaged (all the leading SP on the context lines were
stripped).
