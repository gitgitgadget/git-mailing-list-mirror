From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] remote-hg: more improvements
Date: Mon, 12 May 2014 13:40:02 -0700
Message-ID: <xmqqzjimpw7x.fsf@gitster.dls.corp.google.com>
References: <1399169814-20201-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq8uqdbgqg.fsf@gitster.dls.corp.google.com>
	<536a83097302f_76ff7a52ec6c@nysa.notmuch>
	<xmqqvbth8ha9.fsf@gitster.dls.corp.google.com>
	<536a999e2c0c_76ff7a52ec1e@nysa.notmuch>
	<xmqqoaz95ees.fsf@gitster.dls.corp.google.com>
	<536ad9601b73b_3caaa612ecdc@nysa.notmuch>
	<CAGK7Mr4DYuU34Zf_3fRQFkT+1TGOkpfLPUnQh=tYh6EMtBEt9A@mail.gmail.com>
	<xmqq8uq6rd30.fsf@gitster.dls.corp.google.com>
	<53712cd889ba9_2ea6e1f2f82f@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 12 22:40:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wjx1C-0000gX-Vn
	for gcvg-git-2@plane.gmane.org; Mon, 12 May 2014 22:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596AbaELUkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2014 16:40:08 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52236 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241AbaELUkH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2014 16:40:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6D09515BF9;
	Mon, 12 May 2014 16:40:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bfs9j2x2geWUGzm+rMhwzwKf054=; b=Q2/6sn
	uogMRHuw8OcQyU4cPykzFeJ8MhKo8cYS2ZvElekwsHh7vGMKGDfYF6g3+m/uDmlw
	9/3TEjIK0zbxirh0vFbhUDIv4OZRJ5d1d2utYvbV8siCNmYT+KMeNg0oB1TaAI57
	B5O93Xby66g3wdkqRap004573N24fLOrBfNB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ELteM9s1yEo/heNEqXIgn5w4+XxekwTB
	m0ID34yfHKT9XH+kIrAitMV5MNcHNsVxl6aqYLyqz9cepCdGN9Ka2WyjgnU8xKZf
	hWzGCqYsoxQyEvkMxnZV3SHmWbTECVi57DnDM4iDs5D+gza6iF5X07yQTCHFmw61
	1BBfG7JmmmI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6119F15BF8;
	Mon, 12 May 2014 16:40:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B0F6E15BF2;
	Mon, 12 May 2014 16:40:03 -0400 (EDT)
In-Reply-To: <53712cd889ba9_2ea6e1f2f82f@nysa.notmuch> (Felipe Contreras's
	message of "Mon, 12 May 2014 15:19:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 986835C2-DA15-11E3-87E2-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248731>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
> ...
>> I was originally led to believe that its code quality was good
>> enough, and that was why I merged the bottom three patches of the
>> series even down to 'next' in the first place.  But after seeing the
>> "Of course" response that led to [*1*], which made me recall many
>> patch-review interactions with him, I have started to have doubts.
>
> This is bullshit, and a wrong direction fallacy.
>
> Event #1:
> Junio rejects the graduation
> http://article.gmane.org/gmane.comp.version-control.git/248263
>
> Event #2:
> I give up improving remote helpers in git.git
> http://thread.gmane.org/gmane.comp.version-control.git/248063/focus=248341
>
> Junio is trying to make you believe that his decision (#1) was caused by
> something I did (#2). Don't fall into that trap, #2 happened *AFTER* #1,
> it can't possibly be the cause.

I think you misunderstood.

I never said that I do not want it to graduate up (out is an option)
based on code quality.  In fact, I do not think anybody discussed
about code quality until this morning.

But because I was asked, I thought about it, and then answered
honestly.  I do not know what a trap you perceive is about, and I am
not interested in your responses.
