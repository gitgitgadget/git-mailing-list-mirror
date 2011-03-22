From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Remove unused variables
Date: Tue, 22 Mar 2011 11:15:03 -0700
Message-ID: <7v39mfkons.fsf@alter.siamese.dyndns.org>
References: <cover.1300798069.git.johannes.schindelin@gmx.de>
 <2aeb4f915afaf712c1d5bba46f4010a325ea14c5.1300798069.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 19:15:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q266v-00061r-Cx
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 19:15:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061Ab1CVSPN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2011 14:15:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34121 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab1CVSPL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2011 14:15:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1DB3B4B94;
	Tue, 22 Mar 2011 14:16:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LwN5Bp9iRZD4+3nOAABRJsWtXUI=; b=p6E4cT
	9QEQ5iUkUaTW+XfhNU6BptwYzHGYExpeWZ+GZf/WMcd6g97LC9Kk43FcCzrcQNXa
	+JH0bdCvUAqK0BRrwuzYRy4y6lsIV1Yr4RBoqAJBPcQeSC8/DOSeHp2EGUF1VuMf
	ryWvhTVtQMKa2Mdl3wFySsGJFCQ+2udIMHaAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CWXWPfqYAwU85CR65ct779XNwPkAtiut
	/MotRupWbU+UZ+c3LMGDAUqA3CSEl9LnZ7GzFc4+OmJ8XlNvMzgSfZJbs/PQZAkh
	AH9pfQnaPPnw1xx772YqNI5YtFAbulj+tontroB/ECZwUBIrVZFT4CkbsnLtNv1C
	jbJQgod3CHE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EF33D4B93;
	Tue, 22 Mar 2011 14:16:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1A4B34B8F; Tue, 22 Mar 2011
 14:16:43 -0400 (EDT)
In-Reply-To: <2aeb4f915afaf712c1d5bba46f4010a325ea14c5.1300798069.git.johannes.schindelin@gmx.de> (Johannes Schindelin's message of "Tue, 22 Mar 2011 13:50:08 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8C7ABBB0-54B0-11E0-8133-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169757>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Noticed by gcc 4.6.0.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Thanks.

I'll cherry pick only some bits, not because the changes in this patch are
wrong, but because I know some areas are in flux and I don't want to deal
with merge conflicts of the "one side fixed a small bug, the other side
majorly rewrote it and made the bug irrelevant" kind.
