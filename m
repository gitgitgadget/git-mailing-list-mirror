From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document git-svn's first-parent rule
Date: Tue, 17 Nov 2009 10:25:07 -0800
Message-ID: <7vzl6ldn5o.fsf@alter.siamese.dyndns.org>
References: <ea845c8757a629d692bb6cd3827887f0e811c044.1258366486.git.trast@student.ethz.ch> <20091116231455.GA13460@dcvr.yhbt.net> <7vd43his6n.fsf@alter.siamese.dyndns.org> <20091117074208.GA337@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Nov 17 19:25:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NASk6-0005na-Ol
	for gcvg-git-2@lo.gmane.org; Tue, 17 Nov 2009 19:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475AbZKQSZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 13:25:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754064AbZKQSZM
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 13:25:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180AbZKQSZL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 13:25:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7A8FA9F66F;
	Tue, 17 Nov 2009 13:25:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=uG4PjINNigwXSdz4Mo5fXfHmqzs=; b=oWC2/KC+L1CEnTf6i4wT7Ff
	3MBRPahWzL5IDrlkU0ih6P6Q+25VhjHk5T8qgCbxCQBdPtAH3lUhSjrfC1Y+xlLv
	UId2xlwojZrrH2+RWLaeiqt06gGbL4xUmb4epYNhe3Os625A4SSG+vG8lyyj2Az2
	0ldC3/gURwnI7Q9ynnzI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=BS6E3qg18QPqDx4ERdCZmXl4/7bk1v3PGJvPFMtQZ5dFI55Xn
	xcHqhZ5TY0nV9OMaCLEnpSwmKhEb98gNSNvRXTYe0F3AQFku1ldr1sVL2Xdafcqn
	M7OAoabbcDuJKhNCFbCuz+UtM11R/YZUKMb00d0JeOzwSKGjP01kVwAv0A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B1859F66E;
	Tue, 17 Nov 2009 13:25:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 949EC9F66D; Tue, 17 Nov 2009
 13:25:08 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8C7BD07C-D3A6-11DE-9D7C-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133097>

Eric Wong <normalperson@yhbt.net> writes:

>> Thanks; is it a good time to pull from your bogomips repository to get
>> accumulated changes?
>
> Now is, I just pushed to it:
>
> Eric Wong (3):
>       git svn: read global+system config for clone+init
>       git svn: add authorsfile test case for ~/.gitconfig
>       git svn: attempt to create empty dirs on clone+rebase
>
> Thomas Rast (1):
>       Document git-svn's first-parent rule
>
> Toby Allsopp (1):
>       git svn: handle SVN merges from revisions past the tip of the branch
>
> HEAD=ce45a45f24cc7b3ccc7f6ebcd0025559b4421bda

Thanks, pulled.
