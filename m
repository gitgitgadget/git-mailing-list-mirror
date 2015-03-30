From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] show-branch: show all local heads when only giving one rev along --topics
Date: Mon, 30 Mar 2015 15:34:11 -0700
Message-ID: <xmqq8ueew1wc.fsf@gitster.dls.corp.google.com>
References: <1427753543-19680-1-git-send-email-mh@glandium.org>
	<xmqqd23qw2cl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 00:34:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YciGD-0008T5-6t
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 00:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973AbbC3WeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2015 18:34:14 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54997 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752383AbbC3WeO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Mar 2015 18:34:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D83245603;
	Mon, 30 Mar 2015 18:34:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2HvdTHbtTKjLn26r1JcMz9yuH1I=; b=n2axiQ
	M7K5CCJlw3mikD1Ejc1dEr0oI3cyaATzz1UFoeNNg2aOdOa6AorZBZ7zJCEvv5AL
	ifrpv1X7o0ui0ethWbrAMsWuHEs1Y4m45M2b1hwa9ciZMOMeLcm3TGv4zPAhgOeX
	YGWLfLqYt516FM2NPB86hsNiCPIAfT9jYqMP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NT0+KO9FVa8aaiPlNSeHoM/yt/nK2l3b
	bVoIshZOhbJJoqc09bG1iHEBr5DnL6xu+EuO47hujXGzw10NGIsI5rI36uHnRAYK
	+baToqVnzHHuc7MmunF3KrT05UUAUXCzyHdalCnGUZBfEzTqJkORvg8Z2PkRTItU
	zzQOiXPs6pI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5499B45601;
	Mon, 30 Mar 2015 18:34:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA6B745600;
	Mon, 30 Mar 2015 18:34:12 -0400 (EDT)
In-Reply-To: <xmqqd23qw2cl.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 30 Mar 2015 15:24:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E3CE81B4-D72C-11E4-858A-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266483>

Junio C Hamano <gitster@pobox.com> writes:

> ...?  I am not saying the change
> is problematic; it is just I haven't looked at this code for a long
> time that the existing machinery is already designed to tolerate
> duplicated input.

"for a long time to say that the existing code is OK or not" is what
I meant to say.  Sorry for the noise.

> Thanks.
