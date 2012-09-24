From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git pull transfers useless files
Date: Mon, 24 Sep 2012 11:59:26 -0700
Message-ID: <7v3927z1pt.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9BcusbERNW0ZTsuq6xd7onOuggfTxJnf7D_USNv-uhC1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 20:59:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGDsZ-0006Qz-IE
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 20:59:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757675Ab2IXS7a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 14:59:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54282 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757504Ab2IXS73 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 14:59:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05D6A8158;
	Mon, 24 Sep 2012 14:59:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Icqx3AK43MD3P/bhuqVuZIWIlPc=; b=P4xu+1
	csIsZVasqcprMNZXkQ4DVBA6HNK81KN1oxpZ2pTtb/Qmt0MSdQa9qbnJ3UtfK8sM
	A99R9rgv8E8Q4CkNXgBtYWdcgI3O6bYA0sZ5M9dNg8cZO3xacMRNbYYeBIKUwlqJ
	Dc6VLt+7DpocVyvAxiUH5nr5ZOSOoqjxbbXSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eZLxcoeEdTGDo/2ZelgVsOL3Tslxm1aF
	sCn5WDf6DGNoz3x4ANLso2OKZtdCxicd/9pLUMuDh428bqCwubpocLetoPv5Bv2U
	/E088z6axVCYKitvKk5Jo3iWoQ9SsfAKzKMODRiCxVs7OyfzK9W5MLWXCPZ+78ei
	+ALc61dCXU0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6F0E8157;
	Mon, 24 Sep 2012 14:59:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CA8B8156; Mon, 24 Sep 2012
 14:59:28 -0400 (EDT)
In-Reply-To: <CAB9Jk9BcusbERNW0ZTsuq6xd7onOuggfTxJnf7D_USNv-uhC1g@mail.gmail.com> (Angelo
 Borsotti's message of "Mon, 24 Sep 2012 19:51:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F7457512-0679-11E2-816A-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206312>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> When it executes the git pull it spends on my computer some 30 seconds,
> obviously transferring the pdf file, that then it disregards because of the
> merge=binary attribute.
> When a commit contains many binary files, the command spends a lot of
> time needlessly.

That is hardly needless nor useless.

Unless you are saying that having a large pdf file as binary is
useless in your history, that is.  After such a merge or squash
merge, you still need to be able to say "git checkout remote" to
check out their version to inspect, and you did not have that
version of the blob before that "git pull".
