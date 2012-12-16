From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git.c: add --index-file command-line option.
Date: Sat, 15 Dec 2012 21:59:39 -0800
Message-ID: <7vvcc2r0z8.fsf@alter.siamese.dyndns.org>
References: <1355484219-7517-1-git-send-email-manlio.perillo@gmail.com>
 <7vpq2btcqp.fsf@alter.siamese.dyndns.org> <50CCC73B.3070802@gmail.com>
 <7vliczrttq.fsf@alter.siamese.dyndns.org> <50CCF324.5060802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 07:00:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tk7Gh-00073p-J5
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 07:00:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133Ab2LPF7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 00:59:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33207 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955Ab2LPF7n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 00:59:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CBB0AFD8;
	Sun, 16 Dec 2012 00:59:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8HxJASSqr15GD54h0amc80BMW14=; b=TcCr3k
	zTQM8lCzUlUcIddgzjY8OI27nw2axxFZhjcia9vT7r3cxjYRhPhKLnX0h7MSFqkh
	/d1LA/w8V5mL4W5U7H3N10z4rfmSkhjQJLgUZGnzw5UpkeJamHlaNwm7JxzmUhnW
	uhgW1G+GwWim0LlsPPwLK74B4YRuLJ9DqcB+c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hs/lQm2e4pdcKJU/vNoN4RBpP9hzlKtw
	sLW/CmovBrMRgr6uUt/xbcqLycijxiUK1EZqd+J2F3Nv2pwizZVwM/+7O8r845s+
	8x30nnFp2Us6uaHY7CAPYnhAXxkXNC4P8DZ/ZhFWmJcq7PYtLw8HJnljkzSZ+/8H
	fAWKHE25Jyk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A954AFD7;
	Sun, 16 Dec 2012 00:59:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C2D8AFD6; Sun, 16 Dec 2012
 00:59:41 -0500 (EST)
In-Reply-To: <50CCF324.5060802@gmail.com> (Manlio Perillo's message of "Sat,
 15 Dec 2012 23:01:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C87CD8E4-4745-11E2-9B75-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211580>

I
Manlio Perillo <manlio.perillo@gmail.com> writes:

> This works with a shell.
> I'm using Python to write a custom git command.

I would be very surprised if Python lacked a way to spawn a
subprocess with an environment modified from the current process.
