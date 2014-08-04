From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] doc: format-patch: don't use origin as a branch name
Date: Mon, 04 Aug 2014 11:23:39 -0700
Message-ID: <xmqqfvhcru50.fsf@gitster.dls.corp.google.com>
References: <1406994383-5076-1-git-send-email-philipoakley@iee.org>
	<1406994383-5076-2-git-send-email-philipoakley@iee.org>
	<xmqq38dctcmz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GitList <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Aug 04 20:23:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEMvI-00019H-7a
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 20:23:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751506AbaHDSXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 14:23:48 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56040 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbaHDSXr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 14:23:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 37AB22D95D;
	Mon,  4 Aug 2014 14:23:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SppR2tkx+rU5ijXlVrCnM0mdTVc=; b=ceMYvV
	ZLSJYUvuEC+KDnCWK40d0uhkiYgCGDDB1N72jauvIVrbRFsM0cFq3Kd067JUWmfB
	nvEFhqQVpm9El9+TX3B4W4U4sI4AStq+rWwzcUVFZNLgLGTR1Lf0+rVwsWmCdzyi
	jMptUKgLHpZ1y0GGLmYv7HZ87joGav064QJbM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BkZUCg54CpzJDavCRBUU0f2QKWlh2vfw
	q6zqPvVzI0r3VNqNAhWrtWVOhODXbzg9RBQys5wZQ1CGOIv0HkSPcup0Xs2caPWO
	vAyGJ9wJxF1vfhamo785xPGEGM3ABXxwDqfJlLtfyTP/pYRdc59jAduDpSYIhHfM
	puzDA0Vm9QU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2A2712D95C;
	Mon,  4 Aug 2014 14:23:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 830C92D94C;
	Mon,  4 Aug 2014 14:23:40 -0400 (EDT)
In-Reply-To: <xmqq38dctcmz.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 04 Aug 2014 09:58:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 758B8E74-1C04-11E4-8E3C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254750>

Junio C Hamano <gitster@pobox.com> writes:

> Compared to that, what the user's local 'master' has is much less
> relevant.  For one thing, if a more recent commit that is on the
> remote repository is missing on 'origin/master' because you haven't
> fetched recently, by definition that commit will not be on your
> 'master' either, so you have the same staleness issue to the exact
> degree.  Even worse, when you are developing a topic to upstream, it

clarification.  I used "to upstream" as a verb to mean "sending the
work you did to be applied".

> is a good practice to merge your topic to your own 'master' to check
> it with the wider project codebase that is more recent than where
> your topic earlier forked from, and it makes little sense to tell
> 'exclude what I have on my master' to format-patch when extracting
> changes to upstream out of such a topic.  You send what the other
> side has, not what you do not have on your local 'master' branch.

and I have a stupid typo here; obviously I should have typed: You
send what the other side "does not have".
