From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [msysGit] [PATCH] git-gui: use themed tk widgets with Tk 8.5
Date: Sun, 20 Dec 2009 13:05:58 -0800
Message-ID: <7vskb59wzt.fsf@alter.siamese.dyndns.org>
References: <87my1ev4gi.fsf@users.sourceforge.net>
 <alpine.DEB.1.00.0912201412420.4985@pacific.mpi-cbg.de>
 <a5b261830912200723s131f0b93w2f5ab94f19faf86a@mail.gmail.com>
 <7vws0ha2mt.fsf@alter.siamese.dyndns.org>
 <a5b261830912201225q7d596b55qb54676922301954e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	msysgit@googlegroups.com
To: Pat Thoyts <patthoyts@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Dec 20 22:06:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMSyr-0004Gg-AA
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 22:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754582AbZLTVGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Dec 2009 16:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754526AbZLTVGQ
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Dec 2009 16:06:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63263 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753167AbZLTVGP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Dec 2009 16:06:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7C470A88AD;
	Sun, 20 Dec 2009 16:06:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CZTT53b+uqd5vtnRUImgZ3kVoMU=; b=vVbsEW
	Mw5jNFmFMjBf0SrbmMKlkDn6UifurvViTepfZBKVs/w0hFLgXGqNsHdj5M+ZwDX1
	xBs2PHRdJQ3ZlA0GUfYsnEm7brjWHE2bVz2QaFIfZI5Y3m1OsOPD94A37UEYufn6
	FDcC7cbMIxHtzWxBeq/L3XnDT6qPgP97DtVvY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UiD7A7gPwqJb6A08bamn/n22ZG+Tj1hm
	oedO0l76ePp0EjHAEYC3Tx9AeFO7lkjYV5FyqL/PH5pqbzNyleyrLiGXgz0k1cAm
	hjATx4M4Iat2/O50p+P5/7UR3001YWctnUhw78gn8KS6RBTUDniaXF5j9UOGrSyS
	n9Kgvdn2gC0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 20F70A88AC;
	Sun, 20 Dec 2009 16:06:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 68B74A88AB; Sun, 20 Dec 2009
 16:06:00 -0500 (EST)
In-Reply-To: <a5b261830912201225q7d596b55qb54676922301954e@mail.gmail.com>
 (Pat Thoyts's message of "Sun\, 20 Dec 2009 20\:25\:02 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7E3F4808-EDAB-11DE-8998-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135534>

Pat Thoyts <patthoyts@googlemail.com> writes:

> 2009/12/20 Junio C Hamano <gitster@pobox.com>:
>>
>> On X, does the "default: thin borders, kind of windows98ish" look very
>> different from the non-themed classic Tk style?
>>
>
> Here is a big set of screenshots then:

Which is probably very helpful to others.  Thanks.

On the other hand, if you wanted to give me just a quick answer, you
simply could have said "The default X11 theme looks like the good old
classic Tk that draws diamond shaped radio-buttons". (which is the
impression I got after running the current git-gui installation on my box
and comparing it with your "Tk 8.5 themed with unix default").
