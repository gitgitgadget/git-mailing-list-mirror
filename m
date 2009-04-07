From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Mon, 06 Apr 2009 18:02:10 -0700
Message-ID: <7v8wmd46p9.fsf@gitster.siamese.dyndns.org>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
 <200904052358.53028.markus.heidelberg@web.de>
 <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com>
 <200904060117.24810.markus.heidelberg@web.de>
 <fabb9a1e0904051622k66352ea4v542ecd99bd5d9c6@mail.gmail.com>
 <20090406032457.GA14758@gmail.com>
 <7v63hie4yh.fsf@gitster.siamese.dyndns.org>
 <871vs5kjfw.fsf@krank.kagedal.org>
 <7vy6ud4otd.fsf@gitster.siamese.dyndns.org>
 <87skkligzb.fsf@krank.kagedal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	markus heidelberg <markus.heidelberg@web.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Tue Apr 07 03:04:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqzjL-0007cL-Pv
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 03:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752250AbZDGBCZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 21:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752561AbZDGBCZ
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 21:02:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45241 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753557AbZDGBCY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2009 21:02:24 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 02C0AA612F;
	Mon,  6 Apr 2009 21:02:21 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 40DD6A612B; Mon,
  6 Apr 2009 21:02:11 -0400 (EDT)
In-Reply-To: <87skkligzb.fsf@krank.kagedal.org> (David =?utf-8?Q?K=C3=A5ge?=
 =?utf-8?Q?dal's?= message of "Mon, 06 Apr 2009 23:56:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BF5F15E6-230F-11DE-8D80-BB14ECB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115896>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

>>    - when you want to work with both the index and the work tree at =
the
>>      same time, you say STAGEANDWORKTREE (the same disambiguation ca=
veat
>>      applies).
>
> No, where did this come from?

"git apply STAGEANDWORKTREE this.patch".  I do not want "for diff you c=
an
use these metavariables to name two things compared, but you can do so
only for diff".

>> Think.  What does "git log STAGE" mean?  Can you explain why it does=
 not
>> make any sense?
>
> As I already explained, you read way to much into my message.

I think the fundamental difference between us is that you are too attac=
hed
to the notion of "for diff you can use these metavariables to name two
things compared".  That by itself looks very nice if you only look at t=
he
diff command line, but I do not want "but you can do so only for diff, =
so
you have to unlearn the metavariables and do thing in different ways fo=
r
other commands" part.
