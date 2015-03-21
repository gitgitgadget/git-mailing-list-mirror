From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2015, #07; Fri, 20)
Date: Fri, 20 Mar 2015 20:20:58 -0700
Message-ID: <xmqqegojc9yd.fsf@gitster.dls.corp.google.com>
References: <xmqqr3sjcopt.fsf@gitster.dls.corp.google.com>
	<423416FC-1048-4D3A-B997-F1F796627242@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 21 04:21:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ9yH-0005lQ-FW
	for gcvg-git-2@plane.gmane.org; Sat, 21 Mar 2015 04:21:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbbCUDVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 23:21:05 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54907 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750977AbbCUDVC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 23:21:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F213426A5;
	Fri, 20 Mar 2015 23:21:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EWRCvRvg/cS7Y4FlohngreFBy2c=; b=LGubOs
	7eQfV98ZzLYgA69BcDs90mwLElS6oVpgy6vr2MTxzkznOq4wHu7Hv1mxOyslSHtJ
	Sd6jvpFNQrlFlyevuu0AYmt4X5aRRGDk3PPxIc1d7C2IWQRrZWK1nrr+WzoMb0If
	3RRriRTRVwG6rh5UYM9q8pSPEyzVIVaFSlReM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EeBKKLtCwbXw4w0QjBMBBW28UgCN3P1o
	O7AZkesSdxP4hdHaorBnr/OfKdJoHYZj1bwv1BlRDuqcOwFlHYj/7h57croNwfK4
	MNE5pxWHI3b1HgAgcYGCRa/UnbMx25AEg9c9L1tXqlHRZzBPrgvQjTcP4u5VSvNi
	nSZA89nV9W8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D6013426A4;
	Fri, 20 Mar 2015 23:21:00 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17ECD426A1;
	Fri, 20 Mar 2015 23:21:00 -0400 (EDT)
In-Reply-To: <423416FC-1048-4D3A-B997-F1F796627242@gmail.com> (Kyle J. McKay's
	message of "Fri, 20 Mar 2015 16:24:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4C01DD96-CF79-11E4-A715-6DD39F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265998>

"Kyle J. McKay" <mackyle@gmail.com> writes:

>> Will cook in 'next'.
>
> Has this been merged to 'next'?  Even fetching
> github.com/gitster/git.git I'm only seeing it in pu:

That was a short-hand for "will merge and cook in 'next'" ;-)

I had an impression that the series may see at least one reroll to
polish it further before it gets ready for 'next', as I only saw
discussions on the tangent (e.g. possible futures) and didn't see
serious reviews of the code that we will actually be using.
