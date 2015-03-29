From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse-options: fix the description of defval
Date: Sun, 29 Mar 2015 11:18:47 -0700
Message-ID: <xmqqoanby8e0.fsf@gitster.dls.corp.google.com>
References: <E8C3474A-5A3A-4A51-A798-84FB9AD46A9F@gmail.com>
	<CACRoPnTjAu_pyPp2TXZGou=H8mkXBmQqgxGNusjW6u8peEfw6Q@mail.gmail.com>
	<xmqqsicnya81.fsf@gitster.dls.corp.google.com>
	<BE8DB6BF-DB95-4D9B-A01B-3D3BCE4C3C9C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>
To: Ivan Ukhov <ivan.ukhov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 29 20:19:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YcHnS-0004A5-U1
	for gcvg-git-2@plane.gmane.org; Sun, 29 Mar 2015 20:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbbC2SSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2015 14:18:50 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54867 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752691AbbC2SSu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2015 14:18:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4C7A442D49;
	Sun, 29 Mar 2015 14:18:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qsZ6YeuiFFLJKqwHxe81YxgrPsM=; b=Bq9PXt
	z/j/w6ehLZwFYLFRSevlDmofWuhiJI08+B3tA5Rz6HoAGcyl65S3Ccf5apXLnquw
	kgUaZEuCDPo2A9t6BYx71bfYtLbm655jo59I2W578PqnelboNbAndB+hXFlrTb50
	4btd7fv3mdyhZFvxGjyyVbyL2bG58DBym2H4I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j6WaVWU1Hj8ZGiTRK5mh78zLpcDZf5Z5
	CrAHWGx53IvuWrtX71B0gWLNHokrfDKKyYlYs2ukyaH+fleuP5K+gTmFfkFqj3bK
	873JFSCkibYXM2gvO/+Ec2n6gref79OaoFxMwEwyW5h6wZH3XKJFai7bEBAp2uym
	3Y9d5F9nRS0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4544342D48;
	Sun, 29 Mar 2015 14:18:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF2BF42D47;
	Sun, 29 Mar 2015 14:18:48 -0400 (EDT)
In-Reply-To: <BE8DB6BF-DB95-4D9B-A01B-3D3BCE4C3C9C@gmail.com> (Ivan Ukhov's
	message of "Sun, 29 Mar 2015 20:02:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0B8C30E0-D640-11E4-9D2F-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266444>

Ivan Ukhov <ivan.ukhov@gmail.com> writes:

> Hello Junio,
>
>
> Yes, actually my intention to fix that comment was solely based on its
> content. I saw that the elements in the first set, {BIT,SET_INT}, did
> not match the elements in the second, {mask,integer,pointer}. Then I
> found that commit removing OPT_SET_PTR, and “pointer” seemed to be a
> leftover, which I decided to eliminate. My commit message was saying
> something different, I should admit)
>
> I totally agree with your about mentioning only the general principle
> and leaving details to particular macros.
>
>
> Regards,
> Ivan

OK, lest we forget, please send an updated patch marked as v2 with
proposed commit log message that does not say something different,
then ;-)

Thanks.
