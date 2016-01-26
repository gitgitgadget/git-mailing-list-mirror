From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2016, #04; Wed, 20)
Date: Tue, 26 Jan 2016 14:58:31 -0800
Message-ID: <xmqqwpqw9cdk.fsf@gitster.mtv.corp.google.com>
References: <xmqqk2n33jxq.fsf@gitster.mtv.corp.google.com>
	<C1F7518D-3898-4F53-8BAD-60B5648D4B5B@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 23:58:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOCZJ-0007fo-RV
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 23:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbcAZW6f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 17:58:35 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53296 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750747AbcAZW6d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 17:58:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id ED9A840A1A;
	Tue, 26 Jan 2016 17:58:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GeGzB2Zwmn6FtpdkVhkGpTutXcA=; b=Q9Z3VG
	UDTJ2LSsifK0+K+tNiN7tWrTWsstZuCBiL5HWDbg0yJbzwpfBdZJZwRjyI1IE1e9
	2zByjFtK2pm1jRCYCv7K5H+KrKqKgpQPoth/XuZM8W8v4Pezs4Ks/9+UXI+6ICmY
	SVwaOCCQQPFFTxl8iQ89lz8dRJsCrmH2dGGZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hOWd82V+RwGZ7IvYPcQPi02hbzX3YxeB
	YS/MW57FsOSLt2V3NVCpln+T8Fwg8Orxq0n00HSzT+D+VeI4Y9NiTIn8GqMvI3RO
	vq1NPvvlquGCVjtrnsJ25v+C9K1fbGE1CykM5XgQFGR2pb9s8pew+BlK22gXhPw+
	ZlSksPSIjZg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E3A9F40A19;
	Tue, 26 Jan 2016 17:58:32 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 66B0D40A18;
	Tue, 26 Jan 2016 17:58:32 -0500 (EST)
In-Reply-To: <C1F7518D-3898-4F53-8BAD-60B5648D4B5B@gmail.com> (Lars
	Schneider's message of "Tue, 26 Jan 2016 10:47:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 528A8A44-C480-11E5-9C0E-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284865>

Lars Schneider <larsxschneider@gmail.com> writes:

> Hi Junio,
>
> Did you miss the topic "submodule: extend die message on failed
> checkout with depth argument" or do you not agree with it
> ($gmane/282779)? Stefan Beller reviewed the commits ($gmane/283666
> and $gmane/283851).

No, these three are still in my inbox.

Quite honestly, "test to demonstrate breakage" alone is not all that
interesting to me unless I get a firm impression that somebody is
(or will soon be) working on fixing the breakage--which would make
it worth keeping track of it in my tree, to allow the eventual fix
to be more easily verified and protected from getting broken again.
Also "these look good to me" without much explanation is not much of
a review, and such a comment on a "demonstrate breakage" did not add
to the sense of urgency to the issue, either.

That was why it has been sitting near the bottom of the pile.
