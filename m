From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] pull: pass --allow-unrelated-histories to "git merge"
Date: Thu, 21 Apr 2016 14:32:57 -0700
Message-ID: <xmqq7ffqsl4m.fsf@gitster.mtv.corp.google.com>
References: <20160421192500.23563-1-gitster@pobox.com>
	<20160421192500.23563-3-gitster@pobox.com>
	<CAGZ79kZgenHyvAKxKNGxKkybM=LgTfsvB7s91s1sQxxbp1xoFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 23:33:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atMDk-0001ga-1f
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 23:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbcDUVdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 17:33:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65421 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751302AbcDUVdB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 17:33:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BBFE6143AA;
	Thu, 21 Apr 2016 17:32:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mldjlvP//ELT39lSXa5fBdyk/W8=; b=NHvZTb
	nelXqC+rUePHX+c07qE4BLk9mCx45HuHGB119CjRw15jUjesyNri9NOPqzuTEyaV
	eJZdfC/vWl4UO71RBv0EJiHKMwu3RSIxUnQx9829s2Y/AAqPl/1X1X5Tdb/0Hr+0
	/f2ON5C7C8p7ZJgIhrSmqNDP/DIny+rzMFwA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S5UDMTiG6bV2vDlSuVcqqSZQAz+ErV7x
	KkzhXi0mHJxqWu5hmwm2PRyDwDgvNUreC2s2e6x8jei96F1uQqggU3N1a2Qdd+7E
	OPsA6xFSI/gQIg0pxfRhWW8XpU+pOJT7Uw5GBxshskKHA/T3OALWZOgrxrESOiLy
	HaDnIC7FLhY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B549B143A9;
	Thu, 21 Apr 2016 17:32:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0605D143A8;
	Thu, 21 Apr 2016 17:32:58 -0400 (EDT)
In-Reply-To: <CAGZ79kZgenHyvAKxKNGxKkybM=LgTfsvB7s91s1sQxxbp1xoFg@mail.gmail.com>
	(Stefan Beller's message of "Thu, 21 Apr 2016 12:36:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9E52A8BE-0808-11E6-AA32-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292153>

Stefan Beller <sbeller@google.com> writes:

> On Thu, Apr 21, 2016 at 12:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> An earlier commit said:
>
> And by earlier you meant to say e379fdf34f (2016-03-18, merge: refuse
> to create too cool a merge by default)?

The text quoted does come from that commit, but because there is
nothing more that a reader would need to read from that commit to
follow and understand this change, including its log message with
the quoted parts, I did not give a reference to the commit, in order
to avoid wasting readers' time.  In other words, yes I meant that
commit, and no, I didn't mean to "say" e379fdf....  I meant to say
"An earlier commit" and taht is what I did.
