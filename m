From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/12] Support columinized output in
 tag/branch/ls-files/grep
Date: Mon, 08 Mar 2010 18:14:43 -0800
Message-ID: <7vvdd6ckbw.fsf@alter.siamese.dyndns.org>
References: <1267963785-473-1-git-send-email-pclouds@gmail.com>
 <4B9504C9.5000703@lsrfire.ath.cx> <7vmxyijts1.fsf@alter.siamese.dyndns.org>
 <fcaeb9bf1003081806y13da4a1au80a925e9febcd8ca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 09 13:35:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoyTu-0001Do-JM
	for gcvg-git-2@lo.gmane.org; Tue, 09 Mar 2010 13:24:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093Ab0CICOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Mar 2010 21:14:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59840 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756570Ab0CICOx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Mar 2010 21:14:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F178A0599;
	Mon,  8 Mar 2010 21:14:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6VQJLz+xUDxPy5YeZs0OM5npL1c=; b=C/aZqe
	7/39+kdXmGVPfqz9Ley7Q3P2qVxfga8arrWIHG9BY+dqWh/nBqfnTGDrZeFUSU+X
	3y0F5Tmnr234EndzvqjXyz4Fe9wdStaquHv6zZSf41xPe3sgN3BcQT0axnPh7ECN
	cvYscL6N7ZhNygRunlj2BVyfpYnba3zbATXEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QxuIpASKZDbCoRzFj6cLCRP7ALJ1sLIX
	rn9Vp/aHtaqMMfxUbnFP5uwCre5JXBefruDCY0Y7KWPyLwW8WrW1nXaZ0u8iw3KK
	3uFOhh3UoyFNk3N+F4Z98sKvu09/c2F+m62ZVPQGBHwuXChGHUwY0wb8V7+sYfvT
	JyM9sOniNpA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6A489A0594;
	Mon,  8 Mar 2010 21:14:48 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A5BA6A0591; Mon,  8 Mar
 2010 21:14:44 -0500 (EST)
In-Reply-To: <fcaeb9bf1003081806y13da4a1au80a925e9febcd8ca@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Tue\, 9 Mar 2010 09\:06\:30 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 896E8474-2B21-11DF-A154-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141817>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Hmm.. ls-files does not take core.columns into account. Command line
> parameter --columns is the only way to turn column layout on in
> ls-files.

Ok, then that's good.

By the way, I didn't single out ls-files as something special that must be
kept (i.e. "it is ok to touch any other things as long as you never
touched ls-files" is not what I meant) but mentioned it as an example of
plumbing.
