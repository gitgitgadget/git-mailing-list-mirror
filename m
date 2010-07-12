From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git gui blame: Show History Context [still] broken since
 29e5573d
Date: Mon, 12 Jul 2010 13:55:17 -0700
Message-ID: <7vtyo4a096.fsf@alter.siamese.dyndns.org>
References: <vpqy6e4v1h0.fsf@bauges.imag.fr>
 <87sk3qrjk3.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Mon Jul 12 22:56:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYQ3T-000162-JH
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 22:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965Ab0GLUzh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 16:55:37 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47179 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155Ab0GLUzc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 16:55:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D6FD7C4A58;
	Mon, 12 Jul 2010 16:55:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p3il6obgu7rAxoAqCSKdL9hbdig=; b=PCQPiW
	Djwte/gVrZsrBW1d6uTK9iGchytEkJFIdfWW8/6EXRj5Br9QTI1G5gKBh5PyHGrl
	7qG+XY0BtRzRl/eRNeXrkQLneryM6CoiKAvzZESc/slTbPU2BpfcJ3CkPoneyEfb
	Tu4SptKEYpEqNfvEMdecRwgtL6Z+IOgXTLLw0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gvnvFavbe48iAn9BrIVV//wXBGG1gbzw
	GWs/MzkwMnUngOpCIzBaAUWa2Cf77oE8dZ+uLVH2W28rNjrY2vbiNy4fZEIv2rAg
	H1lckHzm3v2VZFfh41BPVXHOHHk/73zvNibTMaqszDmoA2jWEbq90WHh3a5uYZCH
	lf3zzHlJWtw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EC68C4A57;
	Mon, 12 Jul 2010 16:55:24 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8159DC4A52; Mon, 12 Jul
 2010 16:55:19 -0400 (EDT)
In-Reply-To: <87sk3qrjk3.fsf@fox.patthoyts.tk> (Pat Thoyts's message of
 "Sun\, 11 Jul 2010 00\:41\:48 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CAF02018-8DF7-11DF-AD4C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150845>

Pat Thoyts <patthoyts@users.sourceforge.net> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>>Hi,
>>
>>I reported this bug a while ago:
>>
>>http://kerneltrap.org/mailarchive/git/2010/2/22/24038
>>
>>In short, the "Show history context" item of the context menu of "git
>>gui blame" is broken since february. Two patches were proposed:
>>
>>http://thread.gmane.org/gmane.comp.version-control.git/140688
>>http://thread.gmane.org/gmane.comp.version-control.git/140288
>>
>>But I've just noticed that none of theme were applied.
>
> Checking this it seems you are correct. This has been fixed for
> msysGit with the above patch included there but is missing from
> git-gui itself and hence missing from core git.

Can we resolve this before 1.7.2 final?

Shawn, I see 9c898a1 (git-gui: check whether systems nice command works or
disable it, 2010-02-07) on your 'maint' that is not in mine (and a merge
of that commit on your 'master'), but neither of these.
