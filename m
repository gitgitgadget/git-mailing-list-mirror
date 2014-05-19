From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] request-pull: resurrect for-linus -> tags/for-linus DWIM
Date: Mon, 19 May 2014 09:30:11 -0700
Message-ID: <xmqqlhtx3f58.fsf@gitster.dls.corp.google.com>
References: <1400263070-15312-1-git-send-email-gitster@pobox.com>
	<20140518083305.GB28462@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon May 19 18:30:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmQSK-0002od-1C
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 18:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965062AbaESQaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 12:30:20 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65288 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752878AbaESQaR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 12:30:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3E0E91588E;
	Mon, 19 May 2014 12:30:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C7OUKJ7P8/8+pzxPoG2P0rAAhMM=; b=ohL2sN
	bt3ycNcQ8+NYJN4gCvRB+Yk9Ouuxfhiguxgoma0VoZ9S2v4ax8l06NSkdVZZBj6J
	k3j608FIdNLUK2HKetwX9bx2LmPN+3XCPWksSsfR/vNGlLWUVR3+1TF3ae3uO35J
	9EWsuLjisr3447bOoEsiP+gM0vmZ4p9djpvwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N2MZNB5Ln4Ks+Uup/4JwUl4cyvuovoX8
	TyKuu4kqwaeISK2i1l3UhmbcasgrDEbCzaS/sVW/5bbhpC7LlaTFVRCWwwlC4zHH
	Yr2XxZuXodayP8ZJx2jDPcmIRBCPXBEBJJE7+VbeIBNxXyIQ10tNHwOlO7njI+YK
	///oxF3uBNo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 33A571588D;
	Mon, 19 May 2014 12:30:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0E47915888;
	Mon, 19 May 2014 12:30:12 -0400 (EDT)
In-Reply-To: <20140518083305.GB28462@redhat.com> (Michael S. Tsirkin's message
	of "Sun, 18 May 2014 11:33:05 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DA29AC90-DF72-11E3-B879-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249595>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Well RHEL6 apparently comes with git 1.7.1, there are
> probably others.
>
> The problem isn't theorectical actually,

Thanks.  Let's do the fix for 2.0 then.
