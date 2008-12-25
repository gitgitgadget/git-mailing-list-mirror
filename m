From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] GIT 1.6.1
Date: Thu, 25 Dec 2008 02:13:46 -0800
Message-ID: <7v3agca7fp.fsf@gitster.siamese.dyndns.org>
References: <7v7i5odams.fsf@gitster.siamese.dyndns.org>
 <20081225100033.GA8451@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 25 11:15:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFnFe-0006Ro-Re
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 11:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751777AbYLYKNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2008 05:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbYLYKNy
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 05:13:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58823 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751759AbYLYKNx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2008 05:13:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 578DE1B0B0;
	Thu, 25 Dec 2008 05:13:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 201AD1B0AF; Thu,
 25 Dec 2008 05:13:47 -0500 (EST)
In-Reply-To: <20081225100033.GA8451@b2j> (bill lam's message of "Thu, 25 Dec
 2008 18:00:33 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BA365BCC-D26C-11DD-9204-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103898>

bill lam <cbill.lam@gmail.com> writes:

> On ubuntu64 8.10, the NO_UINTMAX_T seems cause some trouble, I have to
> comment out the block (in the Makefile),
>
> fdef NO_UINTMAX_T
>  BASIC_CFLAGS += -Duintmax_t=uint32_t
> ndif
>
> to make a successful compilation. Does it happen to me only?

Nobody reported it since that was added about a month and half ago.

Why are you building with NO_UINTMAX_T to begin with?  Isn't ubuntu 8.10 a
recent enough platform that ships with modern enough header files that
define ANSI uintmax_t type?
