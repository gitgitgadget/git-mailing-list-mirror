From: Junio C Hamano <gitster@pobox.com>
Subject: No "What's cooking" yet, but...
Date: Mon, 15 Apr 2013 00:26:58 -0700
Message-ID: <7vvc7o1cfx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Spiers <git@adamspiers.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= Duy 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 15 09:27:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URdoh-0003ib-Vp
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 09:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753741Ab3DOH1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 03:27:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60600 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753702Ab3DOH1B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 03:27:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A2CD11E1C;
	Mon, 15 Apr 2013 07:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=t
	6kwSXigEG66ycFdKke/lmpyeBs=; b=MzLpHWbt2r5ApQTiLu1WwFOZqE1spc3k2
	kJ1bNR4gNPPg8PKdr7YgzQpnRJTfvkNLVf8u8tDSDWLPF5WVhTn+E1DpMJP0G7vJ
	X/agEJ8t+sqlzNlyfIZzcMshltmq7vcjXp2Ff88XZRDAT/inTuuU9lcVbfja+N2B
	YYUAhY5zIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=Jp0W7PpfFDWhV4aqevn3CcKJ0SyEN6Dbh0xz0PG/2vC3d4BkE4+ZQ5uv
	qb+fCJgoNUtiLdQUj9soRg6qyP5F1dfC7kRdUZc3HQa9D1JY4AxaXZs6QFZiH2fa
	0l/7zBd/MvSuwi77XlwsNwPMEzATTonK6UW5yNe/MziCxr5wVCk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7EFC211E1B;
	Mon, 15 Apr 2013 07:27:00 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0547511E19; Mon, 15 Apr
 2013 07:26:59 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC613AB0-A59D-11E2-8704-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221197>

I've merged a handful more topics to 'next'.

It is likely that I'll be merging kb/status-ignored-optim to
'master' soonish, but as I kept saying this topic touches rather
core part of working tree inspection code, so a fallout from it may
affect not just "status -u<various>" but more destructive "add",
"rm". A final eyeballing of the topic is very much appreciated.

Also I've ejected nd/magic-pathspecs and as/check-ignore topics from
'pu' for now, as the former when taken with jl/submodule-mv were
somehow breaking the tests (I was running the integration run for
'pu' without 5301, 5700, 7001 and 7408 for a few days), and the
latter topic did not play well with kb/status-ignored-optim topic.
We may want to revisit them after having a few more topics graduate
to 'master' first and then ask them to be rebased.

Thanks.
