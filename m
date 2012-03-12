From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 00/10] Column display
Date: Sun, 11 Mar 2012 23:02:11 -0700
Message-ID: <7vd38iuzks.fsf@alter.siamese.dyndns.org>
References: <1330170078-29353-1-git-send-email-pclouds@gmail.com>
 <1330430331-19945-1-git-send-email-pclouds@gmail.com>
 <87ehtbb5x7.fsf@thomas.inf.ethz.ch>
 <CACsJy8BYDtAqJwAPK4nF+KvednNS8kX3TZGa+o-_=UsapA19oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 07:02:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6yKp-0000a7-0r
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 07:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343Ab2CLGCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 02:02:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63410 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552Ab2CLGCO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 02:02:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAAED3962;
	Mon, 12 Mar 2012 02:02:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DUCRUwTILecW825aEBDXourA58c=; b=AaIdeg
	Px4I1E6NkdhPO9WMSPO17JCZ7vGxttdIuOOzk5ODWVuX0Z95VOrMnOIGtSzaSN2a
	r/LeWkOqCVuABRDpfELRG+oTqQetMBFf1MpABT6W4A9rxA7hyJnxZ5L95JoyaHKp
	4RS2zNAGc+oMMZSUN7xS/azK44Titi3jsdqo4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S+bHBFoy7s/eyPOrbGdJHjHNTxB0FM8T
	liQHbq3csgB+05yQ5GQxgIzEkm4Oc/51eNRUvIhuQTP+HhubfYdpbpGCAokGy7L/
	p/dJcCLv4WGX8qhS7eFTq1THGV+dX551ryoSl5K7XEOKCvhKA9DZl8QPz4kqHhoX
	FN580lsXJvc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B1F053961;
	Mon, 12 Mar 2012 02:02:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2FB0A3960; Mon, 12 Mar 2012
 02:02:13 -0400 (EDT)
In-Reply-To: <CACsJy8BYDtAqJwAPK4nF+KvednNS8kX3TZGa+o-_=UsapA19oA@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sun, 11 Mar 2012 14:02:24 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E992B0BC-6C08-11E1-859B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192841>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2012/3/2 Thomas Rast <trast@inf.ethz.ch>:
>> I ran valgrind over the tests in pu, and I'm seeing these errors
>> ...
>> Can you look into it?
>
> Thanks. There is a bug in shrink_columns() that causes invalid access.
> It wil be fixed in the next reroll.

Thanks.  I thought this topic was the closest to completion and was
the only candidate for 1.7.10 among various topics with loose ends
you have in flight (even though it is way too late for 1.7.10 now).
