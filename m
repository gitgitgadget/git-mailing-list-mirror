From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool-lib: call vim in readonly mode for diffs
Date: Fri, 25 Feb 2011 12:01:15 -0800
Message-ID: <7v62s7anp0.fsf@alter.siamese.dyndns.org>
References: <20110224203412.29b732b9@glyph>
 <227c6e4e11ce964a6e6898afb422d424d46a7b50.1298626494.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, netuse@lavabit.com
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 25 21:01:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt3r2-0003hF-TC
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 21:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932897Ab1BYUB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 15:01:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44857 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932648Ab1BYUB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 15:01:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 95E1C4DF2;
	Fri, 25 Feb 2011 15:02:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dnmY4UtrTiupRf78PniCY4Z5mgI=; b=mO70Ji
	WbfRUpu7tZ3WTTI0cBlhF/Ra3ij7ARmhk1sXwu3J8ixvu5nVYLgF3UZY8vTGF1p1
	7c3zZSiREt0GjgAYMyWleay8+PMNVX5ggqdO5XLGeyXSvhiO3LwQ2iX/v80FWUdp
	wvE447Ud0mwqfJLGH/F5BgGGTzdYLQKkJHfTs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X9xccSMMSao6eeBqiJF3y19k1u/A6rHr
	b0TWYOz01rhTV+hbpPfSbNzRgT3hcNwaXwgR7kvvinvhnPzlw0GuKl0TdpUf2jxf
	h5b+xZIE1Fww353Az67BsQt3eB9hi5L5i7qlj61GtS42xJ+etgfFAmD757llh7sW
	jtCqOUCJxw0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6367C4DEE;
	Fri, 25 Feb 2011 15:02:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BFA4F4DEB; Fri, 25 Feb 2011
 15:02:32 -0500 (EST)
In-Reply-To: <227c6e4e11ce964a6e6898afb422d424d46a7b50.1298626494.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Fri\, 25 Feb 2011 10\:36\:39 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 31D6150A-411A-11E0-8C03-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167932>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> When [g]vimdiff is called for files which are opened already, the editor
> complains about the existing swap file. But we do not want to write
> anything when called from difftool. So, make difftool use "-R" for the
> vim family.

Makes sense.  Maint-worthy?

Will queue, thanks.
