From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Sun, 05 Apr 2009 12:33:26 -0700
Message-ID: <7v7i1yrj3t.fsf@gitster.siamese.dyndns.org>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
 <7vmyausz3h.fsf@gitster.siamese.dyndns.org>
 <94a0d4530904051228m4e57ec90y810dded41f47e443@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 21:39:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqY81-0005n7-2g
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 21:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756813AbZDETde convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 15:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756770AbZDETdd
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 15:33:33 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54713 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345AbZDETdc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 15:33:32 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 929B7CB26;
	Sun,  5 Apr 2009 15:33:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EDA0CCB25; Sun, 
 5 Apr 2009 15:33:27 -0400 (EDT)
In-Reply-To: <94a0d4530904051228m4e57ec90y810dded41f47e443@mail.gmail.com>
 (Felipe Contreras's message of "Sun, 5 Apr 2009 22:28:24 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A4BA0F18-2218-11DE-A1ED-DD19768B9EAE-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115688>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> On Sun, Apr 5, 2009 at 10:02 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> This is the list of actions I've mapped:
>>>
>>> =C2=A0* add: git stage =3D git stage add (git add)
>>> =C2=A0* rm: (git rm --cached)
>>> =C2=A0* diff: (git rm --cached)
>>> =C2=A0* import: stage all files; modified, deleted, new
>>> =C2=A0* ls: (git ls-files --stage)
>>
>> I do not think these are good ideas at all, as it just spreads more
>> confusion, not less.
>
> Do you agree that there's already a lot of confusion? (stage, cache,
> index, etc.)
>
> And do you agree that many git newbies don't use the stage? Actually
> most of them don't even know what it is, and just do "git commit -a".
>
> If so, how do you think these issues should be handled?

Perhaps not spreading "stage" even wider?  That is the newest confusing
term that caused the most harm.
