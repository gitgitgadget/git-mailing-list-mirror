From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] tests: remove no-op full-svn-test target
Date: Mon, 22 Feb 2016 22:31:33 -0800
Message-ID: <xmqqvb5g2b0a.fsf@gitster.mtv.corp.google.com>
References: <20160222030814.GA18817@dcvr.yhbt.net>
	<56CB30F3.40908@f2.dion.ne.jp> <20160223062659.GA7630@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 07:31:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY6VZ-0002XW-R8
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 07:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757499AbcBWGbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 01:31:38 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757477AbcBWGbg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 01:31:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E17F13DCE0;
	Tue, 23 Feb 2016 01:31:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1TzUAJt8Wy1fLmX5tDuBwhtGsNg=; b=br34Sx
	rDhq9eRSy4lrSBF0VnoiTsDmxIvdepuGu5FshoxFxHon2DD2Fjw8ea4EJQ+q52hl
	QNliOpUChzVrHsD06/0UizpWv2GpxdMxlQSQBRDciz83kWuudch6Z05O5xSAL7qA
	oKgWJbT+bKWtZP9DMqoGm8e7SBY1HtyHlyoEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YotlAW0Pc3bdgujD00ZXFAdRUBYWKTQ0
	qyWSUxZ8qCy4gOB3fOKadlEaBkp8m5RkpJh8xrHuwBwB2oMnR+lE1jLyCFZKaeKZ
	QmR2W5VfbJyA9U1PhHhfpmvyK2LnvhRrvnWvaFDPcv3cMHDvY3dSMqK+wpfh06EK
	RloxS1wpDuU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D906A3DCDF;
	Tue, 23 Feb 2016 01:31:34 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5003D3DCDE;
	Tue, 23 Feb 2016 01:31:34 -0500 (EST)
In-Reply-To: <20160223062659.GA7630@dcvr.yhbt.net> (Eric Wong's message of
	"Tue, 23 Feb 2016 06:26:59 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 155FBDCE-D9F7-11E5-847D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287023>

Eric Wong <normalperson@yhbt.net> writes:

> git-svn has not supported GIT_SVN_NO_OPTIMIZE_COMMITS for
> the "set-tree" sub-command in 9 years since commit 490f49ea5899
> ("git-svn: remove optimized commit stuff for set-tree").
>
> So remove this target and TSVN variable to avoid confusion.
>
> ref: http://mid.gmane.org/56C9B7B7.7030406@f2.dion.ne.jp
>
> Helped-by: Kazutoshi Satoda <k_satoda@f2.dion.ne.jp>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>   v2: remove TSVN, too.

Thanks, both.  Will apply directly on 'master'.
