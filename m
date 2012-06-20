From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] submodule: Tolerate auto/safecrlf when adding
 .gitmodules
Date: Wed, 20 Jun 2012 12:53:20 -0700
Message-ID: <7v1ul9vjyn.fsf@alter.siamese.dyndns.org>
References: <cover.1340202515.git.brad.king@kitware.com>
 <eebc8b3692f8fcb95cf75278f7c9f9982e8f2cd6.1340202515.git.brad.king@kitware.com> <4FE20DD3.6040607@web.de> <4FE21133.2030001@kitware.com> <20120620191132.GB31520@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 20 21:53:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShQxy-0003he-EY
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 21:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757959Ab2FTTxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jun 2012 15:53:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38554 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757953Ab2FTTxW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2012 15:53:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2C099E94;
	Wed, 20 Jun 2012 15:53:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gAYjYQ81ES/C02nqkQyO47VdXq4=; b=JKzuFZ
	fa++R9l9kEVz5YMW5c/+leYgmbjTOnQh7i1n0XjtegIwQwUU40RGpNXTOh0wPUd5
	JdUvcm2Tog8Ob/V+yk/XSIJY5oMAFh43G9UQUQyRC0/6ze855E4mOnHQx2yyPbnT
	qR+KDwurBOT+OYFUkgBB9vnRoCf3Yx9CcekoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FlsCb5e+ynm/eUy761D+/On85TfXF3UG
	Fqq5MIGRC5EtKBkV+gHmbDs+rwobv3xyhpnye89IVnrc6qahEoiMCEAx6Axkrjt8
	tdlkOdeHUxIpn8dGxTSeyJlyInv1hSRYR/6Cwsm+dngjAZO4ab3QK7g8SRH3kLYW
	J1neDoX8K1g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D74359E93;
	Wed, 20 Jun 2012 15:53:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D90E9E92; Wed, 20 Jun 2012
 15:53:21 -0400 (EDT)
In-Reply-To: <20120620191132.GB31520@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 20 Jun 2012 15:11:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 96AD28B6-BB11-11E1-9788-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200349>

Jeff King <peff@peff.net> writes:

> This is a git-specific file, and the format is
> dictated by git. We know that it's a text file, so why not help out the
> user? We should possibly do the same thing for .gitattributes and
> .gitignore.

OK.
