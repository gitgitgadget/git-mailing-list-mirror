From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2010, #06; Tue, 21)
Date: Wed, 22 Dec 2010 12:48:42 -0800
Message-ID: <7vvd2l4jpx.fsf@alter.siamese.dyndns.org>
References: <7vlj3i5zz9.fsf@alter.siamese.dyndns.org>
 <AANLkTin_u9FiZf-hbnhY0Dp+LifctxH8wKDL=yRrSpm+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 22 21:48:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVVcI-0001Ei-0Z
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 21:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582Ab0LVUsw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 15:48:52 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61649 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab0LVUsv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 15:48:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1FBCB3B4E;
	Wed, 22 Dec 2010 15:49:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JMwJZumW+k5Kt8zxW4G96FKGjMk=; b=X3n4W6
	YW05S5vPaosurHdxVPRrBYwbigzDMcN7wREtSU3ncR84S2rAOYXggYEjeNvVPToc
	yQTju35WUgPeRK594cI62k13LfHuDzO2Vgn5hJHgvyBV9O+01azpPttgKoM+1TrD
	Yygga4eHABA50g6li/oG/QEADlGmrEtcWzDl8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yUbIyHT+NfrcpdxSrTd7GIAv+MHav8VW
	/DcGit0CZ4lCNB3GWBlDOgOLSEGLv+PqWiTpN6bWg0wrSWu7jxQ/tqPhsvTEtr4p
	xDfKKHCNfGMglByRBBiXzSWorSN69dnD49GMibhugrkHSrK02gC4OBfAwWlzl4Wh
	Sh0qLZifSDo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ECDC43B4A;
	Wed, 22 Dec 2010 15:49:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0F6873B49; Wed, 22 Dec 2010
 15:49:13 -0500 (EST)
In-Reply-To: <AANLkTin_u9FiZf-hbnhY0Dp+LifctxH8wKDL=yRrSpm+@mail.gmail.com>
 (Thiago Farina's message of "Wed\, 22 Dec 2010 09\:05\:23 -0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F125D03A-0E0C-11E0-8C63-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164096>

Thiago Farina <tfransosi@gmail.com> writes:

> On Tue, Dec 21, 2010 at 11:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> * tf/commit-list-prefix (2010-11-26) 1 commit
>>  (merged to 'next' on 2010-12-21 at 16e1351)
>>  + commit: Add commit_list prefix in two function names.
>>
>> This churn
> Since you said that, can could you drop this patch? I don't mind if
> you discard this patch since you consider it a CHURN[1].
>
>> already introduced an unnecessary conflict.
> Which conflict? If you say, I could try to fix it.
>
>> It is not by itself a biggie, but these things tend to add up.
>
> How *these things* add a conflict? This is a new thing to me really.

Look at output from "git show 16e1351 sha1_name.c".

The damage (i.e. my time wasted to deal with the conflict resulting from
the rename of the function) has already been done.  There is nothing to
fix.

One thing you _could_ fix is to keep an eye on what are cooking (e.g. the
diff between maint and pu), and refrain from throwing "trivial clean-up"
patches that may overlap with them at the list until the dust settles.
That would greatly reduce the annoyance factor.

The same comment applies to your patches to reduce use of alloc_nr().  If
absolutely nothing else is going on in the project, these are genuinely
good clean-up patches, but when other patches that give us real-life
benefit are in flight, just having to check if they overlap with whatever
is cooking now is already annoying.

Thanks.
