From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problems with git am
Date: Mon, 26 Oct 2009 19:31:34 -0700
Message-ID: <7veiopbm9l.fsf@alter.siamese.dyndns.org>
References: <59976.134.134.139.70.1256602329.squirrel@clueserver.org>
 <7vvdi1bqv8.fsf@alter.siamese.dyndns.org>
 <Pine.LNX.4.64.0910261836570.15106@blackbox.fnordora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: alan <alan@clueserver.org>
X-From: git-owner@vger.kernel.org Tue Oct 27 03:31:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2bqk-0002zU-L1
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 03:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509AbZJ0Cbn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 22:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753413AbZJ0Cbn
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 22:31:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54133 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbZJ0Cbm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 22:31:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8287987502;
	Mon, 26 Oct 2009 22:31:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/fxq39aKiUCS7JvxPh4vibcDSN8=; b=fBp9fd
	klBoEWlhpxkYJ+x0/bXnK3427On0ciC5UFshi5eB0yyazllDmufZGIZHMvJtmez3
	1c6+dP/nWqvIWrye9b0lHlQI1F6irZVCuKDcsBi95ICTV+OOIVbTT+qVz0bVq2Pu
	/TPbwtNDUoDC2vsyu3ZFe3phRl1RgU0+QX0lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f8nMEVTpuV/bYa477ISmQUKwu26ixAiT
	4HIx6ii71h9FXL6LQEH/kwkdAx4c3FqDca+l+ng9r2daHJU5cWZN/lws7PFGrohC
	15TmqOZKDAVVohgUth5dBIKvU8NL8VrFmT2U19UZpUvLwIDSusXqCBr6pZLKObLl
	COeX61FRyME=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6317A874FE;
	Mon, 26 Oct 2009 22:31:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A7CBF874FB; Mon, 26 Oct 2009
 22:31:36 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0910261836570.15106@blackbox.fnordora.org>
 (alan@clueserver.org's message of "Mon\, 26 Oct 2009 18\:43\:24 -0700
 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DC4335F8-C2A0-11DE-99CD-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131304>

alan <alan@clueserver.org> writes:

> The other question is what the proper behaviour when git-am in unable
> to process a patch.  Under git 1.6.0, it exits with a non-zero error
> code. Under the current git in the git repo it issues and error and
> exits with a non-error exit code.

Hmph, that sounds like a recent regression to me.  I'll try to find time
to look into it myself sometime tonight but no promises.
