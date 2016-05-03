From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule deinit: require '--all' instead of '.' for all submodules
Date: Tue, 03 May 2016 15:52:26 -0700
Message-ID: <xmqqoa8mkb4l.fsf@gitster.mtv.corp.google.com>
References: <1462313499-6760-1-git-send-email-sbeller@google.com>
	<xmqqy47qkc87.fsf@gitster.mtv.corp.google.com>
	<CAGZ79ka8RQmNzzKJ9r_GsLkSCK5Thewsz9scZvwpJb0Pf_+NRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Per Cederqvist <cederp@opera.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 04 00:52:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axjBJ-0000AF-FH
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 00:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933601AbcECWwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 18:52:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932265AbcECWwa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 18:52:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA27619081;
	Tue,  3 May 2016 18:52:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mF+G6BlLaQc0gD+d1l0WPKFYmjI=; b=jUITl+
	ZdNOhKmnia7PjRkkRXXpCfbsXDlvcJ3i5LFsW+qt/f1ssBB3MOXhwngS5l2WyIX0
	LzYAT2B4G9wgpo4tjc2zfNXUdxq/vZjFKqOgexJ+QkrxhC6KaRX9yWXhJ05i0DJc
	1ReSHt6yOX9hFTN5panvlCGD2a6z0pQPdfThM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZrNTJMHXqefhEZ/Sc4y0MDNTMIGwOvHf
	I5FH3Zzf3SW3KrHz4NXXXZB3rMvaRzfoNjxjYU1LakljgpgY/9dki8J1zUjSf99a
	YhXEo6gNWhKqIlaNVr9woTQvrfu8kyz3SwO0sT/bxlXmr65b+3qoHXwMU6BIjXB6
	Y/TAigjozGA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E214F1907F;
	Tue,  3 May 2016 18:52:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 533191907E;
	Tue,  3 May 2016 18:52:28 -0400 (EDT)
In-Reply-To: <CAGZ79ka8RQmNzzKJ9r_GsLkSCK5Thewsz9scZvwpJb0Pf_+NRg@mail.gmail.com>
	(Stefan Beller's message of "Tue, 3 May 2016 15:43:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B603BD5E-1181-11E6-A493-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293475>

Stefan Beller <sbeller@google.com> writes:

> So eventually (i.e. after the submodule groups lands)
> "submodule deinit ." will start acting weird again?

It would be nice if it never acts in a weird way, but that is all
future development, not related to this fix, no?
