From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 0/8] Multiple simultaneously locked ref updates
Date: Tue, 10 Sep 2013 13:18:22 -0700
Message-ID: <xmqq7geoxwfl.fsf@gitster.dls.corp.google.com>
References: <cover.1378732710.git.brad.king@kitware.com>
	<cover.1378773895.git.brad.king@kitware.com>
	<xmqqob80zlju.fsf@gitster.dls.corp.google.com>
	<522F4EDE.1010104@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 22:18:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJUOR-0000bO-1Q
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 22:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751345Ab3IJUSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 16:18:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44524 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207Ab3IJUSa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 16:18:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB0064052E;
	Tue, 10 Sep 2013 20:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qQf10QbrrYCMDl6VB50z+pqCPgA=; b=BAfP6f
	CcASQRH7tXXYjYW67SwAMXIzdqQUluSCGrJJjCDdQwJNBXz1pLwAp4bnGfzIL3hL
	Qm2o8iEP46blECfiok6brKEYBvcBUO74tKjsgHUqt72morxdB9lzTMYeqYR5STqn
	Hvk6HLPLml3P2jkzG+181GHPFFtWbYZ2wumEI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EAeUy26w5heKzf2ANAbY7vQdcTTJJRc9
	kqxDS4D24S2krlbRczvPfEdhNWm3zcJK/movZWbfE0VVqlaHPhs0BsUVULfUK5Hh
	EeuWw5Q/HfcCJqW2BBhESupv/PoaZkDFGpRRJCCehKp4o2Hsb2WPC/BgK/GqllT5
	LEdDoNp+svQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F18C140526;
	Tue, 10 Sep 2013 20:18:27 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B28BB40514;
	Tue, 10 Sep 2013 20:18:25 +0000 (UTC)
In-Reply-To: <522F4EDE.1010104@kitware.com> (Brad King's message of "Tue, 10
	Sep 2013 12:54:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 261BA2E4-1A56-11E3-BCC7-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234479>

Brad King <brad.king@kitware.com> writes:

> On 09/10/2013 12:30 PM, Junio C Hamano wrote:
>> Thanks.  I am not sure if I should rewind and rebuild the series
>> with these patches, though.  This is a new feature and does not have
>> to be merged to 'maint', so rebasing is perfectly fine, but it is
>> not strictly necessary, either.
>
> I just thought I'd help out with the conflict resolution.

Yeah, such an independent confirmation of the conflict resolution is
very much appreciated.
