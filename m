From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Default history simplification
Date: Fri, 20 Nov 2009 22:37:07 -0800
Message-ID: <7v8we0s7sc.fsf@alter.siamese.dyndns.org>
References: <ae09c2a40911191530y626dd035q90de0212e0b4b6d8@mail.gmail.com>
 <20091120095537.1909f6b6@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tommy Wang <subscription@august8.net>, git <git@vger.kernel.org>
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Sat Nov 21 07:37:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBjbH-0000Kj-M3
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 07:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbZKUGhM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Nov 2009 01:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbZKUGhL
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 01:37:11 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64406 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbZKUGhK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Nov 2009 01:37:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8B22EA073B;
	Sat, 21 Nov 2009 01:37:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jKuwRiOp2d+U
	Ngy6mekmgHHch60=; b=GWjZ2GIGhSKSHpr01AaAeYp3z5gn9BUGb54JqAd6sXP4
	+sVCrOOX96NYrty1ZiLonoSTIwiGcZLM6f4iUH6XC75WEY/LTaE+PKgo6ykeCXpt
	0GSlfOhVDaGboQgCVQ4naYRUDmGpq8jIIdrdH6C089U1SQnN1o1qIB0acWgEKe0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ffJyA9
	8eQcWSXFrr8vjpXQtSvtCJoo/xy6YtitASSdH2TVP1XsXc2/l1OkVeVKhCGT0hed
	wpp98ebaRk2TJEqZLDeRXbmu3mMcQmV2DXBuNCIWa9LV7PREXW0w9EHL1qHyl37y
	ShWOCzIse0eHylM4Pb2AJ++f8x9dr++0804WY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5BA8CA073A;
	Sat, 21 Nov 2009 01:37:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2FB14A0739; Sat, 21 Nov 2009
 01:37:08 -0500 (EST)
In-Reply-To: <20091120095537.1909f6b6@perceptron> ("Jan =?utf-8?Q?Kr=C3=BC?=
 =?utf-8?Q?ger=22's?= message of "Fri\, 20 Nov 2009 09\:55\:37 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4D86EFE0-D668-11DE-B719-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133392>

Jan Kr=C3=BCger <jk@jk.gs> writes:

> Tommy Wang <subscription@august8.net> wrote:
>> [...] I would love to simply use the rev-list built-in to
>> do my work for me; but I fear that I may have much too many path
>> limiters than the linux command-line can handle (which if I'm correc=
t,
>> can only take so many arguments).
>
> On my system, "only so many arguments" means about two megabytes wort=
h
> of command line.

Good point.

The command line limitation, even if it is very small, shouldn't be a
problem if Tommy is interested in recreating exactly what rev-list does=
=2E

If his tool that drives rev-list or log from the command line cannot wo=
rk
because his request overflows the command line, the same request will
overflow the command line for rev-list or log, so they wouldn't work
either.

=46or a more serious answer, see the other thread ;-).
