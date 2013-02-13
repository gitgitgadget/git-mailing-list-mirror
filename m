From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git-aware HTTP transport docs
Date: Wed, 13 Feb 2013 07:29:03 -0800
Message-ID: <7vliasb5c0.fsf@alter.siamese.dyndns.org>
References: <20080826012643.GD26523@spearce.org> <511AED98.5070809@zytor.com>
 <CAP2yMaLz=vpOVgpxG0CwVwWD_sq+T9px3w0KXE7doUFhKqNZWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 16:29:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5eHC-000086-5Q
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 16:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934172Ab3BMP3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 10:29:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43592 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759742Ab3BMP3G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 10:29:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E263BC30;
	Wed, 13 Feb 2013 10:29:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7KUX0bBq7RsUEkCgsczGNhuQrB4=; b=eLPsbb
	x7zxR7tiOfFsDFHaUVNSKgV1qhdOkXW7BH2GqrcEg4I7zh4GAn/zawZwOTXLNQ1p
	yVKknHYPHlaJrjn7LMmWuAlT1NKrWzUHOHnyhykv8gOQnXrDeRr5AiV7qnGkIgkd
	1QsIVIiWyAPoYGdfh/gg2E3APjemrSvn7HXu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ycHZgpvENgn+HKd0lxBVPnmbTBVmVvN+
	TJKv9djh3H6UoqLKznKT5EKfERIn4ueaGhaqLUpHOhbfKIC9lZ8TcTO/qwIss9hw
	eZYXjPLTH7fwGjkzkhNap4F/Rlj3CZocio3NSaAoact0vPBrKjhLNJ7/6jWBKQbA
	kZ+2iuJq1qQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 81C83BC2E;
	Wed, 13 Feb 2013 10:29:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DBD48BC2B; Wed, 13 Feb 2013
 10:29:04 -0500 (EST)
In-Reply-To: <CAP2yMaLz=vpOVgpxG0CwVwWD_sq+T9px3w0KXE7doUFhKqNZWQ@mail.gmail.com> (Scott
 Chacon's message of "Tue, 12 Feb 2013 18:23:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 19BFF896-75F2-11E2-99CA-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216262>

Scott Chacon <schacon@gmail.com> writes:

> I don't believe it was ever merged into the Git docs.  I have a copy of it here:
>
> https://www.dropbox.com/s/pwawp8kmwgyc3w2/http-protocol.txt

Thanks for a pointer.  It seems that it wasn't in a shape ready to
be "merged" yet.

Does somebody want to pick it up and polish it further?
