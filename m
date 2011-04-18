From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remove noise and inaccuracies from git-svn docs
Date: Mon, 18 Apr 2011 10:55:18 -0700
Message-ID: <7v39lfa1h5.fsf@alter.siamese.dyndns.org>
References: <1303138000-27807-1-git-send-email-stsp@stsp.name>
 <vpqhb9vplu4.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Sperling <stsp@stsp.name>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 18 19:55:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBsfg-0005Ab-SU
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 19:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756169Ab1DRRzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 13:55:32 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54022 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235Ab1DRRzb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 13:55:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 78D3450C2;
	Mon, 18 Apr 2011 13:57:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WPWmXQ6ij4aAH+3qSq3PLV+DE58=; b=kKCnom
	2i4ErRttEu/jU7FoWqJpzlFQMj5kcE/4WxFaloO8UVoUXJMLotbxtf2qVy9Hq+Sj
	jHmQpiIOu+RCmg/dFNSS2NXvi0a/ARLJuodk6TTSlzqT7nq1+K8VismD6XulrRiI
	uKGBaZ56I4eC3ZEpCGe4Nj3OfSsczwZJ8bquo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nmNM2ZmZAuOb21LmA+I74VQ89uwjKW2i
	AJmIAkF8QAYWGcLCMAEcZaf/S1qGy4LcKMTwJ6l/x6ubXC8vK/gQY2kgMrvPiNDb
	xOSTNm7l/BEeSaRnNospEcSdcU17Px4YDvnr05zYBgL6d30WM3CdD+x+O0s9c+VN
	XAOgebRTHHc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4A04250C1;
	Mon, 18 Apr 2011 13:57:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3D8AD50BC; Mon, 18 Apr 2011
 13:57:18 -0400 (EDT)
In-Reply-To: <vpqhb9vplu4.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 18 Apr 2011 18:26:27 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5007FFE0-69E5-11E0-8E05-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171750>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Stefan Sperling <stsp@stsp.name> writes:
>
>> -DESIGN PHILOSOPHY
>> ------------------
>> -Merge tracking in Subversion is lacking and doing branched development
>> -with Subversion can be cumbersome as a result.  While 'git svn' can
>> track
>
> Agreed (this and the rest of the patch). Users reading git-svn's doc
> don't want a dissertation about how bad SVN is, and if they do, they can
> read whygitisbetterthanx ;-)

I agree the change in the patch is good.  It needs to be signed-off,
though.
