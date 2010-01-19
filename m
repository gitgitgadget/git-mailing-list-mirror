From: Junio C Hamano <gitster@pobox.com>
Subject: Re: why is tagger header optional?
Date: Mon, 18 Jan 2010 22:31:32 -0800
Message-ID: <7vk4vebo6z.fsf@alter.siamese.dyndns.org>
References: <20100119060946.GA23212@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 19 07:31:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX7cw-0002C3-HW
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 07:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930Ab0ASGbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 01:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751819Ab0ASGbm
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 01:31:42 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36907 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab0ASGbm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 01:31:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 21102906DE;
	Tue, 19 Jan 2010 01:31:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=msYwP5xBaJ4qxwN7c5HloTLU2I0=; b=ZEx9Ct
	PCPKjIkLHgvbxOsI1lQXTWt2DxiPcut5zJs5wfBuzOJw0X8y8AUWAJudQEKkii/V
	Ff+lZlHVD9aOODN0QhaLc26EiOfYFZ0SjlKaKp4ygJi42/HIyHfxqs0qx076TtvG
	BZe2eGSdQ3P6hZ4iHUBIxG85looGSVcEUs/s4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TjJTHdZkDi95l/EToe4JN/I5pSSWkoT5
	NlCYekLG9UchaReP7Iw3TUD0IFvx5sfr5xPdjW24oqH4+CpqBXj/ZvjehQQN3Qpa
	m6SHE6HJrcv53ndxMsAgu2jHwC3wHRQVAcBgAN/p8jDiChpzJRyvexOBHRUPmUn5
	MssCSXSjlHw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EE1DC906DC;
	Tue, 19 Jan 2010 01:31:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A177906D9; Tue, 19 Jan
 2010 01:31:34 -0500 (EST)
In-Reply-To: <20100119060946.GA23212@spearce.org> (Shawn O. Pearce's message
 of "Mon\, 18 Jan 2010 22\:09\:46 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4B654420-04C4-11DF-98CB-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137430>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> So why is it legal to omit the tagger header from a tag?
>
> E.g. the Linux kernel tag v2.6.12 has no tagger header:

We didn't.add tagger line until c818566 ([PATCH] Update tags to record who
made them, 2005-07-14), which is v0.99.1~9

Linux 2.6.12 is a lot older than that.  v2.6.13-rc4 in late July is the
first one with tagger.
