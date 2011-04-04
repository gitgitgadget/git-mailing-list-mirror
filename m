From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GSoC 2011 : one more interested student.
Date: Mon, 04 Apr 2011 15:31:01 -0700
Message-ID: <7vtyed7ioq.fsf@alter.siamese.dyndns.org>
References: <4D9912F8.60002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: tipecaml@gmail.com
X-From: git-owner@vger.kernel.org Tue Apr 05 00:31:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6sIp-0007ao-9G
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 00:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028Ab1DDWbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 18:31:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab1DDWbN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 18:31:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 782604B34;
	Mon,  4 Apr 2011 18:33:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9KfF0RG9tQ0OyY9/e+k1NmK8+cA=; b=ULDLu/
	qmdiU6uZZEP2J1lVbipGEq5g52Vi/GStNgi6LnnBnAL4JW5WJCrB4/ggflxbof4H
	iKWTGUObrXctjwtwvUeDHnSZeBMpa30V62YP04/MI2i5W+5ONzM8ANvM//VAUgVn
	5KqmetshaaYjN2VsEjTz43m40P3BG/hTsLrvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WNchzg3cuntUWh8LYmG/vLBln30gYB8A
	xQEFssKuCLbquLdjDN3O82hncnB3U1kRb+rJVHcC3g1aq/eY2BFnjIg6+rXZHp5U
	sgC9tQZKbK8wYLSE1FpZ1yUmGs+Bqi+yxYYvwRjiDM8JGiWcaooZ08RZlYgUwC4H
	ZejVxL2tq/4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 474714B31;
	Mon,  4 Apr 2011 18:33:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 36C4D4B30; Mon,  4 Apr 2011
 18:32:55 -0400 (EDT)
In-Reply-To: <4D9912F8.60002@gmail.com> (Cyril Roelandt's message of "Mon, 04
 Apr 2011 02:38:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7F0E0166-5F0B-11E0-B8FA-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170845>

Cyril Roelandt <tipecaml@gmail.com> writes:

> * Complete some libgit2 features
> Implementing a few key features seems like a great way to understand
> the way a VCS works. I would be interesting in working on the diff
> command and on the network related commands (git-push, git-fetch).
>
> * Build a minimal Git client based on libgit2
> It seems to be a quite popular task :) Hacking on this small git
> client would be a nice experience and would help me understanding how
> libgit2 works.

It seems that libgit2 project got GSoC slots out of the git project even
though they didn't apply themselves ;-)  But if you are interested in the
git project proper, there also are ideas on the wiki page.

> * Build in more external commands
> I am wondering why these commands should be rewritten. You know what
> they say : "if it is not broken, do not fix it" :-p Do these commands
> currently have performance issues ?

Performance won't be the primary issue; we would want to lose POSIX shell
and Perl dependency for Windows folks and that is the primary gain from
that part of the project.
