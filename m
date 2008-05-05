From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Documentation status
Date: Sun, 04 May 2008 21:27:18 -0700
Message-ID: <7vy76pnzo9.fsf@gitster.siamese.dyndns.org>
References: <20080502053051.c8066c4e.chriscool@tuxfamily.org>
 <200805030604.32123.chriscool@tuxfamily.org>
 <7vfxszuvs6.fsf@gitster.siamese.dyndns.org>
 <200805050548.58905.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	"Manoj Srivastava" <srivasta@ieee.org>,
	"Ping Yin" <pkufranky@gmail.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon May 05 06:28:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JssJK-0008Df-E7
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 06:28:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620AbYEEE1f convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 May 2008 00:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbYEEE1f
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 00:27:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbYEEE1e convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 May 2008 00:27:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 42E5626AB;
	Mon,  5 May 2008 00:27:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 592A826A8; Mon,  5 May 2008 00:27:22 -0400 (EDT)
In-Reply-To: <200805050548.58905.chriscool@tuxfamily.org> (Christian Couder's
 message of "Mon, 5 May 2008 05:48:58 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9440FE3C-1A5B-11DD-8AA7-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81228>

Christian Couder <chriscool@tuxfamily.org> writes:

> Le samedi 3 mai 2008, Junio C Hamano a =C3=A9crit :
>> Christian Couder <chriscool@tuxfamily.org> writes:
>> > About man page sections, Perl is consistent because every thing is=
 in
>> > section 1.
>>
>> I do not think it is a good example to follow, though.
>
> I agree.
>
>> > Now for git we already have git commands in section 1 and some
>> > other documentation (gitattributes, gitignore, gitmodules) in sect=
ion 5
>> > and "git" in section 7. Do we want to keep "git" alone in section =
7 and
>> > put tutorials in section 1 ? Or put everything in section 1 ?
>>
>> My preference is to move git(7) to git(1) because it is describing a
>> command at the end-user level (distros are much better than us to co=
me up
>> with a way to deal with conflict resolution between us and the other
>> git), keep file format description in section 5 (that's where they b=
elong
>> to).
>
> Ok, I will do that.
> Then what about tutorials (that I put in section 7) ?

Please step back a bit.  What's the reason why you need to make everyth=
ing
into manpages?
