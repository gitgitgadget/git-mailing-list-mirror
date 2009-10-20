From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git rebase using "wrong" commit
Date: Tue, 20 Oct 2009 14:20:43 -0700
Message-ID: <7vws2plq38.fsf@alter.siamese.dyndns.org>
References: <1256037982.7122.31.camel@gridbug.soton.smoothwall.net>
 <200910201521.05526.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Allison <philip.allison@smoothwall.net>,
	<git@vger.kernel.org>, Thomas Adam <thomas.adam@smoothwall.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Oct 20 23:21:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0M8b-0005n3-3C
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 23:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbZJTVUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 17:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbZJTVUv
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 17:20:51 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:32782 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbZJTVUu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 17:20:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 195027FEA3;
	Tue, 20 Oct 2009 17:20:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Zwuiv6O5SzE7u38xbsQf7fxprxk=; b=LMp/2L
	Gv58y/OgeVjdM6eOcJqMEUEJEDuZ4N+epPxykCFmdkCrDeWRIYZ3r91se9/J8J7F
	WYwvC05sF3sOGhK6EOVuF8Yz/oteCUO+a2U5K6Ci4tMBEGw0zCchlT4d/BWs0drn
	t/ybhqZoP5CGztt1T2Nay+/65VNhmxn+9TQyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m251MrCLljgGFfOudPXKHEY5gts5FoOq
	HJ8tLVSMcyWZ99dfESZ6DJfaCM6TJvEsvDiRyKclmfQ6akXwWaUe7juu0T9ddNVN
	r1NPh7qGZhTIPKIiuA0rxNyQOHRTPKAolf+GmQldPmeEbOiiQz6klJNBCKCOpsTN
	GJoFa4ucRA4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C8B737FE9F;
	Tue, 20 Oct 2009 17:20:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 44CE67FE9C; Tue, 20 Oct 2009
 17:20:44 -0400 (EDT)
In-Reply-To: <200910201521.05526.trast@student.ethz.ch> (Thomas Rast's
 message of "Tue\, 20 Oct 2009 15\:21\:04 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7129BCCE-BDBE-11DE-8D28-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130852>

Thomas Rast <trast@student.ethz.ch> writes:

> Note that there is no real reason to rebase continually unless you
> want to kick out flawed topics or old versions of branches.  For
> example, git.git only rebases 'next' immediately after a release.
> Furthermore, even if you go for the 'pu' model which is rebuilt all
> the time, you can automate this with a script.  There is one in the
> 'todo' branch of git.git, called PU.
>
> (I myself just use a list of topics I want merged, and a simple 'git
> merge $topic' loop.)

I do not use PU nor RB from todo these days, by the way.  I instead
rebuild my branches with Reintegrate (also from todo).
