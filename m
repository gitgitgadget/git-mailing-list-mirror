From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv7.3 1/4 (bugfix)] gitweb: Prepare for splitting gitweb
Date: Thu, 02 Dec 2010 09:37:21 -0800
Message-ID: <7vtyiwrs8e.fsf@alter.siamese.dyndns.org>
References: <201010311021.55917.jnareb@gmail.com>
 <201011130035.50229.jnareb@gmail.com> <201011130041.22918.jnareb@gmail.com>
 <201012021117.16183.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 18:37:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POD6N-0000qQ-EI
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 18:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757921Ab0LBRhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 12:37:40 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50316 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757911Ab0LBRhi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 12:37:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 41544398D;
	Thu,  2 Dec 2010 12:37:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hCjzCoSxXdU4H21+bAVoZc3YYkM=; b=u8VESo
	dhimFrqijV42Arw0ghxquGzAuQOIOPSZCXwztrzTdmYLexzwFB9wcE58btU24OAu
	bEwZ7mgzJdROfQKOcHBk4Yg3cxecJlMoOfByotAPSLCDrloc1caZzpJVEnEdzdl1
	AMMcAA3oci/n25KKFqYSFqEPMRRjOfdaNwk74=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uFvJL4iTYMmZa+7jfIgYZDNBcFH+Gvli
	UQDCN23QDLjh0SGiSIHZ+JY6neKYV9RtPacpJKScvVEmzYblEs6i4poi1N7SNG5W
	/OZYWP1jUeQncwAuATcNnFDy9DMdp0oc9Ul2E8p5TTGLUeyapUzed/DDOQa/sQY0
	UEMlzLC5AzI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D1504397A;
	Thu,  2 Dec 2010 12:37:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0C8D53969; Thu,  2 Dec 2010
 12:37:43 -0500 (EST)
In-Reply-To: <201012021117.16183.jnareb@gmail.com> (Jakub Narebski's message
 of "Thu\, 2 Dec 2010 11\:17\:14 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E335F3EC-FE3A-11DF-9751-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162713>

Hmm, how did you find the issue, and more importantly, how did I or other
people who saw this patch so easily fail to notice it?

FWIW, I do run "make install" from the toplevel as part of my pre-push
test, so I _should_ have noticed it.

Ah, I don't run the install step for a revision that does not pass its
selftest, so I haven't run "make install" on 'pu' for some time.  That may
explain it.

Anyway thanks for a fixup.
