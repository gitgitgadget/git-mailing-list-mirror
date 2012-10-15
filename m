From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] show color hints based on state of the git tree
Date: Mon, 15 Oct 2012 11:10:52 -0700
Message-ID: <7vlif7wqqb.fsf@alter.siamese.dyndns.org>
References: <7v8vbo7hmd.fsf@alter.siamese.dyndns.org>
 <20121005211030.GA5414@simaj.xs4all.nl>
 <507BC7F1.3080506@drmicha.warpmail.net> <507BD0EE.5000107@nieuwland.nl>
 <507BD3C1.4040807@drmicha.warpmail.net>
 <CAPc5daVUyAuznmrT+-yqvPR0gd38oiWmi2k+BFVV1s9ouMUt0Q@mail.gmail.com>
 <507C2882.2090406@nieuwland.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junio@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>, artagnon@gmail.com,
	spearce@spearce.org, schwab@linux-m68k.org,
	Simon Oosthoek <s.oosthoek@xs4all.nl>
To: Simon Oosthoek <soosthoek@nieuwland.nl>
X-From: git-owner@vger.kernel.org Mon Oct 15 20:11:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNp87-0002sP-3w
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 20:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754266Ab2JOSK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 14:10:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60630 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754076Ab2JOSKz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 14:10:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C1BB8D68;
	Mon, 15 Oct 2012 14:10:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kpY4uxODjoXHhZ5ovRApppRNusY=; b=tWeg8D
	q8DV/4NGl2+JUXQnrDyQj5JRjZ8WCiQHWmWyLg2TADYjVr9+rAGIZWWX10+N8JhK
	qlP7UIvVxo3S40XrMLHVSDk1Yd+hOp0Fwu4/wbijxKRTj1D1pdkL0R28l0az4iLm
	M0R9llmsqlLCCEZQ8pZM4ueG39oRTX2g1MZtk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cDsBm/Yydc5j1CgIMK8XMoYCFI1ibDcS
	Ov12VSAEHWsrDhciUiqTrsWuk89zXCHIIUG9lHKPHK6dExP2IBKFXA21x+HWmVUy
	jsADb0Cf+dd3IgKssR/s4r1ONcW3QTyWT5206yKuUbb4irw1U8VHUdK9hp7Y7nS6
	zX4L498g/c8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77A728D67;
	Mon, 15 Oct 2012 14:10:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E4C1C8D64; Mon, 15 Oct 2012
 14:10:53 -0400 (EDT)
In-Reply-To: <507C2882.2090406@nieuwland.nl> (Simon Oosthoek's message of
 "Mon, 15 Oct 2012 17:15:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A8D08752-16F3-11E2-BDF4-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207770>

Simon Oosthoek <soosthoek@nieuwland.nl> writes:

> The point of the thread and the patch was to enable the possibility of
> colors in the prompt without messing it up.
>
> The actual colors used are more or less how I'm used to it, but as you
> said they may not be suitable to everyone.
>
> @Junio, is this patch something you want to include as it is now (with
> the extra S that Michael pointed out) or do you want to wait for a
> discussion about which colors to use for which state?

The latter.

> I guess it could be quite a messy discussion, as you already hint at
> bikeshed colors, it's quite personal and subjective.

The choice of colours may be subjective, but you can just omit that
part, if there is already an existing choice made by others in
earlier changes like in "status" output.  As long as the subjective
choices in two systems that show similar information are consistent,
exact choice of colours does not matter that much.
