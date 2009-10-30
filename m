From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Update packfile transfer protocol documentation
Date: Fri, 30 Oct 2009 15:07:00 -0700
Message-ID: <7vtyxgh6yj.fsf@alter.siamese.dyndns.org>
References: <d411cc4a0910291035m45ba0a8egd8a991acfbf6d5a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 23:07:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3zcw-0007wc-AX
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 23:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757538AbZJ3WHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 18:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757535AbZJ3WHI
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 18:07:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757532AbZJ3WHG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 18:07:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C5A1F8BEE4;
	Fri, 30 Oct 2009 18:07:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EFu3Rn89Hg9BbpmMPITlmisTztg=; b=WUPPjE
	4yZlSNm5I5gAcAq+/sV7NQ7TnP8bNQB0fq26qeL5pgoxhADIDBMBujwTfmRVdQjB
	/1nA4eOYqYSseMQy3xxTbdRVwNEFVjXx1bwg7S/jO6WorlTQr4GAbWKGTQ6QhaOw
	M44m1NXPpITz8OLLGx1rdXwOp0o4YXbEX3DMU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UIOI6aCXG+NBLT3kNRWVKWIgjqOyvegq
	xL/GaspYiPT2nP2INmYzlLvGNhm1bLNkJMh/OfmsFs3sjw/dPqYEg7YtDAJ69MJ5
	eGAnY821ru+6i+5F3VxMD9pzSeJ5mT8uomQth1Bzobt9wRvzNWIgmzJ1SCRCHtw/
	TwjOOPH2hqE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 92DEF8BEE0;
	Fri, 30 Oct 2009 18:07:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3113F8BEDE; Fri, 30 Oct 2009
 18:07:01 -0400 (EDT)
In-Reply-To: <d411cc4a0910291035m45ba0a8egd8a991acfbf6d5a7@mail.gmail.com>
 (Scott Chacon's message of "Thu\, 29 Oct 2009 10\:35\:22 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8FCAA03C-C5A0-11DE-9DEB-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131763>

Scott Chacon <schacon@gmail.com> writes:

> The technical documentation for the packfile protocol is both sparse and
> incorrect.  This documents the fetch-pack/upload-pack and send-pack/
> receive-pack protocols much more fully.

Thanks for starting this.  There were a few little things I noticed
(e.g. SHA when it should say SHA-1 or "object name") but we can fix them
up in-tree.
