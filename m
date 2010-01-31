From: Junio C Hamano <gitster@pobox.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Sat, 30 Jan 2010 23:32:22 -0800
Message-ID: <7vd40qg261.fsf@alter.siamese.dyndns.org>
References: <ron1-2E17EF.12204629012010@news.gmane.org>
 <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com>
 <alpine.DEB.1.00.1001292131330.3749@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jacob Helwig <jacob.helwig@gmail.com>, Ron1 <ron1@flownet.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 31 08:35:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbUL8-0001RS-PV
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 08:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488Ab0AaHcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2010 02:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752442Ab0AaHcf
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jan 2010 02:32:35 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52350 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263Ab0AaHce (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2010 02:32:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3688894B37;
	Sun, 31 Jan 2010 02:32:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kRU/I+bgzbaMKRZyvyfNWbRqaqA=; b=kjv0AY
	H8wkIMU5U8EpxfVsdk4hHcaP3unJ7+j3yInbL/IV/gaQnMb4MFBmXMMT6GXVElKy
	dg0SazpHgh8r3KG/bw5Fz582W/DkKLcznxJKqqWXAKhiAh3Pro9OQcbmD1FdOTkg
	XomsVG8MxreiCah8mGn/jMbUXDHlcZzFeh4bY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e2qCdwBWGju5E+NftCYsZLLnRGP6j4fD
	NVp9RRM+8X2cHPnVnzaioljsEabPk//D1o23uqSNV4e473A4AAzw8Tv2dYBmwJ7z
	Z/yrIbAAESE8pzitXcYtbDEOUgoqFEnufBK/c8cphUOgSr+gj6RousXyPp08KZea
	mOTyp7ACcjY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EC15894B36;
	Sun, 31 Jan 2010 02:32:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E4AD94B35; Sun, 31 Jan
 2010 02:32:23 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1001292131330.3749@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Fri\, 29 Jan 2010 21\:35\:12 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C91C698C-0E3A-11DF-8A5B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138530>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Just as a general hint, I think the best documentation about Git was 
> written by J. Bruce Fields (the user manual) and Scott Chacon (everything 
> that has GitHub written on it, and Git Pro, and much, much more).

The last one is "Pro Git": http://progit.org/book/; highly recommended.

> ... If you
> happen to speak Japanese, Junio's book might help you understand the ideas 
> behind the current Git user interface, too.

Nah, I don't talk about UIs.  I talk more about concepts.
