From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach merge the '[-e|--edit]' option
Date: Fri, 07 Oct 2011 12:40:59 -0700
Message-ID: <7vd3e8vbck.fsf@alter.siamese.dyndns.org>
References: <1318001347-11347-1-git-send-email-jaysoffian@gmail.com>
 <7vk48gwvyd.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dz7-tTdgT=cqoKhK+fAhmESLnp93yHyxOF_NOY5Wx01+w@mail.gmail.com>
 <CAG+J_DxrQCS8zn5KJ8HnpqShVbMw=zCbqDVa=w08EEibw=tsAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 07 21:41:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCGI7-0003ij-5t
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 21:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160Ab1JGTlE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Oct 2011 15:41:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37311 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753967Ab1JGTlC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Oct 2011 15:41:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99F0867E8;
	Fri,  7 Oct 2011 15:41:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=es5tbJ30yNFBBGeMX5UgR+FCDSY=; b=j0I7bA
	APlLAN9DFlwgAQdZeadbSFFzVS1+Jr92uIgq0Gdr2qUnfyUA5LDW1kxw2lvxDHoO
	SFRycpkK+WniQLIWJlT3SZ2xNlBoKCnjfzxNNy1U7k4IxF6RtEI6Y+1xjzT0dsHZ
	xjbV35M438/n2/J1EeulEE0p8elmU5aV/qPYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b+lvZVb6uWdBpFrWwtQxku3808bgOw0P
	a+DDXGpmfFgzHOe4CF+8zthVv3b9HWAWjPVz5/CY7spr7BtwFdC/+ZNj9AOxK3fg
	Bx6zNvBbz3O6MSPjPLf/M0SDRwkR3AtXDsXSE9howDG5/oo2NU9uLVVyXwjoFCcC
	G8zRG1o4rbU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EF8A67E5;
	Fri,  7 Oct 2011 15:41:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C12767E0; Fri,  7 Oct 2011
 15:41:00 -0400 (EDT)
In-Reply-To: <CAG+J_DxrQCS8zn5KJ8HnpqShVbMw=zCbqDVa=w08EEibw=tsAA@mail.gmail.com> (Jay
 Soffian's message of "Fri, 7 Oct 2011 15:07:42 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4933BB8C-F11C-11E0-BB44-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183100>

Jay Soffian <jaysoffian@gmail.com> writes:

> The other inconsistencies I'm aware of between "merge --no-commit &&
> commit" vs "merge" on a clean merge are:

Perhaps you would want to add these to a list of todo items when gitwiki
comes back.
