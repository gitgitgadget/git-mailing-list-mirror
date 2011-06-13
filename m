From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2011, #02; Sat, 11)
Date: Mon, 13 Jun 2011 08:25:57 -0700
Message-ID: <7vr56xpxbu.fsf@alter.siamese.dyndns.org>
References: <7voc23sfxd.fsf@alter.siamese.dyndns.org>
 <BANLkTimHhaLu2ZGFG4ev_jWMu8szH8r=+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 17:26:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW91w-0001op-BZ
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 17:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631Ab1FMP0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 11:26:07 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34056 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016Ab1FMP0G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 11:26:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 93A614888;
	Mon, 13 Jun 2011 11:28:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r+svXw1J+tI+3MNfJXTWBGlngPo=; b=VceUi6
	YtEAsFdMu38h5Mvi65X2v1dGrry30Xwt/s+/pKv7cmcqD7CYErzbH8DXrTYJCqH2
	P24ziXzgzbOWu5LL0CvVkwrpkYYSonzJgduNfPiztzrL+JJfMOFbAd43vQ0ecKsZ
	tBAzsrImXraFsPVYSZdwOVpUaYKLx8nW8Z5/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=daIPPga/8nYsFZ3065hUMc6hBY/Qybr+
	jd7R6LqKAblHZdAidYEUhy96OqKpU++kcvKuesnWfe7T+QeCQ7f6dukVQw+gSRRO
	OneWkTcYSgxg3Rh4sJRg47KOLf2gGjJN0DHoGAQEJz5XuprxkeT15oYlLqgUCw5j
	QL+a76a9IyQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6F0174887;
	Mon, 13 Jun 2011 11:28:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8CB134885; Mon, 13 Jun 2011
 11:28:09 -0400 (EDT)
In-Reply-To: <BANLkTimHhaLu2ZGFG4ev_jWMu8szH8r=+g@mail.gmail.com> (Sverre
 Rabbelier's message of "Sun, 12 Jun 2011 18:18:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C006E096-95D1-11E0-A61E-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175714>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Note that I sent a reroll of this series (of which I'll send another
> version soon) which is a little more elegant in some places.

Yeah, I know about the series (didn't I have some comments in the
discussion thread?) and also I think I saw you talk about a re-roll during
the discussion before I wrote the What's cooking summary you are
responding to, which is why it does not appear in the list.
