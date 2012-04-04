From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to create empty CENTRAL  git with master / development
 branch ?
Date: Wed, 04 Apr 2012 10:16:25 -0700
Message-ID: <7vhawza046.fsf@alter.siamese.dyndns.org>
References: <20120403162352.67cb165e@shiva.selfip.org>
 <4F7B0F1B.3000304@ira.uka.de>
 <201204040711.q347BTXg025316@VM-MailSafe-02.soltecsis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Holger Hellmuth <hellmuth@ira.uka.de>, git@vger.kernel.org
To: "J. Bakshi" <joydeep.bakshi@infoservices.in>
X-From: git-owner@vger.kernel.org Wed Apr 04 19:16:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFTow-0000JE-2S
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 19:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275Ab2DDRQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 13:16:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47200 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932202Ab2DDRQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 13:16:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C937A6155;
	Wed,  4 Apr 2012 13:16:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pSsVW1xQrJ27A0G1QDE3OPaNf5A=; b=uGny1+
	Fs+Dk1wbZda5kTNRf184XLFsZEV5Ox+lCp5kob0Xb1vR/24U9CLq3i9Nr4p+/0tK
	LmYvSJKbWC0UKv0hqVKKlCtxTvcZjrSQmDLRX4hhO0u8lPsmYNJP+0uFE18Af+2N
	HQW+2fMOSnzWTiK/uHHE+x356M2hVtJ/2IBnY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uG7zoZkzthS5TOEB+Lz/ASK8V0E/fe0h
	bC+cJUHZgiJueh6RBSMGnTYeQf78s+/O4jH5EaZUzeelNojKrPBEAc67UY+R+SOP
	9ZiizYgKgQCDxxKGynpHfm1g30qIb6KGB+YfnSY9dKUAH+jyANbVH56Y3EMdUzs4
	bYAvamvJBsA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFB4D6154;
	Wed,  4 Apr 2012 13:16:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 35BA56153; Wed,  4 Apr 2012
 13:16:27 -0400 (EDT)
In-Reply-To: <201204040711.q347BTXg025316@VM-MailSafe-02.soltecsis.com> (J.
 Bakshi's message of "Wed, 4 Apr 2012 12:41:22 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E98D7FC4-7E79-11E1-8004-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194711>

"J. Bakshi" <joydeep.bakshi@infoservices.in> writes:

> On Tue, 03 Apr 2012 16:54:19 +0200
> Holger Hellmuth <hellmuth@ira.uka.de> wrote:
>
>> > git --bare init project_name.git
>> 
>> you probably meant "git init --bare project_name.git"
>
> Yes right. Sorry for the mistake.

Just on this part.  "git --bare init" is technially more kosher, but it
looks somewhat strange, so "git init" has a special case code to pretend
as if the user said "git --bare init" when "git init --bare" was given.

So both should work fine.
