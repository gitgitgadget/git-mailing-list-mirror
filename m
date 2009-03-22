From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 13/16] t3700: Skip a test with backslashes in pathspec
Date: Sun, 22 Mar 2009 14:59:02 -0700
Message-ID: <7vr60pcj89.fsf@gitster.siamese.dyndns.org>
References: <cover.1237667830.git.j6t@kdbg.org>
 <6acd113f60d1b0e7926386f3aebe5d72ad362034.1237667830.git.j6t@kdbg.org>
 <7v3ad6cvub.fsf@gitster.siamese.dyndns.org> <200903221755.44642.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Mar 22 23:00:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlVih-0002AY-74
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 23:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756233AbZCVV7M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Mar 2009 17:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756041AbZCVV7K
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 17:59:10 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48262 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756108AbZCVV7I convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Mar 2009 17:59:08 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D2D4F89D2;
	Sun, 22 Mar 2009 17:59:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A038E89D1; Sun,
 22 Mar 2009 17:59:03 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AA297CA0-172C-11DE-B519-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114179>

Johannes Sixt <j6t@kdbg.org> writes:

> On Sonntag, 22. M=C3=A4rz 2009, Junio C Hamano wrote:
>> I do not think the justification for this change is explained well e=
nough.
>>
>> The test prepares a file whose name consists of "ef, oh, bra, oh, yo=
u,
>> ket, bee, ei and are" (no backslashes), and passes a filespec that q=
uotes
>> bra and ket with backslash so glob won't misinterpret as if we are a=
sking
>> to add "ef oh followed by either oh or you followed by bee ei are". =
 There
>> is no path that has a backslash in it involved.
>>
>> If this does not work on Windows, there is something else going on. =
 Is it
>> that the shell eats one level of backslash too much or something?
>
> I added these two paragraphs:

Thanks; pulled.
