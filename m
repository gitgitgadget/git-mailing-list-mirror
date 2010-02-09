From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-push: fix the documentation to explain all the
 status flags
Date: Mon, 08 Feb 2010 17:00:55 -0800
Message-ID: <7vfx5bz0hk.fsf@alter.siamese.dyndns.org>
References: <7vmxzj726j.fsf@alter.siamese.dyndns.org>
 <1265672654-26511-1-git-send-email-larry@elder-gods.org>
 <7veikv2r50.fsf@alter.siamese.dyndns.org>
 <7vaavj2qu1.fsf@alter.siamese.dyndns.org>
 <7vk4un1bku.fsf@alter.siamese.dyndns.org> <20100209005622.GB18023@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 02:01:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeeTZ-00075t-6U
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 02:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529Ab0BIBBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 20:01:07 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51489 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411Ab0BIBBE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 20:01:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E6967983A3;
	Mon,  8 Feb 2010 20:01:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8Gns8HZnFq3SzRrrd8JF9FxSPdQ=; b=Y10Gbt
	begyJW9J+qwW4Kh0rpj6EfcJ1Vjff6Q4St9vFrBrlbvEXuQWaPK6VxccE4zZMUmr
	+pPQPjBrQkJO46AZxk/omLPmBURJD5xUC2OzuJydmQewY33BtsSvDbnTx60E3Zp6
	7WB7bNWhaTqzYMSEKfvKq1JNNju6Qj8PlKRGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TobrNR0hMvr6h/oxZ2AQ/js8Ncz4KRxi
	Bh1l0MI0E1p7Wm/o8AybSBJggV51BHwdjrV14LqrA9T3eEIgekuZX8FXOBz6veRl
	+X6qOlUiexhvrev3L6VaO3BX6RjP5mWEEagJXv5uKVmM4uNQVEKdpKoSFhtgXV4f
	NMXgrQGjG/0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C521E983A1;
	Mon,  8 Feb 2010 20:01:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E7849839E; Mon,  8 Feb
 2010 20:00:56 -0500 (EST)
In-Reply-To: <20100209005622.GB18023@cthulhu> (Larry D'Anna's message of
 "Mon\, 8 Feb 2010 19\:56\:22 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 96CB974A-1516-11DF-A46E-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139347>

Larry D'Anna <larry@elder-gods.org> writes:

>> Subject: git-push: document all the status flags used by --porcelain output 
>
> the flags are used by normal git-push as well

I noticed it after I sent it out and reworded "s/by.*/in the output/".
Thanks for being careful.
