From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Init on push
Date: Sat, 08 Nov 2008 12:38:10 -0800
Message-ID: <7v3ai2c5sd.fsf@gitster.siamese.dyndns.org>
References: <200811081708.45672.robin.rosenberg.lists@dewire.com>
 <7viqqyc93w.fsf@gitster.siamese.dyndns.org> <gf4rf6$v52$1@ger.gmane.org>
 <200811082108.34535.fg@one2team.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Francis Galiegue <fg@one2team.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 21:39:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyub1-0001Tu-RH
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 21:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbYKHUid convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Nov 2008 15:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbYKHUic
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 15:38:32 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61972 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbYKHUic convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Nov 2008 15:38:32 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1C9AD94435;
	Sat,  8 Nov 2008 15:38:25 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C782794434; Sat, 
 8 Nov 2008 15:38:12 -0500 (EST)
In-Reply-To: <200811082108.34535.fg@one2team.com> (Francis Galiegue's message
 of "Sat, 8 Nov 2008 21:08:34 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 30E38F40-ADD5-11DD-AD79-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100423>

=46rancis Galiegue <fg@one2team.com> writes:

> Le Saturday 08 November 2008 21:06:01 Jakub Narebski, vous avez =C3=A9=
crit=C2=A0:
>> Junio C Hamano wrote:
>> >  - Teach "-D $there" option to "git init", which does an "mkdir -p=
 $it &&
>> >    chdird $it" before it does its work.
>>
>> Shouldn't it be "-C $there" (like make and tar)?
>
> I agree with that. It's pretty much a standard for quite a few "comma=
nd line=20
> people", insofar as I always look for such an option in case I want t=
o know=20
> whether a command has the ability to chdir() to a different directory=
 than=20
> the current one :p

In this particular case, it is not "chdir() before starting" but "mkdir
and then chdir() into it".  Using -C would be counterproductive.
