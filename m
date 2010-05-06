From: Junio C Hamano <gitster@pobox.com>
Subject: Re: merges and git log --stat
Date: Thu, 06 May 2010 13:13:23 -0700
Message-ID: <7vsk64hjq4.fsf@alter.siamese.dyndns.org>
References: <20100506192616.GS4599@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu May 06 22:13:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA7Rx-0004be-Mb
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 22:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758345Ab0EFUNc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 May 2010 16:13:32 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758297Ab0EFUNb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 May 2010 16:13:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AD9F1B1D4D;
	Thu,  6 May 2010 16:13:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8MZLUxhpfBE1
	mknVOmadSLJBVjY=; b=iY9EVCaOtSO961vf7NHy3h0ampnjhzeT9kpbsKcV3IvF
	LjWPtx0YnluT/sqsoZy+QZTpgIzqmjA/SpeahXJVSJzEJ4xGoEfXzrLfcYHyp9Ji
	gLwF56mJ2JZc8pRSPD8LsBzmcZl6441E5powr+h7d7538FxWAppoMAcwm58Th4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=glgTLi
	JpLBEcvOpY9eOB9lI5shWbiBimvyvMeFsAShNV0r/iCsbg6ipGPMcI4PrV87gFcL
	QLLTT888txagJCm9xlzj3zMCohDGIadvLH4cY57N69G5HP2vc33tAX/3XQCQhA8Y
	kxp8ahXPiioHVEEDyPap7F3m9SdioWeZw31Bw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8868AB1D4A;
	Thu,  6 May 2010 16:13:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 02B01B1D48; Thu,  6 May
 2010 16:13:24 -0400 (EDT)
In-Reply-To: <20100506192616.GS4599@neumann> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Thu\, 6 May 2010 21\:26\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D4FEC734-594B-11DF-B493-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146491>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> I've just noticed that 'git log --stat' does not print the diffstat
> for merge commits.  Is this intentional?

It's very much designed so.  You cannot clearly define "diff from which
parent you would want to see".
