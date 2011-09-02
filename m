From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL] various git-svn updates
Date: Fri, 02 Sep 2011 12:43:12 -0700
Message-ID: <7vmxem20j3.fsf@alter.siamese.dyndns.org>
References: <20110901220006.GA18321@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Jacobs <bjacobs@woti.com>, Sam Vilain <sam@vilain.net>,
	H Krishnan <hetchkay@gmail.com>, Ray Chen <rchen@cs.umd.edu>,
	git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Sep 02 21:43:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzZe5-0004sr-PZ
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 21:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755159Ab1IBTnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Sep 2011 15:43:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61484 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755031Ab1IBTnP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 15:43:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 099BC5F45;
	Fri,  2 Sep 2011 15:43:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3+byQzpaEAl20jEfKDNeU4V5uUs=; b=k/c8Ci
	Kg+xJwI7AKzGKbeNqcTGiwix1cmEP8IrNY2y+v8YWYIQh3RQnrV9cAnnUYDJllZa
	u1ZstET9Npvm3jdpVErsHRECE9XyCvzxs4ZmNCXrpJg0HrosXje7cbuQGkPh4Lfp
	R6KB5AZfYaHpVK2gjeFXsW/SfNlXYQ4vmByhg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lZ3BRQQvGsPlTY29okrSKad5X+qdS8vn
	cGPAvoqQ/tf6/i5pmqyk/nHu7OmXp83VNltNg4mF8CGNB+lH0NVgS6n/VSr0oEG1
	7E7Rwh5T4aPPKxDByEy5VWN7OuM2FE9fSZY6BOuXEFulftjyJeGVkXHu0GjJTa+0
	omjYXMBci8M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00B015F44;
	Fri,  2 Sep 2011 15:43:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D8445F43; Fri,  2 Sep 2011
 15:43:13 -0400 (EDT)
In-Reply-To: <20110901220006.GA18321@dcvr.yhbt.net> (Eric Wong's message of
 "Thu, 1 Sep 2011 22:00:06 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBBD04EC-D59B-11E0-9728-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180635>

Eric Wong <normalperson@yhbt.net> writes:

> Please pull from "master" on git://bogomips.org/git-svn.git
>
>   Bryan Jacobs (1):
>         git-svn: Teach dcommit --mergeinfo to handle multiple lines
>
>   Eric Wong (1):
>         git-svn: fix fetch with moved path when using rewriteRoot
>
>   Ray Chen (1):
>         git-svn: New flag to emulate empty directories
>
> commit 85f022e9c124ffeda31a50cab878e1418d694d87 (fix fetch with moved path)
> is also suitable for cherry-picking into maint.  All tests pass on
> Debian 6.0 (x86_64).

Thanks, pulled but not yet pushed out.
