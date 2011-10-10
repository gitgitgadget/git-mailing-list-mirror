From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5/RFC 3/6] gitweb: Add manpage for gitweb
Date: Mon, 10 Oct 2011 11:56:34 -0700
Message-ID: <7vr52kk1jj.fsf@alter.siamese.dyndns.org>
References: <1318098723-12813-1-git-send-email-jnareb@gmail.com>
 <1318098723-12813-4-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 22:57:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDMug-0002jS-DB
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 22:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820Ab1JJU50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 16:57:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59228 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761Ab1JJU5W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 16:57:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DDF347C4;
	Mon, 10 Oct 2011 16:57:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=RixtnFI7hlOeNHYbpn7XBgEqUBM=; b=Ea4fiwvELC83dBAgRU4d
	Y5VipOS6Kfmw6nXNFFQbSx3+csl/iuMZIxRq52Ov9sBqs1ADod2SMRGlKRYed5OE
	7PSnVK68f0GIfmKz5eJM/23UbpLdwHLgWYjLo9eL+X9b+vP4utC71l88tYkjO1q8
	55Vyt71Zy8c0Dv+njalQMDo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=bxD4YpSkW4lkRlUx1r/RpdGjEZ9O0Pk50uAY2PI+nOLtXL
	EY9PTw6gRlSKTPDtv6FTC1WuLMRiLd2wt/G/zR70XaemEiiUfy8PJLSgYi6V+q6e
	L4MNJCArKWYWRL2OXZjofTNEpSfUg2a4j81Y4MPjXrqQ3cLIySTjnDSOAQk3s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3568C47C3;
	Mon, 10 Oct 2011 16:57:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BABE747C2; Mon, 10 Oct 2011
 16:57:21 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 72C2537E-F382-11E0-81D4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183256>

Jakub Narebski <jnareb@gmail.com> writes:

> diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
> new file mode 100644
> index 0000000..2acdb3b
> --- /dev/null
> +++ b/Documentation/gitweb.txt
> @@ -0,0 +1,703 @@
> +gitweb(1)
> +=========
> +
> +NAME
> +----
> +gitweb - Git web interface (web frontend to Git repositories)
> +
> +SYNOPSIS
> +--------
> +To get started with gitweb, run linkgit:git-instaweb[1] from a git repository.
> +This would configure and start your web server, and run web browser pointing to
> +gitweb page.
> +
> +See http://git.kernel.org/?p=git/git.git;a=tree;f=gitweb[] or
> +http://repo.or.cz/w/git.git/tree/HEAD:/gitweb/[] for gitweb source code,
> +browsed using gitweb itself.

This doesn't quite look like a "SYNOPSIS" section. Shouldn't everything
after the first line be at the beginning of "DESCRIPTION"?
