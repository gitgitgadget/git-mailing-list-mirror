From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Wait for git diff to finish in git difftool
Date: Wed, 22 Apr 2009 11:59:38 -0700
Message-ID: <7vr5zk346d.fsf@gitster.siamese.dyndns.org>
References: <81b0412b0904220027t7afd1ed7xc57c479ef8cdb6b9@mail.gmail.com>
 <20090422082652.GA32698@gmail.com>
 <81b0412b0904220404o30ce1413kcc4dcea1fa822841@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	charles@hashpling.org, markus.heidelberg@web.de
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:02:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwhhq-0005PW-S6
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 21:02:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996AbZDVS7w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2009 14:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751878AbZDVS7w
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 14:59:52 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55727 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbZDVS7v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2009 14:59:51 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 23DA8AC8C8;
	Wed, 22 Apr 2009 14:59:50 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A7524AC8C7; Wed,
 22 Apr 2009 14:59:40 -0400 (EDT)
In-Reply-To: <81b0412b0904220404o30ce1413kcc4dcea1fa822841@mail.gmail.com>
 (Alex Riesen's message of "Wed, 22 Apr 2009 13:04:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C015621C-2F6F-11DE-A33F-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117228>

Alex Riesen <raa.lkml@gmail.com> writes:

> 2009/4/22 David Aguilar <davvid@gmail.com>:
>> On =C2=A00, Alex Riesen <raa.lkml@gmail.com> wrote:
>
> I wasn't born on 0th.
>
>>
>> For whatever it's worth,
>>
>> Acked-by: David Aguilar <davvid@gmail.com>
>
> Yes, FWIW. I intentionally stopped signing off patches for
> Windows, ActiveState Perl and Cygwin: they usually harm the
> rest of the world, while just allowing Windows users limp along.

I have to wonder if you are doing that with the full understanding of w=
hat
Signed-off-by means.  I do not think the provenance of your patch is
affected by your distaste towards the system it has effects in any way.
