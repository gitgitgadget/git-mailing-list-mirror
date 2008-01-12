From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config variable
Date: Sat, 12 Jan 2008 10:46:51 -0800
Message-ID: <7vwsqeubj8.fsf@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<1200022189-2400-2-git-send-email-mlevedahl@gmail.com>
	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>
	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>
	<7v63xzzszp.fsf@gitster.siamese.dyndns.org>
	<478855B5.9070600@gmail.com>
	<7vbq7ry405.fsf@gitster.siamese.dyndns.org>
	<47885B2C.8020809@gmail.com>
	<7v7iify2wm.fsf@gitster.siamese.dyndns.org>
	<4788BFA8.2030508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 19:47:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDlOC-0001Mf-FO
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 19:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbYALSrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 13:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754429AbYALSrA
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 13:47:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753848AbYALSq7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 13:46:59 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 51190504E;
	Sat, 12 Jan 2008 13:46:58 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D3910504C;
	Sat, 12 Jan 2008 13:46:53 -0500 (EST)
In-Reply-To: <4788BFA8.2030508@gmail.com> (Mark Levedahl's message of "Sat, 12
	Jan 2008 08:24:56 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70344>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Junio C Hamano wrote:
>> Sorry, I may be missing something.
>>
>> Even if you have a submodule, you can go there and that will be
>> a valid freestanding repository.  You can always be explicit,
>> bypassing any behaviour that defaults to 'origin' to avoid
>> ambiguity.
>>
> "git-submodule update" *requires* that origin is defined in all
> sub-modules. There is no way to avoid this behavior.

Ahh.

Does that suggest the new configuration thing is only about the
"submodule update" command, not "remotes.default" that affects
how the non-submodule merge and fetch works?
