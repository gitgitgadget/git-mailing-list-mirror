From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make feed title valid utf8
Date: Tue, 29 Nov 2011 12:11:32 -0800
Message-ID: <7vfwh6sn7v.fsf@alter.siamese.dyndns.org>
References: <CAKD0UuxFVtCRT+hqO5vkDRanaX3Gvwf9MAFqNUwAiFA+wEwxXg@mail.gmail.com>
 <m38vmylnfu.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?J=C3=BCrgen?= Kreileder <jk@blackdown.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 21:11:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVU1k-0004M6-Jl
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 21:11:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756495Ab1K2ULg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 15:11:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57958 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756425Ab1K2ULf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 15:11:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E66A76C82;
	Tue, 29 Nov 2011 15:11:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OVLJJ5olarWYijl5le1YbxZub9I=; b=d7nkJK
	k2Ou7+dcru90rhwWg6ZBjh1XJwCBqsXqui86zF7blkT+AFMu7NV0gcrp4Y+5wq42
	Hk5uENIDCfmC03JL4E5HsaADEGZ703BCSfVZ7dverewO/rbkQeO1Tvmp5scPc+PW
	+ZSDWRD2LsM/iB8TTxUSs3dOO50fmZC2XDlmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hTLza7NQGhzT1Rl9G+WSZ8tdRG3g17/i
	IS9OEpIFElLjnsQoRtfgqm6XBetKR/9kdzUqJzGql/c3YrINZxZ1C/n4PhhNmw3E
	zT4GkAM47fQx4uvfXsZR2LMzVTSWzg9QnRfBAIMI1EiIul85rQXH84wNhQHAI5KP
	cmyoSjSmf6E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD6F76C81;
	Tue, 29 Nov 2011 15:11:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5C72B6C80; Tue, 29 Nov 2011
 15:11:34 -0500 (EST)
In-Reply-To: <m38vmylnfu.fsf@localhost.localdomain> (Jakub Narebski's message
 of "Tue, 29 Nov 2011 11:48:39 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 55D80D4C-1AC6-11E1-952E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186080>

Thanks for patches and reviews.

I am not keeping track of what is acked unconditionally, what is acked
with reservation i.e. "with this tweak on top", and what is rejected with
suggestion of an alternative, though. I hope I can expect to see a series
that is finished between you two to be resent for application after 1.7.8
ships.
