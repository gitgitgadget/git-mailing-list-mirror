From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Ensimag students working on textconv for blame
Date: Fri, 28 May 2010 16:55:53 -0700
Message-ID: <7v63277f92.fsf@alter.siamese.dyndns.org>
References: <AANLkTimmR6yLLmCy_QvonjjgAp9F012DQb9TYCMiQ0yp@mail.gmail.com>
 <AANLkTinHLoYMgBawxmXpH5XSyJDb_743HEpfCmfqoRHu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?utf-8?Q?Cl=C3=A9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Sat May 29 01:56:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OI9Pv-00040V-Ld
	for gcvg-git-2@lo.gmane.org; Sat, 29 May 2010 01:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514Ab0E1X4L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 May 2010 19:56:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40487 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab0E1X4I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 May 2010 19:56:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E3F80B702F;
	Fri, 28 May 2010 19:56:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=72tWtJVlnYTXoXbr2JPDOSSHX3Q=; b=mM1xDH
	PHAgLycTm4t+sctWOT0z/qHKSzLr0lkbZYxO2cOMUpxwH4qWtgWZ1ABRcH/6x1jt
	IaA5MVvH75lJQuohlYpbyGsw5qLhpt/dk0OF1rfvCJKgPrwHO8mHVdXWT6gElhZs
	iu6X9Ig9qyw3K/m5WzA0dp35PbyAwDG4525zE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bxo9JU/xb0UA6fdblHw8f/jeOO31ynuf
	MMZO5v9lu3YG/L/Tzqe7T239/vgbyFJ2p14Z4LEQuc1Cd1FOTFbwoQiwUi/nnhjY
	DCFCa6LKd2eCn80CiWPIHguChQ1luU+waMX0c0AtAVg7L2gIGER5Zg5BZIdzG4+d
	Il7/DahjrV0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 83635B702D;
	Fri, 28 May 2010 19:56:01 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 948D1B702B; Fri, 28 May
 2010 19:55:55 -0400 (EDT)
In-Reply-To: <AANLkTinHLoYMgBawxmXpH5XSyJDb_743HEpfCmfqoRHu@mail.gmail.com>
 (Diane Gasselin's message of "Fri\, 28 May 2010 12\:27\:10 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 91ACA454-6AB4-11DF-9C14-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147941>

Diane Gasselin <diane.gasselin@ensimag.imag.fr> writes:

> Afterwards, we thought about working on git-merge.
> Actually, when having some local changes in some files
> that would be overwritten by merge, git-merge aborts giving the
> first file for which there is a problem.

That's a nice bite-sized problem to tackle.  Thanks (and thank you,
Matthieu).
