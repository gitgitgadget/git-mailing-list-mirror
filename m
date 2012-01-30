From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] completion: cleanup __gitcomp*
Date: Mon, 30 Jan 2012 13:25:59 -0800
Message-ID: <7vliooanmg.fsf@alter.siamese.dyndns.org>
References: <1327944197-6379-1-git-send-email-felipec@infradead.org>
 <1327944197-6379-4-git-send-email-felipec@infradead.org>
 <20120130175004.GG10618@burratino> <7vpqe1au7f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Ted Pavlic <ted@tedpavlic.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Felipe Contreras <felipec@infradead.org>
X-From: git-owner@vger.kernel.org Mon Jan 30 22:26:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrykO-0006Oi-1z
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 22:26:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586Ab2A3V0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 16:26:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58602 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753371Ab2A3V0C (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 16:26:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2AB27BCF;
	Mon, 30 Jan 2012 16:26:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=U0Ui9Bb5tNddbtE8Z5HjwOSgyHA=; b=T6yNdj
	AQzH7My3bY1Ba/Ec3mEw1fnJ6F+dTf+o3fS+qdupCYtDvDhfGXx4+Hh9k7cukdba
	U2sjg6R8pQ7lNBBsWjQDfwlToSA53drO9vAcKTdQe+8S9C2HM1yfpyUtW4XsB+Ni
	/QFswHlDES28bKe5JkJqyU/KBLLaaLhqAmzyo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hy77KTl4Cuj1F/2ueUGCw4G7fIwxSkYg
	XGZhioGdvBBbkSh3p9cb/uNzR98S6Hh0jBKvQFohLG4aFsn/CXt/TlFh/mP0gj7w
	G7YmiWg2gLU0ns16H0QqcoXTDBFDpPhttXhGUZ3nFUKEVK/gci367Ie3Ga6+Y2Tc
	JejeK4cWYw8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A55AF7BCE;
	Mon, 30 Jan 2012 16:26:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32E9D7BCD; Mon, 30 Jan 2012
 16:26:01 -0500 (EST)
In-Reply-To: <7vpqe1au7f.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 30 Jan 2012 11:03:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 01EA5692-4B89-11E1-8304-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189429>

I managed to pick up 1 & 2:

 1. be nicer with zsh (aka avoid default value assignment on : true
    command);

 2. simplify __git_remotes (aka use ls -1 instead of rolling a loop to do
    that ourselves).

But I do not see your patch for 3 & 4 either on gmane archive nor in my
mailbox (via vger, not direct delivery from you to me). The threads for
these two patches both begin with Jonathan's review for me.

Care to resend 3 & 4?

Thanks.
