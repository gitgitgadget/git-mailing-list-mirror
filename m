From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/33] Various cleanups around reference packing and peeling
Date: Mon, 22 Apr 2013 15:23:33 -0700
Message-ID: <7vehe2nr16.fsf@alter.siamese.dyndns.org>
References: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 23 00:23:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUP9A-0006By-3z
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 00:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191Ab3DVWXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 18:23:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46952 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259Ab3DVWXf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 18:23:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 266CD18E5A;
	Mon, 22 Apr 2013 22:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I7E6kdvCDrBVC79l/xKYCpuFUjY=; b=iqnPXE
	4ntD2xF+ERiJPq1Ybka0f/bPl16rrBkp8g8b4wxz6fZN/6CYjLYTcBoY1cjcDno2
	QcezPLHKMGOkdizvqXpB+2QRY5M2GTwVRVtJXaAf5RP/IXgk1lbWBRLr/2qH2WUe
	jgH/YazXgJaK/ChdJb7w3gAoNFyU1Mt4Wdo90=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EykQaAmj3vJcc1S9YapnZb/FZBM2E7yi
	1TBx50H7mPcQgXVYdHrAGh7hREIYfksW6sqclo4hs4jdDeElLMxpjYHewFbC13SQ
	AEcBM5PCat4x8ZO6jU0ECDUpfnBFXEIOYPmY2Ljpz+Po9+PBBPAtYaFSw33MmImb
	NxgDLk7CB1k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19A4A18E59;
	Mon, 22 Apr 2013 22:23:35 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 92F0618E58;
	Mon, 22 Apr 2013 22:23:34 +0000 (UTC)
In-Reply-To: <1366660361-21831-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Mon, 22 Apr 2013 21:52:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 45565CBE-AB9B-11E2-BD07-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222118>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> For now I left the sleeps in t3210.  Given that the problem will be
> solved by topic jc/prune-all, building a fancier workaround into this
> test for the old broken --expire behavior seems like a waste of time.
> I propose that the sleeps be removed when this patch series is merged
> with jc/prune-all.

I wouldn't mind to queue this on top of the "prune --expire=all" topic
at all, especially if that makes the tests easier.

Overall looks very cleanly done (I only let my eyes coast over them,
and need another round to read it over).

Thanks.
