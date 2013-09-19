From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2013, #05; Wed, 18)
Date: Thu, 19 Sep 2013 11:10:39 -0700
Message-ID: <xmqq7gecu1gg.fsf@gitster.dls.corp.google.com>
References: <xmqqwqmdu6rg.fsf@gitster.dls.corp.google.com>
	<vpqob7pt8tj.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Patrick Welche <prlw1@cam.ac.uk>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 19 20:10:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMigh-0000y2-SY
	for gcvg-git-2@plane.gmane.org; Thu, 19 Sep 2013 20:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635Ab3ISSKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 14:10:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65218 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018Ab3ISSKn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 14:10:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3981143E74;
	Thu, 19 Sep 2013 18:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fdy9lWa3/aHaIdv9aSkeJoOHCS0=; b=yFTkl/
	Mn0v5AyNnmctrn/bY9ToJ5ZJQqK8rCBdB6Uue79ovlqFjEikwdGoVzX7db+hyvXX
	u7hSU4Hb9tt1RM58nkKMnryVF/qEIvaV24wPCSMC+mJl5y0KAqnL1TE0F+MK9GoD
	LVsIZAogCqhS8Vn8gbMAE1fsR7mXF+DKYPAvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aw4nP65fMufQyofqimbrcXZENvw5v6JA
	SEkGhRxI79E2lFZA3nsey51/A1qs8oVoWWhiE19M7WTO8puVFZStlh7MZvKV6eSS
	mITNEeSLE+VB94Ro7wI+WxoIU3uAnacOzLGsjaEqAv4L3Bmo4WMRWuGPnw2HWGEb
	hgC1C+LjxYY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CB3B43E72;
	Thu, 19 Sep 2013 18:10:43 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1CB0343E6F;
	Thu, 19 Sep 2013 18:10:42 +0000 (UTC)
In-Reply-To: <vpqob7pt8tj.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	19 Sep 2013 12:16:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CBCBA17E-2156-11E3-97DA-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235024>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * mm/rebase-continue-freebsd-WB (2013-09-09) 1 commit
>>   (merged to 'next' on 2013-09-13 at 82e8b91)
>>  + rebase: fix run_specific_rebase's use of "return" on FreeBSD
>>
>>  Work around a bug in FreeBSD shell that caused a regression to "git
>>  rebase" in v1.8.4.  It would be lovely to hear from FreeBSD folks a
>>  success report 
>
> We just did:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/234825/focus=234870

That only talks about "more" not showing colors.

    ... goes and looks ...

Ah, there is another subthread that ends at 234833 that reports
success; I am guessing from "pkgsrc" that this is either some
variant of BSD or Solaris?
